# Dokumen PRD + Design — Aplikasi "Cek Tas"

> **Versi:** PRD v0.2 + Design v0.1 (gabungan)
> **Penulis:** [Isikan nama kamu]
> **Tanggal:** [Isikan tanggal]
> **Platform:** Mobile (Android prioritas, iOS opsional)
> **Status:** Draft

---

# BAGIAN 1 — PRD (Product Requirements Document)

## 1. Ringkasan Produk (Overview)

Aplikasi mobile yang membantu pengguna — pelajar/pekerja yang sering membawa banyak barang dan mudah lupa — untuk:

1. **Mencatat barang bawaan** setiap kali pergi ke suatu tempat.
2. **Mengecek kembali sebelum meninggalkan tempat tersebut** barang apa saja yang harus dikembalikan ke tas agar tidak ada yang tertinggal.

Aplikasi berbasis **Tempat/Lokasi**: pengguna tidak cuma ke sekolah, tapi juga ke **cafe, mall, rumah teman, les, dll**. Tiap tempat punya daftar bawaan sendiri, sehingga pengingatnya menyesuaikan *ke mana* ia pergi.

> Fokus: **reminder & checklist**, bukan manajemen inventaris rumit. Tujuannya: *"biar nggak ada barang yang ketinggalan, di mana pun aku berada."*

---

## 2. Latar Belakang & Masalah (Problem Statement)

| Masalah | Dampak |
|---------|--------|
| Sering membawa banyak barang (laptop, charger, buku, tumbler, kadang stik PS + kabel) | Sulit dihafal satu per satu |
| Tidak cuma ke sekolah — juga ke **cafe, mall, tempat lain** | Bawaan berubah-ubah tergantung tujuan |
| Pelupa & agak teledor | Sering ada barang tertinggal saat pulang/berpindah tempat |
| Tidak ada sistem catatan per tempat | Tidak sadar barang apa yang dibawa hingga sudah jauh |

**Solusi:** Satu aplikasi berisi **daftar bawaan per tempat** + pengingat "cek sebelum pergi" saat akan meninggalkan suatu lokasi.

---

## 3. Tujuan & Non-Tujuan

### Tujuan (Goals)
- Tempat bisa **ditambah, diedit, dihapus** oleh pengguna (Sekolah, Cafe, Mall, dll).
- Tiap tempat punya **template bawaan** yang bisa dipakai ulang.
- Saat tiba/pergi ke suatu tempat, pengguna **mencatat & mencentang** barang bawaan.
- **Pengingat** muncul saat akan meninggalkan tempat → checklist verifikasi.
- Ringan, cepat, bisa dipakai < 10 detik.

### Non-Tujuan (Non-Goals)
- Bukan pelacakan GPS anti-maling (lokasi otomatis = fitur masa depan, opsional).
- Bukan manajemen keuangan / jadwal.
- Bukan sinkronisasi cloud (fokus lokal dulu).

---

## 4. Pengguna Target (Target Users)

- **Persona utama:** Siswa SMK RPL, usia ~16–18 tahun.
- **Karakteristik:** Membawa elektronik & buku; mobilitas tinggi (sekolah + cafe + mall + lainnya); pelupa & teledor.
- **Kebutuhan:** Cepat, tidak ribet, pengingat per tempat.

---

## 5. Fitur Inti (Functional Requirements)

### FR-1: Manajemen Tempat/Lokasi
- Pengguna bisa **tambah, edit, hapus** tempat.
  - Contoh: `Sekolah`, `Cafe ABC`, `Mall`, `Rumah Teman`, `Les`.
- Tiap tempat punya **ikon/emoji** & **warna** agar mudah dibedakan.
- Tempat bisa dijadikan **favorit** (sering dipakai muncul di atas).

### FR-2: Template Bawaan per Tempat
- Tiap tempat memiliki **template barang default** sendiri.
  - Sekolah → laptop, charger, buku, tumbler.
  - Cafe → laptop, charger, tumbler, earphone.
  - Mall → dompet, HP, tumbler (tidak usah bawa laptop).
- Saat memulai kunjungan ke tempat tertentu, template langsung muncul → tinggal centang/ubah.

### FR-3: Daftar Barang & Kategori
- Tambah/edit/hapus barang global (bisa dipakai di banyak tempat).
- Kategori: `Wajib` (laptop, charger, buku, tumbler) | `Tambahan` (stik PS, kabel, dll).
- Barang punya **ikon/emoji**.

### FR-4: Kunjungan / Sesi Harian
- Saat tiba di suatu tempat, pengguna **mulai sesi kunjungan** → pilih tempat → daftar bawaan hari itu muncul (dari template).
- Status tiap barang: `Sudah di tas` / `Belum`.
- Satu hari bisa punya **banyak kunjungan** (mis. Sekolah pagi, Cafe sore).
- Riwayat kunjungan tersimpan.

### FR-5: Checklist Sebelum Pergi (Core Reminder)
- Saat akan meninggalkan tempat, buka **mode "Cek Sebelum Pergi"**.
- Tampilkan checklist barang bawaan **tempat tersebut**.
- Centang satu per satu saat memasukkan ke tas.
- Jika ada yang belum → peringatan *"Masih ada 2 barang belum dibereskan di [Nama Tempat]!"*

### FR-6: Pengingat Notifikasi
- Notifikasi manual tombol **"Saya mau pulang/pergi"** → langsung buka checklist.
- Notifikasi terjadwal (jam bisa diatur per tempat, mis. Sekolah 15.00).
- Isi: *"Cek tas sebelum pergi dari [Nama Tempat]!"*

### FR-7: Tanda Selesai (All Clear)
- Semua dicentang → **"Tas Lengkap, boleh pergi! ✅"**.
- Kunjungan ditandai selesai & masuk riwayat.

---

## 6. Alur Pengguna (User Flow)

### Alur Saat Tiba di Suatu Tempat
```
Buka App → Pilih/Tambah Tempat (Sekolah/Cafe/Mall)
        → Template bawaan muncul
        → Centang barang yang sudah dibawa masuk
        → Mulai kunjungan (simpan sesi)
```

### Alur Sebelum Meninggalkan Tempat (Verifikasi)
```
Tekan "Saya mau pergi" / Notifikasi jam pulang
   → Mode "Cek Sebelum Pergi" untuk [Nama Tempat]
   → Centang barang yang sudah dikembalikan ke tas
   → Semua ✅ → "Tas Lengkap!"
   → Ada ❌ → Peringatan barang tertinggal
```

---

## 7. Model Data Sederhana (Data Model)

```
Place (Tempat)
  - id
  - nama (Sekolah, Cafe ABC, Mall, ...)
  - ikon (emoji)
  - warna
  - favorit (boolean)
  - template_item_id []   // default bawaan di tempat ini

Item (Barang)
  - id
  - nama (string)
  - kategori ("wajib" | "tambahan")
  - ikon (emoji)

Kunjungan (Visit / Sesi)
  - id
  - place_id
  - tanggal (date)
  - waktu_masuk (datetime)
  - daftar_item [{ item_id, status: "di_tas" | "belum" }]
  - status_selesai (boolean)
```

> Penyimpanan lokal (SQLite / Room) cukup untuk tahap awal.

---

## 8. Kebutuhan Non-Fungsional (NFR)

- **Performa:** Buka app & tampilkan checklist < 2 detik.
- **Offline:** Bisa dipakai tanpa internet.
- **Ukuran:** Ringan (< 20 MB ideal).
- **Kemudahan:** Anak SMK bisa pakai tanpa tutorial.
- **Bahasa UI:** Bahasa Indonesia.

---

## 9. Usulan Tech Stack (untuk siswa RPL)

| Bagian | Saran |
|--------|-------|
| Native Android | Kotlin + Jetpack Compose + Room (SQLite) |
| Cross-platform (opsional) | Flutter (Dart) — Android & iOS dalam 1 kode |
| Notifikasi | AlarmManager / WorkManager atau flutter_local_notifications |
| Penyimpanan | SQLite lokal (belum butuh server/cloud) |
| Lokasi otomatis (future) | FusedLocationProvider / Geolocator |

---

## 10. Ide Pengembangan Masa Depan (Future / Optional)

- 📍 **Deteksi lokasi otomatis** (saat keluar area tempat → otomatis ingatkan cek tas).
- 🔔 **Pengingat berbasis waktu & tempat** lebih pintar.
- 📷 **Foto tas** tiap kali sampai di tempat.
- ☁️ **Sinkronisasi cloud** antar device.
- 🤝 **Bagikan daftar** ke teman.
- 📊 **Statistik** barang/ tempat paling sering lupa.

---

## 11. Perubahan dari v0.1 → v0.2

- ✅ Tambah konsep **Tempat/Lokasi** sebagai inti aplikasi.
- ✅ Template bawaan sekarang **per tempat** (bukan cuma harian).
- ✅ Kunjungan harian mendukung **banyak tempat** dalam 1 hari.
- ✅ Checklist & pengingat bekerja **per tempat**.

---

## 12. Pertanyaan Terbuka (Open Questions)

1. Apakah perlu **deteksi lokasi otomatis** (GPS) atau cukup user pilih tempat manual?
2. Perlu pengingat **saat sampai** di tempat juga, atau cuma **saat mau pergi**?
3. Bolehkah satu hari punya **beberapa kunjungan ke tempat sama** (mis. pulang-pergi sekolah)?
4. Perlu fitur **"salin kunjungan kemarin"** biar lebih cepat?
5. Kategori barang cukup `Wajib`/`Tambahan`, atau mau ditambah (mis. `Elektronik`/`Buku`/`Lainnya`)?

---

# BAGIAN 2 — DESIGN DOCUMENT (v0.1)

> Dokumen desain ini mendeskripsikan **wireframe low-fidelity** & struktur layar dari PRD v0.2.
> Visual interaktif wireframe ada di `wireframe.html`. Dokumen ini berisi spesifikasi layar, alur, dan catatan design system sebagai dasar tahap desain berikutnya.

## A. Prinsip Desain

| Prinsip | Penjelasan |
|---------|-----------|
| **Mobile-first** | Seluruh layar dirancang untuk layar HP (lebar ~360–400px). |
| **Low-fidelity dulu** | Fokus ke struktur & alur, bukan warna/font. Garis tipis, kotak abu-abu, teks placeholder. |
| **Satu tugas per layar** | Tiap layar punya 1 tujuan jelas agar pengguna pelupa tidak bingung. |
| **Status pakai warna fungsional** | Merah = peringatan/wajib tertinggal, Hijau = aman. Bukan hiasan. |
| **Cepat & besar** | Target sentuhan jari: tombol & checkbox besar, bisa dipakai < 10 detik. |

## B. Information Architecture (Peta Layar)

```
Cek Tas (App)
├── Home (Hari ini + Tempat Favorit)
├── Kelola Tempat (CRUD tempat)
├── Template per Tempat (atur bawaan default)
├── Kunjungan Aktif (centang saat dibawa)
├── Cek Sebelum Pergi (verifikasi / checklist)
├── Riwayat (log kunjungan)
└── Pengaturan (jam pengingat per tempat) — *future*
```

## C. Spesifikasi Layar (Wireframe Spec)

### Layar 1 — Home
- **Tujuan:** Titik masuk; pilih tempat & lihat progres kunjungan aktif.
- **Elemen:** Judul hari; kartu kunjungan aktif (ikon tempat, progress bar, tombol "Saya Mau Pergi"); daftar Tempat Favorit; tombol "+ Mulai Kunjungan".
- **State:** Ada kunjungan aktif / kosong (tampilkan ajakan mulai kunjungan).

### Layar 2 — Kelola Tempat
- **Tujuan:** Tambah/edit/hapus tempat + ikon & warna.
- **Elemen:** Daftar tempat (ikon, nama, chip favorit/edit/hapus); form "Tempat Baru" (nama, pilih ikon, pilih warna); tombol "Simpan Tempat".
- **State:** Default (daftar) / Form tambah / Konfirmasi hapus.

### Layar 3 — Template per Tempat
- **Tujuan:** Atur bawaan default tiap tempat (isi beda per tempat).
- **Elemen:** Daftar barang (checkbox + nama + chip "wajib"/"tambahan"); tombol "+ Tambah Barang"; tombol "Pakai Template Ini".
- **State:** Template kosong / terisi; kategori wajib selalu di atas.

### Layar 4 — Kunjungan Aktif
- **Tujuan:** Centang barang saat dibawa; progres harian.
- **Elemen:** Daftar barang (checkbox + nama + kategori); progress bar; label "X/Y sudah di tas"; tombol "Saya Mau Pergi →".
- **State:** Sebagian dicentang / semua dicentang.

### Layar 5 — Cek Sebelum Pergi (Inti)
- **Tujuan:** Verifikasi akhir sebelum meninggalkan tempat.
- **Elemen:** Daftar checklist barang tempat tersebut; kotak **peringatan merah** jika ada wajib belum dibereskan; tombol "Semua ✅ · Tas Lengkap" (hijau); tombol "Tandai Selesai".
- **State:** Ada yang belum (peringatan merah) / Lengkap (hijau, boleh pergi).

### Layar 6 — Riwayat
- **Tujuan:** Lihat log kunjungan per tanggal & tempat.
- **Elemen:** List kunjungan (ikon tempat, tanggal, chip ✓ aman / ! lupa); catatan singkat bila ada yang lupa.
- **State:** Minggu ini / filter tanggal.

## D. Diagram Alur (User Flows)

**Flow A — Saat tiba di suatu tempat (mempersiapkan):**
```
① Home → ② Kelola Tempat (pilih/tambah) → ③ Template (pakai default) → ④ Kunjungan Aktif (centang dibawa)
```

**Flow B — Sebelum meninggalkan tempat (verifikasi):**
```
④ Kunjungan Aktif (Saya Mau Pergi) → ⑤ Cek Sebelum Pergi (centang kembali)
   → ⚠ Peringatan (ada wajib tertinggal?) → ✅ Tas Lengkap → Tandai Selesai → ⑥ Riwayat
```

## E. Catatan Design System (Dasar Tahap Desain Tinggi)

| Elemen | Rekomendasi Awal |
|--------|------------------|
| **Warna status** | Merah `#c0392b` (peringatan/wajib), Hijau `#2e7d32` (aman/selesai), Netral abu `#2b2b2b`/`#f4f4f4` |
| **Tipografi** | Sans-serif sistem (Roboto/Segoe); ukuran teks 12–14px, heading 16–18px |
| **Komponen inti** | Card, Checkbox besar, Progress bar, Chip kategori, Bottom button |
| **Ikon** | Emoji atau ikon outline sederhana per tempat & barang |
| **Feedback** | Getaran/animasi singkat saat "Tas Lengkap!" untuk kesan memuaskan |

> Catatan: Desain di atas masih low-fidelity. Untuk tahap high-fidelity, bisa lanjut ke warna brand, ilustrasi onboarding, dan empty-state yang ramah pengguna pelupa.

---

> 📌 *Dokumen gabungan PRD v0.2 + Design v0.1. Jika ada bagian yang ingin ditambah/diubah, beri tahu saya untuk revisi berikutnya.*
