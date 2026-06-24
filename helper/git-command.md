<h1 align="center">Git Command Guide</h1>

<p align="center">
Catatan pribadi setup homelab — biar ga lupa dan gampang diulangin.
</p>

<p align="center">

![Homelab](https://img.shields.io/badge/Homelab-Personal_Docs-6366F1?style=flat-square)
![Git](https://img.shields.io/badge/Git-Cheatsheet-F05032?style=flat-square&logo=git&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

</p>

---

## 🆕 Buat Repository Baru dari Nol

```bash
echo "# nama-repo" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/alfannite/nama-repo.git
git push -u origin main
```

---

## 📤 Push Repository yang Sudah Ada

```bash
git remote add origin https://github.com/alfannite/nama-repo.git
git branch -M main
git push -u origin main
```

---

## 🔄 Workflow Harian

```bash
# Cek status perubahan
git status

# Tambah semua perubahan
git add .

# Commit dengan pesan
git commit -m "pesan commit"

# Push ke GitHub
git push
```

---

## 🌿 Manajemen Branch

```bash
# Buat branch baru
git checkout -b nama-branch

# Pindah ke branch
git checkout nama-branch

# Lihat semua branch
git branch -a

# Merge branch ke main
git checkout main
git merge nama-branch

# Hapus branch setelah merge
git branch -d nama-branch
```

---

## ⏪ Undo & Reset

```bash
# Batalkan perubahan file sebelum di-add
git checkout -- nama-file

# Unstage file yang sudah di-add
git reset HEAD nama-file

# Undo commit terakhir (keep changes)
git reset --soft HEAD~1

# Undo commit terakhir (buang changes)
git reset --hard HEAD~1
```

---

## 🔗 Remote Management

```bash
# Lihat remote yang terdaftar
git remote -v

# Ganti URL remote
git remote set-url origin https://github.com/alfannite/nama-repo.git

# Hapus remote
git remote remove origin
```

---

## 📋 Tips

> Selalu isi **README**, **LICENSE**, dan **.gitignore** saat bikin repo baru.

> Gunakan pesan commit yang deskriptif — bukan cuma `update` atau `fix`.

> Sebelum push, jalankan `git status` dulu biar tau apa yang berubah.

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