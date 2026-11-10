const _namaHari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
const _namaBulan = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

String tanggalLengkap(DateTime tanggal) {
  return '${_namaHari[tanggal.weekday - 1]}, ${tanggal.day} '
      '${_namaBulan[tanggal.month - 1]} ${tanggal.year}';
}

String tanggalSingkat(DateTime tanggal) {
  return '${tanggal.day} ${_namaBulan[tanggal.month - 1]} ${tanggal.year}';
}

String jamMenit(DateTime tanggal) {
  final jam = tanggal.hour.toString().padLeft(2, '0');
  final menit = tanggal.minute.toString().padLeft(2, '0');
  return '$jam:$menit';
}
