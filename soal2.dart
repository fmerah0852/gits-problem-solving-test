/// Soal 2 - Dense Ranking
///
/// Aturan:
///  - Skor tertinggi mendapat peringkat 1.
///  - Skor yang sama mendapat peringkat yang sama.
///  - Peringkat berikutnya TIDAK melompat (dense): 100,80,80,70 -> 1,2,2,3.
///
/// Parameter:
///  - leaderboard : skor pemain lain, terurut dari terbesar ke terkecil.
///  - skorGits    : skor GITS di tiap permainan.
/// Return        : daftar peringkat GITS untuk tiap skor.

List<int> denseRanking(List<int> leaderboard, List<int> skorGits) {
  // Langkah 1: buang skor kembar supaya tiap skor unik hanya muncul sekali.
  // Karena leaderboard sudah terurut, skor kembar pasti bersebelahan,
  // jadi cukup bandingkan dengan elemen terakhir yang sudah disimpan.
  final List<int> unik = [];
  for (final int skor in leaderboard) {
    if (unik.isEmpty || unik.last != skor) {
      unik.add(skor);
    }
  }

  // Langkah 2: untuk tiap skor GITS, hitung ada berapa skor unik
  // yang LEBIH BESAR darinya. Peringkat = jumlah itu + 1.
  final List<int> hasil = [];
  for (final int skor in skorGits) {
    hasil.add(_hitungPeringkat(unik, skor));
  }
  return hasil;
}

/// Binary search pada daftar unik (terurut menurun).
/// Mencari posisi pertama yang nilainya <= skor.
/// Posisi itu sama dengan jumlah skor yang lebih besar dari [skor].
int _hitungPeringkat(List<int> unik, int skor) {
  int kiri = 0;
  int kanan = unik.length;

  while (kiri < kanan) {
    final int tengah = (kiri + kanan) ~/ 2;
    if (unik[tengah] > skor) {
      // Elemen tengah masih lebih besar, cari ke kanan.
      kiri = tengah + 1;
    } else {
      kanan = tengah;
    }
  }
  return kiri + 1;
}

void _jalankan(List<int> leaderboard, List<int> skorGits) {
  print('Jumlah pemain : ${leaderboard.length}');
  print('Leaderboard   : ${leaderboard.join(' ')}');
  print('Jumlah game   : ${skorGits.length}');
  print('Skor GITS     : ${skorGits.join(' ')}');
  print('Output        : ${denseRanking(leaderboard, skorGits).join(' ')}');
  print('');
}

void main() {
  // 3 input berbeda
  _jalankan([100, 100, 50, 40, 40, 20, 10], [5, 25, 50, 120]); 
  _jalankan([100, 80, 80, 70], [60, 70, 100]); 
  _jalankan([90, 90, 90, 60, 30], [30, 61, 90, 95]);
}