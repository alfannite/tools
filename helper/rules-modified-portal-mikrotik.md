<h1 align="center">MikroTik Captive Portal — File Rules & Dev Guide</h1>

<p align="center">

![MikroTik](https://img.shields.io/badge/MikroTik-RouterOS-CC0000?style=flat-square&logo=mikrotik&logoColor=white)
![Captive Portal](https://img.shields.io/badge/Captive_Portal-Dev_Guide-F59E0B?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

</p>

---

## 📁 File Rules — Boleh & Tidak Boleh Dimodifikasi

| File | Fungsi | Status |
|------|--------|--------|
| `login.html` | Halaman login utama | ✅ Utama kita |
| `logout.html` | Halaman setelah logout, tampil info session | ✅ Bisa |
| `status.html` | Popup kecil status koneksi (uptime, bytes) | ✅ Bisa |
| `alogin.html` | Redirect setelah login sukses + buka popup status | ⚠️ Jangan banyak ubah |
| `rlogin.html` | Untuk WISP/XML login (device lain) | ❌ Jangan diubah |
| `redirect.html` | Redirect HTTP 302 ke tujuan | ❌ Jangan diubah |
| `radvert.html` | Halaman advertisement | ✅ Bisa kalau mau |
| `error.html` | Tampil error system-level | ✅ Bisa |
| `errors.txt` | Daftar pesan error (bisa ditranslate) | ✅ Bisa ganti teksnya |
| `api.json` | Endpoint Captive Portal detection (iOS/Android) | ❌ Jangan diubah |
| `xml/*` | WISP protocol untuk device yang auto-detect captive | ❌ Jangan diubah |
| `md5.js` | Library hash password CHAP | ❌ Jangan diubah |
| `css/style.css` | Styling bawaan | ✅ Kita replace |

---

## 🔑 Variable MikroTik di `login.html`

> Semua variable di bawah **wajib dipertahankan** saat redesign.

| Variable | Fungsi |
|----------|--------|
| `$(if chap-id)` | Cek apakah CHAP aktif (mode enkripsi password) |
| `$(link-login-only)` | URL action form login → ke `/login` MikroTik |
| `$(link-orig)` | URL tujuan awal user sebelum di-redirect |
| `$(chap-id)` | ID untuk enkripsi MD5 |
| `$(chap-challenge)` | Challenge string untuk enkripsi MD5 |
| `$(if error)` | Kondisi ada error |
| `$(error)` | Isi pesan error |
| `$(username)` | Username yang sudah diisi (kalau ada) |
| `$(if trial == 'yes')` | Kalau trial login aktif |
| `$(link-login-only)?dst=...&username=T-$(mac-esc)` | Link trial by MAC |

---

## ⚙️ Alur Request Login

```text
User buka browser
       │
       ▼
MikroTik intercept → serve login.html
       │
       ▼
Ada $(chap-id)?
  ├── YA  → pakai form "sendin" (hidden) + md5.js
  │         password di-hash: MD5(chap-id + password + chap-challenge)
  │         submit ke $(link-login-only)
  │
  └── TIDAK → pakai form "login" biasa
              password plain text
              submit ke $(link-login-only)
       │
       ▼
MikroTik proses auth
  ├── Sukses → redirect ke alogin.html → buka popup status.html → redirect ke tujuan
  └── Gagal  → kembali ke login.html dengan $(error) terisi
```

---

## 🚫 File yang TIDAK Boleh Diubah

> Menyentuh file berikut bisa menyebabkan auth gagal atau captive portal detection rusak.

```
api.json
md5.js
xml/*
redirect.html
rlogin.html
```

---

## 📜 License

This project is licensed under the MIT License.
See the LICENSE file for details.

---

<div align="center">
  <p>Made by Alfannite for you hehe 😊</p>

  <a href="https://github.com/alfannite">
    <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
  </a>
  <a href="https://threads.net/@yeofanya">
    <img src="https://img.shields.io/badge/Threads-000000?style=for-the-badge&logo=threads&logoColor=white"/>
  </a>
  <a href="https://instagram.com/alfan.niteops">
    <img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white"/>
  </a>
  <a href="https://t.me/fannite_ops">
    <img src="https://img.shields.io/badge/Telegram-26A5E4?style=for-the-badge&logo=telegram&logoColor=white"/>
  </a>
  <a href="https://www.twitch.tv/fannitee">
    <img src="https://img.shields.io/badge/Twitch-9146FF?style=for-the-badge&logo=twitch&logoColor=white"/>
  </a>
  <a href="https://discord.gg/mS4UXkQjW">
    <img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white"/>
  </a>
</div>