## Service file
put in **/etc/sv/mihomo/run**

```

#!/bin/sh
# runit run script for mihomo

# give network a moment (systemd had After=network.target etc.)
sleep 1

# set ulimits (soft limits)
ulimit -u 500                # max user processes
ulimit -n 1000000            # max open files

# export any needed environment variables here, e.g.:
# export MIHOMO_CONFIG_DIR=/etc/mihomo

# drop privileges here if needed (run as non-root by svscan's owner or use setuid-wrapper)
exec 2>&1
exec /home/dallas/opt/bin/mohomo -d /home/dallas/opt/config/

```
* Need to run **chmod +x /etc/sv/mihomo/run**
---

then create the log file **/etc/sv/mihomo/log/run**
```

#!/bin/sh
exec svlogd -tt /var/log/mihomo

```
* Need to run **chmod +x **/etc/sv/mihomo/log/run**

--- 
Then:
- mkdir -p /var/log/mihomo
- chown root:root /var/log/mihomo
- chmod 750 /var/log/mihomo

---
Give binary permissions

```

sudo setcap 'cap_net_admin,cap_net_raw,cap_bind_service,cap_sys_time,cap_sys_ptrace,cap_dac_read_search,cap_dac_override+ep' /home/dallas/opt/bin/mihomo

```

ln -s /etc/sv/mihomo /service/mihomo
ln -s /etc/sv/mihomo/log /service/mihomo/log

