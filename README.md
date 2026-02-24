<p align="center">
  <img src="branding/logo.png" alt="CaramOS Logo" width="120">
</p>

<h1 align="center">CaramOS</h1>

<p align="center">
  <strong>Sweet & Simple Linux — Hệ điều hành Linux ngọt ngào cho người Việt</strong>
</p>

<p align="center">
  <em>Caram = Carambola = Trái khế — 5 cánh như ngôi sao trên quốc kỳ, gắn liền với tuổi thơ người Việt</em>
</p>

<p align="center">
  <a href="README_EN.md">English</a> · <a href="https://vietnamlinuxfamily.net">VNLF</a> · <a href="https://caramos.vietnamlinuxfamily.net">Website</a>
</p>

---

### CaramOS là gì?

**CaramOS** là bản phân phối Linux dựa trên [Linux Mint](https://linuxmint.com/), được thiết kế đặc biệt cho **người dùng Việt Nam**. Mục tiêu của CaramOS là phổ thông hoá Linux — giúp mọi người chuyển từ Windows sang Linux một cách dễ dàng, miễn phí, và hợp pháp.

> Sứ mệnh của CaramOS là **phổ thông hoá Linux** — mọi thứ được làm đơn giản nhất có thể, phần mềm cài sẵn và sẵn sàng sử dụng, đồng thời cố gắng mang những ứng dụng quen thuộc từ Windows đến cho người dùng.

### Tính năng nổi bật

| Tính năng | Mô tả |
|---|---|
| **Giao diện Chrome OS** | Sạch sẽ, hiện đại, icon tròn, launcher grid — đẹp ngay từ lần đầu |
| **Caram Center** | 1 ứng dụng duy nhất để cài Zalo, Photoshop, Office, game Windows |
| **Việt hoá 100%** | Tiếng Việt mặc định, bộ gõ fcitx5-lotus cài sẵn, font Việt đẹp |
| **AI Offline** | Trợ lý AI chạy hoàn toàn offline — chat, dịch, tóm tắt, sửa chính tả |
| **Cập nhật an toàn** | mintupdate phân loại mức độ rủi ro — không bao giờ tự update hỏng máy |
| **Backup 1 click** | Timeshift tạo snapshot — hỏng máy thì khôi phục trong 2 phút |
| **Driver tự động** | Tự phát hiện và cài driver WiFi, GPU (NVIDIA/AMD/Intel) |
| **Chia sẻ file LAN** | Warpinator — gửi file giữa các máy như AirDrop |
| **Nhẹ và nhanh** | Chạy mượt trên máy cấu hình thấp |

### Ảnh chụp màn hình

> *Sẽ cập nhật khi phát hành bản beta đầu tiên*

### Cài đặt

#### Bước 1: Tải ISO

```bash
# Sẽ cập nhật link tải khi phát hành
# CaramOS.iso          — Intel/AMD (nhẹ)
# CaramOS-nvidia.iso   — Có sẵn driver NVIDIA
```

#### Bước 2: Ghi ra USB

```bash
# Linux / macOS
sudo dd if=CaramOS.iso of=/dev/sdX bs=4M status=progress

# Hoặc dùng Balena Etcher (GUI, mọi hệ điều hành)
# https://etcher.balena.io
```

#### Bước 3: Khởi động từ USB & cài đặt

1. Khởi động lại máy, vào BIOS/UEFI (nhấn F2/F12/Del)
2. Chọn boot từ USB
3. Chọn **"Cài đặt CaramOS"**
4. Làm theo hướng dẫn trên màn hình (hoàn toàn tiếng Việt)

### Caram Center — Cài app Windows dễ dàng

Caram Center là ứng dụng độc quyền của CaramOS, giúp cài phần mềm Windows chỉ với vài click:

```
+------------------------------------------+
|            Caram Center                   |
+----------+----------+--------------------+
| Ứng dụng | Trò chơi | Ứng dụng Web       |
+----------+----------+--------------------+
| Bottles  | Lutris   | Webapp Manager     |
| (Wine)   | (Wine)   | (PWA)              |
+----------+----------+--------------------+
```

| App | Cách cài | Trạng thái |
|---|---|---|
| **Zalo** | Snap / PWA | Hoạt động tốt |
| **Photoshop CS6** | Bottles (Wine) | Hoạt động tốt |
| **MS Office 2016** | Bottles (Wine) | Cơ bản OK |
| **Game Windows** | Lutris / Steam Proton | Tuỳ game |

### Đóng góp

Chúng tôi hoan nghênh mọi đóng góp! Xem [CONTRIBUTING.md](CONTRIBUTING.md) để biết thêm chi tiết.

**Cách đóng góp:**

1. Fork repo này
2. Tạo branch mới (`git checkout -b feature/tinh-nang-moi`)
3. Commit thay đổi (`git commit -m 'Thêm tính năng mới'`)
4. Push lên branch (`git push origin feature/tinh-nang-moi`)
5. Tạo Pull Request

**Bạn có thể giúp:**
- Báo lỗi và đề xuất tính năng qua [Issues](https://github.com/VN-Linux-Family/CaramOS/issues)
- Thiết kế wallpaper, icon, theme
- Test trên nhiều loại máy khác nhau
- Viết tài liệu hướng dẫn tiếng Việt
- Dịch thuật
- Viết script cài app Windows cho Caram Center

### Giấy phép

CaramOS là phần mềm **mã nguồn mở** theo giấy phép [GPL-3.0](LICENSE).

### Cảm ơn

- [Linux Mint](https://linuxmint.com/) — Base distro tuyệt vời
- [VNLF (Vietnam Linux Family)](https://vietnamlinuxfamily.net) — Cộng đồng Linux Việt Nam
- [vinceliuice](https://github.com/vinceliuice) — ChromeOS-theme, Tela Circle icons
- [Bottles](https://usebottles.com/) — Chạy app Windows trên Linux
- [Lutris](https://lutris.net/) — Chạy game Windows trên Linux
- [Ollama](https://ollama.com/) — AI offline

---

<p align="center">
  <strong>CaramOS</strong> — Sweet & Simple Linux<br>
  Made with love by <a href="https://vietnamlinuxfamily.net">Vietnam Linux Family</a>
</p>
