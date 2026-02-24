# Hướng dẫn đóng góp — CaramOS

Cảm ơn bạn đã quan tâm đến CaramOS! Tài liệu này mô tả kiến trúc dự án, cách build ISO, quy trình phát triển, và cách đóng góp.

> [README tiếng Việt](README.md) · [English](CONTRIBUTING_EN.md)

---

## Mục lục

- [Kiến trúc dự án](#kiến-trúc-dự-án)
- [Build ISO](#build-iso)
- [Cách đóng góp](#cách-đóng-góp)
- [Quy trình phát triển](#quy-trình-phát-triển)
- [Tiêu chuẩn code](#tiêu-chuẩn-code)
- [Báo lỗi & đề xuất](#báo-lỗi--đề-xuất)

---

## Kiến trúc dự án

CaramOS = **Ubuntu base** + **Linux Mint tools** + **CaramOS customization**.

```
Ubuntu archive (kernel, systemd, libs)
     ↓
+ Linux Mint repo (mintupdate, nemo, cinnamon, timeshift...)
     ↓
+ CaramOS hooks (Chrome, ChromeOS theme, Việt hoá...)
     ↓
= CaramOS ISO
```

### Cấu trúc thư mục

```
CaramOS/
├── auto/                                  # live-build auto scripts
│   ├── config                             # Cấu hình build (base, arch, mirror, Secure Boot)
│   ├── build                              # lb build + logging
│   └── clean                              # lb clean
│
├── config/
│   ├── archives/                          # APT repos bổ sung
│   │   ├── linuxmint.list.chroot          # Repo Linux Mint (Wilma)
│   │   └── linuxmint.list.binary
│   ├── package-lists/
│   │   └── caramos.list.chroot            # Package cài vào ISO
│   ├── packages.chroot/                   # File .deb local để cài
│   ├── hooks/live/                        # Script chạy trong chroot khi build
│   │   ├── 0050-mint-base.hook.chroot     # Import Mint key + cài Mint tools
│   │   └── 0100-caramos-setup.hook.chroot # Chrome, theme, icon, cursor, locale
│   ├── includes.chroot/                   # Overlay → / của ISO
│   │   ├── etc/sddm.conf.d/              # SDDM login screen
│   │   ├── etc/skel/.config/              # Config mặc định user mới
│   │   │   ├── cinnamon/                  # Panel layout Chrome OS
│   │   │   ├── fcitx5/                    # Bộ gõ tiếng Việt
│   │   │   ├── autostart/                 # Flameshot screenshot
│   │   │   └── mimeapps.list              # Chrome mặc định
│   │   └── usr/share/
│   │       ├── glib-2.0/schemas/          # Dconf (theme, icon, font...)
│   │       ├── backgrounds/caramos/       # Hình nền
│   │       └── pixmaps/                   # Logo
│   ├── includes.binary/                   # File trên ISO (ngoài filesystem)
│   └── preseed/                           # Auto-answer installer
│
├── debian/                                # Debian packaging → .deb
│   ├── control, changelog, rules
│   ├── install                            # File mapping
│   └── postinst                           # Post-install hook
│
├── Makefile                               # make build / clean / deb
└── README.md, CONTRIBUTING.md, LICENSE
```

### Hook scripts — Trình tự chạy

| Hook | Chạy khi | Làm gì |
|---|---|---|
| `0050-mint-base` | Sau bootstrap | Import Mint GPG key, `apt-get update`, cài mintupdate, mintsystem, timeshift, warpinator... |
| `0100-caramos-setup` | Sau 0050 | Cài Chrome .deb, ChromeOS theme, Tela icon, Bibata cursor, gỡ bloat, set locale VI, cài font Be Vietnam Pro |

### Config overlay — File nào đi đâu

| Trong repo | Đích trên ISO |
|---|---|
| `config/includes.chroot/etc/sddm.conf.d/` | `/etc/sddm.conf.d/` |
| `config/includes.chroot/etc/skel/` | `/etc/skel/` |
| `config/includes.chroot/usr/share/glib-2.0/schemas/` | `/usr/share/glib-2.0/schemas/` |
| `config/includes.chroot/usr/share/backgrounds/` | `/usr/share/backgrounds/` |

---

## Build ISO

### Yêu cầu

- Máy chạy **Ubuntu 22.04+** hoặc **Linux Mint 21+**
- Khoảng **10 GB** dung lượng trống
- Kết nối internet

### Lệnh build

```bash
# 1. Cài công cụ (lần đầu)
sudo apt install live-build debootstrap git

# 2. Clone repo
git clone https://github.com/VN-Linux-Family/CaramOS.git
cd CaramOS

# 3. Build ISO (1 lệnh duy nhất)
make build
```

Chờ **15-30 phút** → ra file `.iso` → ghi USB → boot.

### Build .deb settings package

```bash
make deb    # → caramos-default-settings.deb
```

### Ghi USB

```bash
sudo dd if=*.iso of=/dev/sdX bs=4M status=progress
# Hoặc dùng Balena Etcher (GUI)
```

### Test trong VM

```bash
# QEMU
qemu-system-x86_64 -m 4G -cdrom *.iso -boot d -enable-kvm

# Hoặc dùng VirtualBox / GNOME Boxes
```

---

## Cách đóng góp

### Bạn có thể giúp gì?

| Vai trò | Công việc | Yêu cầu |
|---|---|---|
| **Tester** | Test ISO trên nhiều loại máy, báo lỗi | Có máy tính để test |
| **Designer** | Wallpaper, icon, theme, branding | Biết thiết kế đồ hoạ |
| **Developer** | Script, hook, config | Bash, biết live-build |
| **Writer** | Tài liệu hướng dẫn, dịch thuật | Viết tiếng Việt/Anh tốt |

### Quy trình đóng góp code

1. **Fork** repo về tài khoản GitHub
2. **Clone** về máy:
   ```bash
   git clone https://github.com/<your-username>/CaramOS.git
   cd CaramOS
   ```
3. **Tạo branch** mới:
   ```bash
   git checkout -b feature/ten-tinh-nang
   ```
4. **Code** và commit:
   ```bash
   git commit -m "feat: mô tả ngắn gọn"
   ```
5. **Push** và tạo **Pull Request**

### Quy tắc Pull Request

- 1 PR = 1 tính năng hoặc 1 bug fix
- Mô tả rõ PR làm gì và tại sao
- Đảm bảo đã test trước khi tạo PR
- Chờ ít nhất 1 người review

---

## Quy trình phát triển

### Branch strategy

```
main            ← Bản ổn định, build ISO phát hành
├── develop     ← Nhánh phát triển chính
├── feature/*   ← Tính năng mới
├── fix/*       ← Sửa lỗi
└── release/*   ← Chuẩn bị phát hành
```

### Versioning — Semantic Versioning

```
CaramOS X.Y.Z
X = Major   Y = Minor   Z = Patch

0.1.0  — Beta đầu tiên
1.0.0  — Phát hành chính thức
```

---

## Tiêu chuẩn code

### Commit message — [Conventional Commits](https://www.conventionalcommits.org/)

```
feat:     tính năng mới
fix:      sửa lỗi
docs:     tài liệu
chore:    build, config, CI
brand:    wallpaper, logo, theme
```

### Ngôn ngữ

| Ngữ cảnh | Ngôn ngữ |
|---|---|
| Tên biến, hàm, comment | Tiếng Anh |
| Commit, Issue, PR | Tiếng Việt hoặc Anh |
| UI, tài liệu user | Tiếng Việt |

### Bash (hook scripts)

```bash
#!/bin/bash
set -e

# Comment giải thích mỗi block
echo "[CaramOS] Installing..."
apt-get install -y package-name
```

---

## Báo lỗi & đề xuất

Tạo [Issue trên GitHub](https://github.com/VN-Linux-Family/CaramOS/issues):

**Báo lỗi:** Mô tả lỗi → Cách tái hiện → Kết quả mong đợi → Thông tin hệ thống → Log/ảnh

**Đề xuất tính năng:** Mô tả → Lý do → Giải pháp đề xuất

---

<p align="center">
  <strong>CaramOS</strong> — Sweet & Simple Linux<br>
  <a href="https://github.com/VN-Linux-Family/CaramOS">github.com/VN-Linux-Family/CaramOS</a>
</p>
