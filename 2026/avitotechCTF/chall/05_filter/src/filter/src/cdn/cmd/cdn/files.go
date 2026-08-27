package main

import (
	"fmt"
	"io"
	"net/http"
	"net/url"
	"path"
	"sort"
	"strings"
	"time"
)

type FastFileServer struct {
	Root http.FileSystem
}

func (f FastFileServer) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if r.Method != "GET" {
		w.WriteHeader(405)
		return
	}

	upath := r.URL.Path
	if !strings.HasPrefix(upath, "/") {
		upath = "/" + upath
		r.URL.Path = upath
	}
	upath = path.Clean(upath)

	file, err := f.Root.Open(upath)
	if err != nil {
		w.Write([]byte(err.Error()))
		w.WriteHeader(400)
		return
	}
	defer file.Close()

	stat, err := file.Stat()
	if err != nil {
		w.Write([]byte(err.Error()))
		w.WriteHeader(400)
		return
	}

	if stat.IsDir() {
		printDirList(file, upath, w)
	} else {
		sendFile(file, w)
	}
}

var htmlReplacer = strings.NewReplacer(
	"&", "&amp;",
	"<", "&lt;",
	">", "&gt;",
	`"`, "&#34;",
	"'", "&#39;",
)

const dirListCSS = `
:root{color-scheme:light dark;--bg:#fbfbfd;--fg:#1d1d1f;--muted:#86868b;--line:#e6e6ea;--hover:#f0f0f5;--accent:#e39d00}
@media(prefers-color-scheme:dark){:root{--bg:#0b0b0d;--fg:#f5f5f7;--muted:#8a8a8f;--line:#1e1e22;--hover:#161619;--accent:#bf8316}}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);font:15px/1.5 -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Helvetica,Arial,sans-serif;-webkit-font-smoothing:antialiased}
.wrap{max-width:920px;margin:0 auto;padding:48px 24px 96px}
header{display:flex;align-items:center;gap:12px;margin-bottom:28px}
.logo{width:28px;height:28px;border-radius:7px;background:var(--accent);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:14px;flex:0 0 auto}
.brand{font-weight:600;letter-spacing:-.01em;line-height:1.1}
.brand small{display:block;font-weight:400;color:var(--muted);font-size:12px;letter-spacing:0}
nav{font-size:13px;color:var(--muted);margin-bottom:20px;word-break:break-all}
nav a{color:var(--accent);text-decoration:none}
nav a:hover{text-decoration:underline}
.panel{border:1px solid var(--line);border-radius:14px;overflow:hidden;background:color-mix(in srgb,var(--bg) 92%,var(--fg) 2%)}
.row{display:grid;grid-template-columns:1fr 130px 190px;align-items:center;gap:16px;padding:11px 18px;border-top:1px solid var(--line);text-decoration:none;color:inherit}
.row:first-child{border-top:none}
.row:hover{background:var(--hover)}
.row .meta{color:var(--muted);font-size:13px;font-variant-numeric:tabular-nums;text-align:right}
.head{color:var(--muted);font-size:11px;text-transform:uppercase;letter-spacing:.06em;background:transparent}
.head:hover{background:transparent}
.name{display:flex;align-items:center;gap:11px;min-width:0}
.name span{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.ic{width:18px;height:18px;flex:0 0 auto;color:var(--muted)}
.dir .ic{color:var(--accent)}
.up{color:var(--muted)}
footer{margin-top:22px;color:var(--muted);font-size:12px;text-align:center}
@media(max-width:560px){.row{grid-template-columns:1fr auto;gap:8px}.row .size{display:none}}
`

const (
	iconDir  = `<svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M3 7a2 2 0 0 1 2-2h4l2 2h8a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>`
	iconFile = `<svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M14 3H7a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V8z"/><path d="M14 3v5h5"/></svg>`
	iconUp   = `<svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M9 15l-6-6 6-6"/><path d="M3 9h11a6 6 0 0 1 6 6v6"/></svg>`
)

func humanSize(n int64) string {
	const unit = 1024
	if n < unit {
		return fmt.Sprintf("%d B", n)
	}
	div, exp := int64(unit), 0
	for x := n / unit; x >= unit; x /= unit {
		div *= unit
		exp++
	}
	return fmt.Sprintf("%.1f %cB", float64(n)/float64(div), "KMGTPE"[exp])
}

func printDirList(file http.File, upath string, w http.ResponseWriter) {
	dirs, err := file.Readdir(-1)
	if err != nil {
		w.Write([]byte(err.Error()))
		w.WriteHeader(400)
		return
	}

	sort.Slice(dirs, func(i, j int) bool {
		if dirs[i].IsDir() != dirs[j].IsDir() {
			return dirs[i].IsDir()
		}
		return strings.ToLower(dirs[i].Name()) < strings.ToLower(dirs[j].Name())
	})

	dir := upath
	if !strings.HasSuffix(dir, "/") {
		dir += "/"
	}

	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	fmt.Fprint(w, "<!doctype html>\n")
	fmt.Fprint(w, "<meta charset=\"utf-8\">\n")
	fmt.Fprint(w, "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n")
	fmt.Fprintf(w, "<title>Index of %s</title>\n", htmlReplacer.Replace(dir))
	fmt.Fprintf(w, "<style>%s</style>\n", dirListCSS)

	fmt.Fprint(w, "<div class=wrap>\n")
	fmt.Fprint(w, "<header><div class=logo>C</div><div class=brand>Comb Delivery Network<small>accelerated file delivery</small></div></header>\n")

	fmt.Fprint(w, "<nav><a href=\"/static/\">/</a>")
	if trimmed := strings.Trim(dir, "/"); trimmed != "" {
		acc := "/"
		for _, seg := range strings.Split(trimmed, "/") {
			acc += seg + "/"
			fmt.Fprintf(w, "<a href=\"%s\">%s</a>/", (&url.URL{Path: acc}).String(), htmlReplacer.Replace(seg))
		}
	}
	fmt.Fprint(w, "</nav>\n")

	fmt.Fprint(w, "<div class=panel>\n")
	fmt.Fprint(w, "<div class=\"row head\"><div class=name>Name</div><div class=\"meta size\">Size</div><div class=meta>Modified</div></div>\n")

	if dir != "/" {
		fmt.Fprintf(w, "<a class=row href=\"../\"><div class=name>%s<span class=up>Parent directory</span></div><div class=\"meta size\">&mdash;</div><div class=meta>&mdash;</div></a>\n", iconUp)
	}

	for _, d := range dirs {
		name := d.Name()
		icon := iconFile
		class := "row"
		size := humanSize(d.Size())
		if d.IsDir() {
			name += "/"
			icon = iconDir
			class = "row dir"
			size = "&mdash;"
		}
		href := url.URL{Path: name}
		fmt.Fprintf(w, "<a class=\"%s\" href=\"%s\"><div class=name>%s<span>%s</span></div><div class=\"meta size\">%s</div><div class=meta>%s</div></a>\n",
			class, href.String(), icon, htmlReplacer.Replace(name), size, d.ModTime().Format(time.RFC822))
	}

	fmt.Fprint(w, "</div>\n")
	fmt.Fprintf(w, "<footer>%d item(s)</footer>\n", len(dirs))
	fmt.Fprint(w, "</div>\n")
}

func sendFile(file http.File, w http.ResponseWriter) {
	io.Copy(w, file)
}
