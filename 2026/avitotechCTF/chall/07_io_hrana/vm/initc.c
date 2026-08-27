#define _GNU_SOURCE
#include <sys/prctl.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/mount.h>
#include <sys/reboot.h>
int main(void){
    mount("none","/proc","proc",0,0);
    mount("none","/sys","sysfs",0,0);
    mount("none","/dev","devtmpfs",0,0);
    const char* names[] = {"openrc","runit","s6-svscan","sysvinit","init","dinit",
        "procd","busybox","upstart","s6","finit","sinit","minit","epoch","runit-init",
        "openrc-init","launchd","daemontools","perp","nosh","shepherd", NULL};
    for(int i=0; names[i]; i++){
        prctl(PR_SET_NAME, names[i], 0,0,0);
        char cmd[256];
        snprintf(cmd,sizeof(cmd),"echo '########## PID1=%s'; printf 'testinput\\n' | /io_hrana.elf 2>&1 | grep -aE 'CHECK|cannot|Ewww|won|robot|camel|badger|honey|WORTHY|not a|reveal|avito|distribution|\\[-\\]|\\[+\\] i|worthy|prove'; echo EXIT=${PIPESTATUS:-$?}", names[i]);
        system(cmd);
    }
    reboot(RB_POWER_OFF);
    return 0;
}
