install:
	cp -v metar-map.service /lib/systemd/system/metar-map.service && systemctl daemon-reload
