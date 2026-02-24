# Hướng dẫn đóng góp — CaramOS

Cảm ơn bạn đã quan tâm đến CaramOS! Tài liệu này mô tả quy trình phát triển, tiêu chuẩn code, và cách đóng góp vào dự án.

> [README tiếng Việt](README.md) · [English README](README_EN.md)

---

## Mục lục

- [Quy tắc ứng xử](#quy-tắc-ứng-xử)
- [Cách đóng góp](#cách-đóng-góp)
- [Quy trình phát triển](#quy-trình-phát-triển)
- [Tiêu chuẩn ngôn ngữ](#tiêu-chuẩn-ngôn-ngữ)
- [Báo lỗi](#báo-lỗi)
- [Đề xuất tính năng](#đề-xuất-tính-năng)

---

## Quy tắc ứng xử

Xem [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md). Tóm lại:

- Tôn trọng mọi thành viên
- Không phân biệt đối xử
- Tập trung vào xây dựng, không phá hoại
- Phản hồi mang tính xây dựng

---

## Cách đóng góp

### Bạn có thể giúp gì?

| Vai trò | Công việc | Yêu cầu |
|---|---|---|
| **Tester** | Test ISO trên nhiều loại máy, báo lỗi | Có máy tính để test |
| **Designer** | Wallpaper, icon, theme, branding | Biết thiết kế đồ hoạ |
| **Developer** | Viết script, Caram Center, Welcome App | Python, Bash, GTK |
| **Writer** | Tài liệu hướng dẫn, dịch thuật | Viết tiếng Việt/Anh tốt |
| **Packager** | Đóng gói app, viết YAML cho Caram Center | Biết Wine/Bottles/Flatpak |

### Quy trình đóng góp code

1. **Fork** repo về tài khoản GitHub của bạn
2. **Clone** về máy:
   ```bash
   git clone https://github.com/<your-username>/CaramOS.git
   cd CaramOS
   ```
3. **Tạo branch** mới từ `main`:
   ```bash
   git checkout -b feature/ten-tinh-nang
   ```
4. **Code** và commit:
   ```bash
   git add .
   git commit -m "feat: mô tả ngắn gọn"
   ```
5. **Push** lên fork:
   ```bash
   git push origin feature/ten-tinh-nang
   ```
6. Tạo **Pull Request** trên GitHub

### Quy tắc Pull Request

- 1 PR = 1 tính năng hoặc 1 bug fix
- Mô tả rõ PR làm gì và tại sao
- Đảm bảo đã test trước khi tạo PR
- Nếu PR liên quan đến UI, đính kèm ảnh chụp màn hình
- Chờ ít nhất 1 người review và approve

---

## Quy trình phát triển

### Branch strategy

```
main            ← Bản ổn định, dùng để build ISO phát hành
├── develop     ← Nhánh phát triển chính, merge feature vào đây
├── feature/*   ← Tính năng mới (feature/caram-center, feature/ai-assistant)
├── fix/*       ← Sửa lỗi (fix/wifi-driver, fix/locale-bug)
└── release/*   ← Chuẩn bị phát hành (release/0.1-beta, release/1.0)
```

### Quy trình release

```
1. Phát triển trên develop
2. Khi đủ tính năng → tạo branch release/x.y
3. Test kỹ trên release branch
4. Merge vào main → tag version → build ISO → phát hành
```

### Versioning

Dùng **Semantic Versioning**:

```
CaramOS X.Y.Z

X = Major  — thay đổi lớn, có thể không tương thích ngược
Y = Minor  — tính năng mới, tương thích ngược
Z = Patch  — sửa lỗi

Ví dụ:
  0.1.0  — Beta đầu tiên
  0.2.0  — Thêm Caram Center GUI
  1.0.0  — Phát hành chính thức
  1.0.1  — Sửa lỗi WiFi driver
  1.1.0  — Thêm AI offline
```

---

## Tiêu chuẩn ngôn ngữ

### Commit message

Dùng format [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <mô tả ngắn gọn>

type:
  feat     — tính năng mới
  fix      — sửa lỗi
  docs     — tài liệu
  style    — format code (không ảnh hưởng logic)
  refactor — tái cấu trúc code
  test     — thêm/sửa test
  chore    — việc lặt vặt (build, config, CI)
  brand    — branding (wallpaper, logo, theme)

Ví dụ:
  feat: thêm Caram Center GUI
  fix: sửa lỗi bộ gõ fcitx5-lotus không bật mặc định
  docs: thêm hướng dẫn cài đặt dual-boot
  brand: cập nhật wallpaper mặc định
```

### Ngôn ngữ trong code

| Ngữ cảnh | Ngôn ngữ | Ví dụ |
|---|---|---|
| **Tên biến, hàm, class** | Tiếng Anh | `def install_package()` |
| **Comment trong code** | Tiếng Anh | `# Check if driver is installed` |
| **Commit message** | Tiếng Anh hoặc Việt | `feat: thêm Caram Center` |
| **Issue, PR** | Tiếng Việt hoặc Anh | Tuỳ người viết |
| **Tài liệu user** | Tiếng Việt (chính) | Hướng dẫn cài đặt |
| **README** | Tiếng Việt (chính) + Anh | 2 file riêng |
| **UI/giao diện** | Tiếng Việt | "Cài đặt", "Cập nhật" |

### Python (Caram Center, Welcome App)

- Python 3.10+
- GUI: GTK 4 hoặc GTK 3 (qua PyGObject)
- Format: dùng [Black](https://github.com/psf/black) (line length 88)
- Linter: flake8
- Đặt tên file: `snake_case.py`
- Đặt tên class: `PascalCase`
- Đặt tên hàm/biến: `snake_case`

```python
# Ví dụ chuẩn
class CaramCenter:
    """Main application for managing Windows app installation."""

    def install_app(self, app_name: str) -> bool:
        """Install a Windows application via Bottles or Webapp Manager."""
        config = self._load_app_config(app_name)
        ...
```

### Bash (build scripts)

- Shebang: `#!/bin/bash`
- Dùng `set -euo pipefail` ở đầu file
- Đặt tên file: `kebab-case.sh`
- Comment giải thích mỗi block lệnh

```bash
#!/bin/bash
set -euo pipefail

# Install Vietnamese input method
apt install -y fcitx5-lotus

# Set Vietnamese locale as default
sed -i 's/en_US.UTF-8/vi_VN.UTF-8/' /etc/default/locale
```

### YAML (Caram Center app configs)

```yaml
# Ví dụ: apps/zalo.yaml
name: Zalo
description: Ứng dụng nhắn tin phổ biến tại Việt Nam
method: webapp              # webapp | bottles | snap | flatpak
url: https://chat.zalo.me   # Chỉ cho method: webapp
icon: zalo.png
category: communication
```

---

## Báo lỗi

Tạo Issue tại [GitHub Issues](https://github.com/VN-Linux-Family/CaramOS/issues) với thông tin:

1. **Mô tả lỗi** — Chuyện gì xảy ra?
2. **Cách tái hiện** — Làm gì để gặp lỗi?
3. **Kết quả mong đợi** — Đáng lẽ phải thế nào?
4. **Thông tin hệ thống** — Phiên bản CaramOS, phần cứng (CPU, GPU, WiFi chip)
5. **Ảnh chụp/log** — Nếu có

---

## Đề xuất tính năng

Tạo Issue với label `feature-request`:

1. **Mô tả tính năng** — Bạn muốn gì?
2. **Lý do** — Tại sao tính năng này cần thiết?
3. **Giải pháp đề xuất** — Bạn hình dung nó hoạt động thế nào?

---

<p align="center">
  <strong>CaramOS</strong> — Sweet & Simple Linux<br>
  <a href="https://github.com/VN-Linux-Family/CaramOS">github.com/VN-Linux-Family/CaramOS</a>
</p>
