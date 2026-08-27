package checker

import (
	"bytes"
	"net/http"
	"strings"
)

var (
	FLAG_PREFIX     = []byte("avito{")
	FLAG_PREFIX_STR = string(FLAG_PREFIX)
)

func Check(body []byte) bool {
	return bytes.Contains(body, FLAG_PREFIX)
}

func CheckValues(values []http.Header) bool {
	for _, table := range values {
		for _, strs := range table {
			for _, value := range strs {
				if strings.Contains(value, FLAG_PREFIX_STR) {
					return true
				}
			}
		}
	}
	return false
}
