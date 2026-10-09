/// Soal 3 - Highest Palindrome
///
/// Aturan soal:
///  - Tidak boleh looping (for / while / do-while / forEach / map, dll).
///  - Tidak boleh fungsi bawaan untuk search / filter / sort.
///  - Hanya rekursif.
///  - Jika tidak mungkin jadi palindrom, atau bukan angka -> output -1.
///
/// Hanya memakai: indexing string (s[i]), codeUnitAt, length, dan
/// penggabungan string (+). Semua pengulangan dilakukan lewat rekursi.

/// Mengembalikan true jika semua karakter s dari posisi [i] adalah digit 0-9.
bool _semuaDigit(String s, int i) {
  if (i >= s.length) return true;
  final int kode = s.codeUnitAt(i);
  // Kode ASCII '0' = 48 dan '9' = 57
  if (kode < 48 || kode > 57) return false;
  return _semuaDigit(s, i + 1);
}

/// Menghitung jumlah minimal penggantian digit supaya pasangan
/// (i, j) sampai ke tengah menjadi palindrom.
int _butuhMinimal(String s, int i, int j) {
  if (i >= j) return 0;
  final int beda = s[i] != s[j] ? 1 : 0;
  return beda + _butuhMinimal(s, i + 1, j - 1);
}

/// Menyusun hasil terbaik untuk bagian string dari posisi i sampai j.
/// [k] = sisa jatah penggantian yang boleh dipakai.
String _susun(String s, int i, int j, int k) {
  // Basis 1: sudah melewati tengah (panjang genap selesai).
  if (i > j) return '';

  // Basis 2: tepat di tengah (panjang ganjil).
  // Jika masih ada jatah dan bukan 9, ubah jadi 9.
  if (i == j) {
    return (k >= 1 && s[i] != '9') ? '9' : s[i];
  }

  final String a = s[i];
  final String b = s[j];

  // Jatah wajib yang harus disisakan untuk pasangan di dalam.
  final int cadangan = _butuhMinimal(s, i + 1, j - 1);
  // Jatah yang boleh dipakai pasangan ini setelah menyisihkan cadangan.
  final int tersedia = k - cadangan;

  // Biaya jika pasangan ini dijadikan 9-9.
  final int biaya9 = (a != '9' ? 1 : 0) + (b != '9' ? 1 : 0);

  String digit;
  int biaya;

  if (tersedia >= biaya9) {
    // Jatah cukup: jadikan 9-9 (nilai terbesar).
    digit = '9';
    biaya = biaya9;
  } else if (a != b) {
    // Jatah tidak cukup untuk 9, tapi pasangan ini wajib disamakan:
    // pilih digit yang lebih besar (biaya 1).
    digit = a.compareTo(b) > 0 ? a : b;
    biaya = 1;
  } else {
    // Sudah sama dan tidak ada jatah ekstra: biarkan.
    digit = a;
    biaya = 0;
  }

  return digit + _susun(s, i + 1, j - 1, k - biaya) + digit;
}

/// Fungsi utama. Mengembalikan string palindrom tertinggi, atau '-1'.
String highestPalindrome(String s, int k) {
  // Kosong, bukan angka, atau k negatif -> -1.
  if (s.isEmpty || k < 0 || !_semuaDigit(s, 0)) return '-1';

  // Jika jatah k kurang dari minimum yang dibutuhkan -> -1.
  if (_butuhMinimal(s, 0, s.length - 1) > k) return '-1';

  return _susun(s, 0, s.length - 1, k);
}

void _jalankan(String s, int k) {
  print('Input string : $s');
  print('k            : $k');
  print('Output       : ${highestPalindrome(s, k)}');
  print('');
}

void main() {
  // 3 input berbeda (tanpa looping)
  _jalankan('3943', 1); // sampel 1 -> 3993
  _jalankan('932239', 2); // sampel 2 -> 992299
  _jalankan('12345', 1); // tidak mungkin -> -1
}