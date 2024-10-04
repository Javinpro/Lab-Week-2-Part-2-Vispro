import 'package:dart_console/dart_console.dart';
import 'dart:math';
import 'dart:io'; // Untuk sleep()

final console = Console();

void main() {
  // Dapatkan jumlah fireworks dari input user
  console.writeLine('Berapa banyak fireworks yang ingin Anda tampilkan?');
  final input = console.readLine();

  // Ubah input menjadi integer, jika input tidak valid, gunakan nilai default 0
  final numberOfFireworks = int.tryParse(input ?? '') ?? 0;

  // Tentukan ukuran terminal secara manual jika tidak bisa didapatkan
  final width = 80; // Lebar default terminal
  final height = 24; // Tinggi default terminal

  // Tampilkan fireworks berdasarkan input user
  for (int i = 0; i < numberOfFireworks; i++) {
    showDynamicFirework(width, height);
    sleep(
        Duration(milliseconds: 500)); // Beri jeda waktu untuk setiap fireworks
  }

  // Tampilkan HBD ANO setelah semua kembang api selesai
  showBirthdayMessage(width, height);

  console.resetColorAttributes();
  console.clearScreen();
}

// Fungsi untuk menampilkan kembang api secara dinamis
void showDynamicFirework(int width, int height) {
  final rand = Random();

  // Tentukan posisi awal (tengah terminal)
  int startX = width ~/ 1; // Tengah
  int startY = height - 2; // Posisi awal dari bawah

  // Ubah warna foreground sesuai warna fireworks
  console.setForegroundColor(ConsoleColor.white);

  // Naikkan kembang api dari bawah ke tengah terminal dengan karakter '|'
  for (int y = startY; y > height ~/ 2; y--) {
    console.clearScreen();
    console.cursorPosition = Coordinate(y, startX);
    console.write('|'); // Gunakan logo garis lurus saat naik
    sleep(Duration(milliseconds: 100)); // Animasi naik
  }

  // Setelah mencapai tengah, ledakkan dengan variasi simbol
  explodeFirework(startX, height ~/ 2);

  // Tunggu sebentar sebelum menghapus
  sleep(Duration(milliseconds: 500));

  // Reset warna setelah fireworks muncul
  console.resetColorAttributes();
}

void explodeFirework(int centerX, int centerY) {
  // Daftar warna untuk kembang api
  final colors = [
    ConsoleColor.red,
    ConsoleColor.green,
    ConsoleColor.blue,
    ConsoleColor.yellow,
    ConsoleColor.cyan,
  ];

  // Pilih satu warna acak untuk latar belakang kembang api ini
  final color = colors[Random().nextInt(colors.length)];

  // Set warna latar belakang
  console.setBackgroundColor(color);

  // Buat pola ledakan yang lebih ramai
  final explosionPatterns = [
    [
      '   *   ',
      '  *|*  ',
      ' *---* ',
      '  *|*  ',
      '   *   ',
    ],
    [
      ' *  *  ',
      ' *--*  ',
      '  *|*  ',
      ' *--*  ',
      ' *  *  ',
    ],
    [
      '   *   ',
      ' *---* ',
      ' *|* * ',
      ' *---* ',
      '   *   ',
    ],
    [
      '  *|*  ',
      ' *---* ',
      ' *---* ',
      ' *|* * ',
      ' *---* ',
    ],
  ];

  // Gambarkan ledakan secara acak
  for (var pattern in explosionPatterns) {
    console.clearScreen();
    console.setBackgroundColor(color); // Set warna latar belakang

    for (int row = 0; row < pattern.length; row++) {
      console.cursorPosition = Coordinate(centerY - 2 + row, centerX - 4);
      console.write(pattern[row]);
    }

    // Tunggu sejenak untuk animasi
    sleep(Duration(milliseconds: 200));
  }
}

void showBirthdayMessage(int width, int height) {
  final messageHBD = [
    ['H   H', 'H   H', 'HHHHH', 'H   H', 'H   H'], // Huruf H
    ['BBBB ', 'B   B', 'BBBB ', 'B   B', 'BBBB '], // Huruf B
    ['DDDD ', 'D   D', 'D   D', 'D   D', 'DDDD '], // Huruf D
  ];

  final messageANO = [
    ['  A  ', ' A A ', 'AAAAA', 'A   A', 'A   A'], // Huruf A
    ['N   N', 'NN  N', 'N N N', 'N  NN', 'N   N'], // Huruf N
    [' OOO ', 'O   O', 'O   O', 'O   O', ' OOO '], // Huruf O
  ];

  int startY = height;
  int endY = height ~/ 2 - 3; // Posisi akhir di tengah layar

  // Geser HBD dua kali lebih ke kanan dan ANO satu kali ke kanan
  int hbdOffset = 15; // Geser HBD lebih ke kanan
  int anoOffset = 10; // Geser ANO lebih ke kanan

  // Gerakkan pesan dari bawah ke atas secara bertahap
  for (int y = startY; y >= endY; y--) {
    console.clearScreen();

    // Reset latar belakang menjadi normal saat teks muncul
    console.resetColorAttributes();

    // Tampilkan "HBD" di sebelah kiri dengan offset
    for (int row = 0; row < 5; row++) {
      for (int i = 0; i < messageHBD.length; i++) {
        console.cursorPosition =
            Coordinate(y + row, (width ~/ 3 - 8) + i * 6 + hbdOffset);
        console.write(messageHBD[i][row]);
      }
    }

    // Tampilkan "ANO" di sebelah kanan dengan jarak yang cukup dan offset
    for (int row = 0; row < 5; row++) {
      for (int i = 0; i < messageANO.length; i++) {
        console.cursorPosition =
            Coordinate(y + row, (2 * width) ~/ 3 - 8 + i * 6 + anoOffset);
        console.write(messageANO[i][row]);
      }
    }

    sleep(Duration(milliseconds: 200)); // Animasi gerak naik
  }

  // Biarkan pesan tetap di tengah selama 5 detik
  sleep(Duration(seconds: 5));
}
