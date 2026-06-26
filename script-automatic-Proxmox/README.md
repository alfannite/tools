# 🔄 Proxmox VM Rename Tool

Script bash buat rename VM ID di Proxmox secara otomatis — handle LVM volumes, config file, semua sekaligus.

---

## ⚡ Cara Pakai

### 1. Download / Copy script ke Proxmox host

```bash
wget -O rename-vm.sh https://raw.githubusercontent.com/your-repo/rename-vm.sh
```
> Atau copy manual file `rename-vm.sh` ke server Proxmox kamu.

### 2. Kasih permission execute

```bash
chmod +x rename-vm.sh
```

### 3. Jalanin sebagai root

```bash
sudo ./rename-vm.sh
```

### 4. Isi 3 input yang muncul

```
  Volume Group Name (e.g. vg-images) : vg-images
  Old VM ID                           : 175
  New VM ID                           : 173
```

### 5. Konfirmasi

Script bakal nampilin summary dulu sebelum eksekusi:

```
  ┌─ Summary ──────────────────────────────┐
  │  Volume Group : vg-images
  │  Old VM ID    : 175
  │  New VM ID    : 173
  └────────────────────────────────────────┘

  Lanjut? (y/N) :
```

Ketik `y` lalu Enter buat lanjut.

---

## 🔧 Yang Dilakuin Script

| Step | Aksi |
|---|---|
| **1** | Rename semua LVM disk `vm-175-disk-X` → `vm-173-disk-X` |
| **2** | Replace semua `175` → `173` di dalam file config |
| **3** | Rename file `/etc/pve/qemu-server/175.conf` → `173.conf` |

---

## ✅ Verifikasi Setelah Jalan

Cek VM sudah muncul dengan ID baru:

```bash
qm list
```

Cek config file sudah benar:

```bash
cat /etc/pve/qemu-server/173.conf
```

Cek LVM sudah ter-rename:

```bash
lvs | grep vg-images
```

---

## ⚠️ Syarat & Perhatian

- Script **harus dijalankan sebagai root**
- **Matikan VM dulu** sebelum rename (`qm stop <vmid>`)
- Script ini hanya handle **satu Volume Group** dalam sekali jalan
- Kalau VM punya disk di **lebih dari satu VG**, jalanin script dua kali dengan VG berbeda
- Pastikan new VM ID **belum dipakai** oleh VM lain di Proxmox

---

## 🆘 Manual Steps (Kalau Mau Tanpa Script)

Kalau mau dikerjain manual:

```bash
# 1. Rename LVM
lvrename vg-images/vm-175-disk-0 vm-173-disk-0
lvrename vg-images/vm-175-disk-1 vm-173-disk-1

# 2. Update isi config
sed -i "s/175/173/g" /etc/pve/qemu-server/175.conf

# 3. Rename config file
mv /etc/pve/qemu-server/175.conf /etc/pve/qemu-server/173.conf
```

---

## 📁 Struktur File

```
.
└── rename-vm.sh   ← script utama
```