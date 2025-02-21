import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas1teori/main.dart'; // Sesuaikan dengan path ke file main Anda

void main() {
  testWidgets('Test LoginScreen UI', (WidgetTester tester) async {
    // Memuat widget LoginScreen
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(), // Tanpa const karena LoginScreen tidak memiliki const constructor
    ));

    // Memverifikasi bahwa teks "Login" ada di AppBar
    expect(find.text('Login'), findsOneWidget);

    // Memverifikasi bahwa ada dua TextField (Username dan Password)
    expect(find.byType(TextField), findsNWidgets(2));

    // Memverifikasi bahwa ada tombol "Login"
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Test Login Functionality', (WidgetTester tester) async {
    // Memuat widget LoginScreen
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(), // Tanpa const
    ));

    // Memasukkan username dan password yang salah
    await tester.enterText(find.byType(TextField).at(0), 'wronguser');
    await tester.enterText(find.byType(TextField).at(1), 'wrongpass');
    await tester.tap(find.text('Login'));
    await tester.pump(); // Memicu rebuild setelah tombol ditekan

    // Memverifikasi pesan error muncul
    expect(find.text('Username atau Password salah'), findsOneWidget);

    // Memasukkan username dan password yang benar
    await tester.enterText(find.byType(TextField).at(0), 'admin');
    await tester.enterText(find.byType(TextField).at(1), '1234');
    await tester.tap(find.text('Login'));
    await tester.pump(); // Memicu rebuild setelah tombol ditekan

    // Memverifikasi navigasi ke HomeScreen
    expect(find.text('Menu Utama'), findsOneWidget);
  });

  testWidgets('Test GanjilGenapScreen Functionality', (WidgetTester tester) async {
    // Memuat widget GanjilGenapScreen
    await tester.pumpWidget(MaterialApp(
      home: GanjilGenapScreen(), // Tanpa const
    ));

    // Memasukkan angka
    await tester.enterText(find.byType(TextField), '7');
    await tester.tap(find.text('Cek'));
    await tester.pump(); // Memicu rebuild setelah tombol ditekan

    // Memverifikasi hasil ganjil/genap
    expect(find.text('Ganjil'), findsOneWidget);

    // Memasukkan input yang bukan angka
    await tester.enterText(find.byType(TextField), 'abc');
    await tester.tap(find.text('Cek'));
    await tester.pump(); // Memicu rebuild setelah tombol ditekan

    // Memverifikasi pesan error
    expect(find.text('Input harus berupa angka, tidak boleh huruf atau karakter lain'), findsOneWidget);
  });

  testWidgets('Test KalkulatorScreen Functionality', (WidgetTester tester) async {
    // Memuat widget KalkulatorScreen
    await tester.pumpWidget(MaterialApp(
      home: KalkulatorScreen(), // Tanpa const
    ));

    // Memasukkan angka ke kedua TextField
    await tester.enterText(find.byType(TextField).at(0), '10');
    await tester.enterText(find.byType(TextField).at(1), '5');
    await tester.tap(find.text('+'));
    await tester.pump(); // Memicu rebuild setelah tombol ditekan

    // Memverifikasi hasil penjumlahan
    expect(find.text('Hasil: 15'), findsOneWidget);

    // Memasukkan input yang bukan angka
    await tester.enterText(find.byType(TextField).at(0), 'abc');
    await tester.enterText(find.byType(TextField).at(1), '5');
    await tester.tap(find.text('+'));
    await tester.pump(); // Memicu rebuild setelah tombol ditekan

    // Memverifikasi pesan error
    expect(find.text('Input harus berupa angka, tidak boleh huruf atau karakter lain'), findsOneWidget);
  });

  testWidgets('Test HitungDigitScreen Functionality', (WidgetTester tester) async {
    // Memuat widget HitungDigitScreen
    await tester.pumpWidget(MaterialApp(
      home: HitungDigitScreen(), // Tanpa const
    ));

    // Memasukkan angka
    await tester.enterText(find.byType(TextField), '12345');
    await tester.tap(find.text('Hitung'));
    await tester.pump(); // Memicu rebuild setelah tombol ditekan

    // Memverifikasi hasil hitung digit
    expect(find.text('Total digit: 5'), findsOneWidget);

    // Memasukkan input yang bukan angka
    await tester.enterText(find.byType(TextField), 'abc');
    await tester.tap(find.text('Hitung'));
    await tester.pump(); // Memicu rebuild setelah tombol ditekan

    // Memverifikasi pesan error
    expect(find.text('Input harus berupa angka, tidak boleh huruf atau karakter lain'), findsOneWidget);
  });
}