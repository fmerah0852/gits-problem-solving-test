/// Soal 1 - A000124 (Sloane's OEIS) - Central polygonal numbers
///
/// Rumus suku ke-i (mulai dari i = 0):  a(i) = i * (i + 1) / 2 + 1
/// Deret: 1, 2, 4, 7, 11, 16, 22, 29, 37, 46, ...
///
/// Input n  = banyaknya suku yang ingin ditampilkan.
/// Output   = suku-suku deret dipisah tanda "-".

String a000124(int n) {
  // Jika n <= 0 tidak ada suku yang bisa ditampilkan.
  if (n <= 0) return '';

  final List<int> hasil = [];

  for (int i = 0; i < n; i++) {
    // i * (i + 1) selalu genap, jadi pembagian bulat (~/) aman.
    final int suku = (i * (i + 1)) ~/ 2 + 1;
    hasil.add(suku);
  }

  // Gabungkan semua suku dengan pemisah "-"
  return hasil.join('-');
}

void main() {
  // 3 input berbeda
  final List<int> inputs = [7, 5, 10];

  for (final int n in inputs) {
    print('Input  : $n');
    print('Output : ${a000124(n)}');
    print('');
  }
}