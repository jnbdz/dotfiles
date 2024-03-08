ST_VERSION = 0.8.4
DWM_VERSION = 6.2

.PHONY: all
all: dwm st

.PHONY: dwm
dwm:
	dnf install libXft
	curl -L https://github.com/jnbdz/dwm/releases/download/v$(DWM_VERSION)/dwm-v$(DWM_VERSION).tar.gz > dwm-v$(DWM_VERSION).tar.gz

.PHONY: st
st:
	curl -L https://github.com/jnbdz/st/releases/download/v$(ST_VERSION)/st-v$(ST_VERSION).tar.gz > st-v$(ST_VERSION).tar.gz
