import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String username = "admin";
  final String password = "1234";
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String errorMessage = "";

  void login() {
    if (userController.text.isEmpty || passController.text.isEmpty) {
      setState(() {
        errorMessage = "Username dan Password tidak boleh kosong";
      });
    } else if (userController.text == username && passController.text == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        errorMessage = "Username atau Password salah";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: login,
              child: Text("Login", style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: Colors.blue[800],
              ),
            ),
            SizedBox(height: 12),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Utama", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            // About Us Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Kelompok: \n1. Iqbal Alwy Qurrois - 123220034\n2. Mohammad Rifqi Abbiyu Musyaffa - 123220068 \n3. Sofwan Fadhilah - 123220149\n4. Rifky Chandra Nugraha - 123220168",
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Fitur-fitur lainnya
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureButton(
                    context,
                    "Cek Ganjil/Genap",
                    Icons.numbers,
                    GanjilGenapScreen(),
                  ),
                  _buildFeatureButton(
                    context,
                    "Kalkulator",
                    Icons.calculate,
                    KalkulatorScreen(),
                  ),
                  _buildFeatureButton(
                    context,
                    "Hitung Digit",
                    Icons.format_list_numbered,
                    HitungDigitScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(BuildContext context, String title, IconData icon, Widget screen) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blue[800]),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GanjilGenapScreen extends StatefulWidget {
  @override
  _GanjilGenapScreenState createState() => _GanjilGenapScreenState();
}

class _GanjilGenapScreenState extends State<GanjilGenapScreen> {
  final TextEditingController angkaController = TextEditingController();
  String hasil = "";

  void cekAngka() {
    if (angkaController.text.isEmpty) {
      setState(() {
        hasil = "Masukkan angka terlebih dahulu";
      });
      return;
    }

    int? angka = int.tryParse(angkaController.text);
    if (angka == null) {
      setState(() {
        hasil = "Input harus berupa angka, tidak boleh huruf atau karakter lain";
      });
      return;
    }

    setState(() {
      hasil = angka % 2 == 0 ? "Genap" : "Ganjil";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Ganjil / Genap", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: angkaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan Angka",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: cekAngka,
              child: Text("Cek", style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: Colors.blue[800],
              ),
            ),
            SizedBox(height: 20),
            Text(
              hasil,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class KalkulatorScreen extends StatefulWidget {
  @override
  _KalkulatorScreenState createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  final TextEditingController angka1 = TextEditingController();
  final TextEditingController angka2 = TextEditingController();
  String hasil = "";

  void tambah() {
    if (angka1.text.isEmpty || angka2.text.isEmpty) {
      setState(() {
        hasil = "Kedua angka harus diisi";
      });
      return;
    }

    int? num1 = int.tryParse(angka1.text);
    int? num2 = int.tryParse(angka2.text);

    if (num1 == null || num2 == null) {
      setState(() {
        hasil = "Input harus berupa angka, tidak boleh huruf atau karakter lain";
      });
      return;
    }

    setState(() {
      hasil = (num1 + num2).toString();
    });
  }

  void kurang() {
    if (angka1.text.isEmpty || angka2.text.isEmpty) {
      setState(() {
        hasil = "Kedua angka harus diisi";
      });
      return;
    }

    int? num1 = int.tryParse(angka1.text);
    int? num2 = int.tryParse(angka2.text);

    if (num1 == null || num2 == null) {
      setState(() {
        hasil = "Input harus berupa angka, tidak boleh huruf atau karakter lain";
      });
      return;
    }

    setState(() {
      hasil = (num1 - num2).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalkulator", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: angka1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Angka 1",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: angka2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Angka 2",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: tambah,
                  child: Text("+", style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.blue[800],
                  ),
                ),
                ElevatedButton(
                  onPressed: kurang,
                  child: Text("-", style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.blue[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              "Hasil: $hasil",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class HitungDigitScreen extends StatefulWidget {
  @override
  _HitungDigitScreenState createState() => _HitungDigitScreenState();
}

class _HitungDigitScreenState extends State<HitungDigitScreen> {
  final TextEditingController angkaController = TextEditingController();
  String hasil = "";

  void hitungDigit() {
    if (angkaController.text.isEmpty) {
      setState(() {
        hasil = "Masukkan angka terlebih dahulu";
      });
      return;
    }

    int? angka = int.tryParse(angkaController.text);
    if (angka == null) {
      setState(() {
        hasil = "Input harus berupa angka, tidak boleh huruf atau karakter lain";
      });
      return;
    }

    setState(() {
      hasil = "Total digit: ${angkaController.text.length}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hitung Digit", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: angkaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan Angka",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: hitungDigit,
              child: Text("Hitung", style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: Colors.blue[800],
              ),
            ),
            SizedBox(height: 20),
            Text(
              hasil,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}