RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}"
echo "╔══════════════════════════════════════╗"
echo "║     Proxmox VM ID Rename Tool        ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

# ── Input ────────────────────────────────────────────────────
read -p "  Volume Group Name (e.g. vg-images) : " vgNAME
read -p "  Old VM ID                           : " oldVMID
read -p "  New VM ID                           : " newVMID
echo ""

# ── Validasi ─────────────────────────────────────────────────
if [[ -z "$vgNAME" || -z "$oldVMID" || -z "$newVMID" ]]; then
  echo -e "${RED}[ERROR] Semua field wajib diisi.${NC}"
  exit 1
fi

CONF_OLD="/etc/pve/qemu-server/${oldVMID}.conf"
CONF_NEW="/etc/pve/qemu-server/${newVMID}.conf"

if [[ ! -f "$CONF_OLD" ]]; then
  echo -e "${RED}[ERROR] Config file tidak ditemukan: ${CONF_OLD}${NC}"
  exit 1
fi

if [[ -f "$CONF_NEW" ]]; then
  echo -e "${RED}[ERROR] VM ID ${newVMID} sudah ada di Proxmox!${NC}"
  exit 1
fi

# ── Konfirmasi ───────────────────────────────────────────────
echo -e "${YELLOW}  ┌─ Summary ──────────────────────────────┐"
echo    "  │  Volume Group : $vgNAME"
echo    "  │  Old VM ID    : $oldVMID"
echo    "  │  New VM ID    : $newVMID"
echo -e "  └────────────────────────────────────────┘${NC}"
echo ""
read -p "  Lanjut? (y/N) : " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "${YELLOW}[BATAL] Tidak ada yang diubah.${NC}"
  exit 0
fi
echo ""

# ── Step 1: Rename LVM volumes ───────────────────────────────
echo -e "${CYAN}[1/3] Renaming LVM volumes...${NC}"

DISKS=$(lvs -a | grep "$vgNAME" | awk '{print $1}' | grep "$oldVMID")

if [[ -z "$DISKS" ]]; then
  echo -e "${YELLOW}      Tidak ada LVM disk ditemukan untuk VM ${oldVMID} di ${vgNAME}.${NC}"
else
  for disk in $DISKS; do
    suffix="${disk: -1}"
    old_lv="vm-${oldVMID}-disk-${suffix}"
    new_lv="vm-${newVMID}-disk-${suffix}"
    echo -e "      ${old_lv} → ${new_lv}"
    lvrename "${vgNAME}/${old_lv}" "${new_lv}"
    if [[ $? -ne 0 ]]; then
      echo -e "${RED}[ERROR] Gagal rename ${old_lv}${NC}"
      exit 1
    fi
  done
fi
echo -e "${GREEN}      ✓ LVM selesai${NC}"
echo ""

# ── Step 2: Update isi config file ───────────────────────────
echo -e "${CYAN}[2/3] Updating config file...${NC}"
sed -i "s/${oldVMID}/${newVMID}/g" "$CONF_OLD"
echo -e "${GREEN}      ✓ Isi config diupdate${NC}"
echo ""

# ── Step 3: Rename config file ───────────────────────────────
echo -e "${CYAN}[3/3] Renaming config file...${NC}"
mv "$CONF_OLD" "$CONF_NEW"
echo -e "${GREEN}      ✓ ${oldVMID}.conf → ${newVMID}.conf${NC}"
echo ""

# ── Done ─────────────────────────────────────────────────────
echo -e "${GREEN}╔══════════════════════════════════════╗"
echo    "║   ✅  VM berhasil di-rename!          ║"
echo -e "╚══════════════════════════════════════╝${NC}"
echo ""
echo -e "  VM ${YELLOW}${oldVMID}${NC} → ${GREEN}${newVMID}${NC} sukses."
echo -e "  Cek di Proxmox Web UI atau jalankan: ${CYAN}qm list${NC}"
echo ""