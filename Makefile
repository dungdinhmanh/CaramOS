.PHONY: all config build clean

all: build

config:
	lb config

build: config
	sudo lb build

clean:
	sudo lb clean
	rm -f *.iso *.log

# Build the caramos-default-settings .deb package
deb:
	dpkg-buildpackage -b -us -uc

help:
	@echo "CaramOS Build System (live-build)"
	@echo ""
	@echo "  make build    — Build CaramOS ISO (requires sudo)"
	@echo "  make clean    — Clean build artifacts"
	@echo "  make deb      — Build caramos-default-settings.deb"
	@echo "  make help     — Show this help"
	@echo ""
	@echo "Requirements:"
	@echo "  sudo apt install live-build debootstrap"
