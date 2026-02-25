.PHONY: build release clean help

build:
	@echo "CaramOS Build — Dev mode (lz4, nhanh)"
	sudo ./build.sh $(ISO)

release:
	@echo "CaramOS Build — Release mode (xz, nhỏ)"
	sudo ./build.sh --release $(ISO)

clean:
	sudo ./build.sh --clean

help:
	@echo "CaramOS Build System (ISO Remaster)"
	@echo ""
	@echo "  make build                — Dev build (lz4, ~1 phút nén)"
	@echo "  make release              — Release build (xz, ~10 phút, ISO nhỏ)"
	@echo "  make build ISO=file.iso   — Build từ ISO có sẵn"
	@echo "  make clean                — Xoá build (giữ Mint ISO)"
	@echo "  make help                 — Hiển thị trợ giúp"
