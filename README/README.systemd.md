# Dirs

## Envs
/etc/default

## Services
/etc/systemd/system/

# Controls

## Update systemd
systemctl daemon-reload

## Start
systemctl start pik-logistic-etl.service

## Status
systemctl status pik-logistic-etl.service

## View log
journalctl -u pik-logistic-etl.service -f

## Enable boot time startup
systemctl enable my.service

