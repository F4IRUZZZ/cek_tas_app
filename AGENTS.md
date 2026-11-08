# Aturan Kerja — Project Cek Tas (Flutter)

> File ini dibaca tiap sesi. Disiplin: 1 fitur = 1 Issue + 1 branch + 1 PR + uji hijau.

## 1. Dev server: nggak relevan (Flutter mobile)

- Tidak ada dev server port 3000 di project ini.
- Pastikan tidak menyisakan emulator/process background yang bentrok sebelum lapor selesai.

## 2. Alur GitHub

- 1 fitur = 1 Issue + 1 branch + 1 PR + uji hijau (`flutter analyze` + `flutter test` + `flutter build apk`).
- Berhenti di PR. `"oke merge"` = kamu yang merge + pull `main` + verifikasi.
- Chore kecil boleh langsung ke `main` (tulis alasan di laporan).

## 3. Verifikasi sebelum PR

- `flutter analyze` + `flutter test` + `flutter build apk --release` harus hijau.
- Skrip uji basi = selaraskan, bukan dianggap regresi.

## 3b. Konfirmasi selalu custom (Flutter)

- `showDialog` dengan `AlertDialog` bawaan DILARANG untuk konfirmasi aksi penting di `lib/`.
- Semua konfirmasi/validasi/error aksi lewat widget custom di `lib/widgets/confirm_dialog.dart` (gaya sesuai Design System Cek Tas).

## 4. Secret

- Hanya di `.env` (gitignored) kalau diperlukan di masa depan. Sekarang belum ada secret (penyimpanan lokal only, no cloud).
- Cek `git status` bebas secret sebelum setiap commit.

## 5. Kontrak bertahap (Fase 1 → 4)

- Model data & skema DB (PRD §7) stabil; fase berikutnya mengganti implementasi tanpa mengubah kontrak.

## 6. Tech stack (Flutter, dari PRD §9)

- Flutter (Dart) — Android prioritas, iOS opsional.
- `sqflite` + `path_provider` — SQLite lokal.
- `flutter_local_notifications` — notifikasi manual + terjadwal per tempat.
- `intl`, `google_fonts` — Bahasa Indonesia + tipografi.
