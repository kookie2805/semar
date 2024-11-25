import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// im port 'dart:math';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart/profilepage.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:audioplayers/audioplayers.dart';

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
      ),
      home: SplashScreen(), // Menampilkan SplashScreen terlebih dahulu
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool showAppSplash = false;

  @override
  void initState() {
    super.initState();

    // Mengunci orientasi ke landscape
    ;

    // Animasi fade untuk logo perusahaan
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _fadeController.forward();

    // Saat animasi selesai, tampilkan splash screen aplikasi
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showAppSplash = true;
        });
      }
    });

    // Setelah beberapa detik, pindah ke halaman utama
    Future.delayed(Duration(seconds: 13), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            // Splash screen aplikasi yang menampilkan logo permainan
            if (showAppSplash)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                      'assets/images/logo_semar.png'), // Logo permainan
                ),
              )
            else
              // Logo perusahaan dengan efek fade out
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'android/assets/image/logo_unikki.jpeg'), // Logo perusahaan
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('android/assets/image/HOME-2-transformed.jpeg'),
          fit: BoxFit.cover, // Adjusts the image to cover the entire background
        ),
      ),
    );
  }
}

class BackgroundPg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('android/assets/image/Backgroundpge.png'),
          fit: BoxFit.cover, // Adjusts the image to cover the entire background
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          // Positioned(
          //   top: 20,
          //   left: 20,
          //   child: Text(
          //     'Unikki\nDeveloper',
          //     style: TextStyle(
          //       fontFamily: 'Lilita',
          //       fontSize: 14,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // Positioned.fill(
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: Image.asset(
          //       // 'android/assets/image/Biru_dan_Krem_Modern_Menuju_Stabilitas_Finansial_Presentation__1_-removebg-preview.png',
          //     ),
          //   ),
          // ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 305.0, bottom: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Text(
                          //   'SEMAR',
                          //   style: TextStyle(
                          //     fontFamily: 'Lilita',
                          //     fontSize: 39,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(right: 0.01),
                            // child: Text(
                            //   'Seputar Semarang',
                            //   style: TextStyle(
                            //     fontFamily: 'Lilita',
                            //     fontSize: 18,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 315.0, top: 90.0),
                      child: Opacity(
                        opacity: 0.7,
                        child: Container(
                          width: 134,
                          height: 134,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 249, 247, 246),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(_createRoute());
                            },
                            child: Center(
                              child: Icon(
                                Icons.play_arrow,
                                size: 100,
                                color: const Color.fromARGB(255, 114, 193, 201),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 3,
            // Adjust the position as needed
            right: 10,
            left: 700, // Adjust the position as needed
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
              child: Image.asset(
                'android/assets/image/tombol unikki 1.png', // Ganti dengan path gambar Anda
                width: 70, // Adjust the size as needed
                height: 70, // Adjust the size as needed
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 20,
            bottom: 310,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
                SizedBox(width: 10), // Space between the icons
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            left: 55,
            child: Container(
              width: 30, // Ukuran logo
              height: 30, // Ukuran logo
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'android/assets/image/Group 16-2.png'), // Ganti dengan path logo Instagram Anda
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ), // Space between the icon and text
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MenuPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return Stack(
        children: [
          _buildDoor(context, animation, true),
          _buildDoor(context, animation, false),
          FadeTransition(
            opacity: animation,
            child: child,
          ),
        ],
      );
    },
    transitionDuration: Duration(seconds: 1), // Set the duration to 2 seconds
  );
}

Widget _buildDoor(
    BuildContext context, Animation<double> animation, bool isLeft) {
  final width = MediaQuery.of(context).size.width / 2;
  final height = MediaQuery.of(context).size.height;

  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      return Positioned(
        left: isLeft ? 0 : null,
        right: isLeft ? null : 0,
        child: Transform(
          alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateY((isLeft ? -1 : 1) *
                (1 - animation.value) *
                1.57), // 1.57 radians = 90 degrees
          child: Container(
            width: width,
            height: height,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      );
    },
  );
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProfilePage(userId: userCredential.user?.uid ?? ''),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Pengguna tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        message = 'Kata sandi salah';
      } else {
        message = 'Terjadi kesalahan';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23.0, top: 18.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Masuk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: 'LilitaOne',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(50, -8),
                  child: Text(
                    'Masuk dengan Akun Unikkimu!',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'MontserratAl',
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 30.0), // Memberi jarak tambahan dari atas
            child: SingleChildScrollView(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 90),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                          ),
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                          ),
                          child: Text(
                            'Daftar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 350,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Kata Sandi',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  loginUser(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Masuk',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                );
                              },
                              child: Text(
                                'Belum Punya Akun? Ayo kita mendaftar!',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      // Background image
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Ganti dengan path gambar background
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 23.0, top: 18.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 3),
                Text(
                  'Masuk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'LilitaOne',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(50, -8),
              child: Text(
                'Masuk dengan Akun Unikkimu!',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'MontserratAl',
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
      Center(
          child: SingleChildScrollView(
              // Tambahkan SingleChildScrollView di sini
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            // Tombol Masuk dan Daftar di sebelah kiri form
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 90), // jarak dari atas
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                    ),
                  ),
                  child: Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                    ),
                  ),
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            // Form register dengan scroll dan ukuran yang lebih kecil
            Center(
              child: Container(
                width: 350, // Lebar form diperkecil
                height: 335, // Tinggi form juga diperkecil
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color:
                      Colors.white.withOpacity(0.9), // Transparansi pada form
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Input Nama
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Kamu',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 10), // Jarak antar input dikurangi sedikit
                      // Input Username
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Pengguna',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Input Email
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Alamat Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Input Kata Sandi
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Kata Sandi',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      // Tombol Daftar
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Logika register
                            String name = nameController.text.trim();
                            String username = usernameController.text.trim();
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();

                            if (name.isNotEmpty &&
                                username.isNotEmpty &&
                                email.isNotEmpty &&
                                password.isNotEmpty) {
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: email, password: password);

                                // Simpan data ke Firestore
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userCredential.user!.uid)
                                    .set({
                                  'name': name,
                                  'username': username,
                                  'email': email,
                                  'registrationDate': DateTime.now().toString(),
                                });

                                // Redirect ke halaman login atau profil
                                Navigator.pop(context);
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Daftar',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ])))
    ]));
  }
}

class ProfilPage extends StatelessWidget {
  // Metode untuk membuat container
  Widget _buildContainer(String title, String assetPath) {
    return Container(
      width: 230,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            height: 85,
            width: 85,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Lilita',
              fontSize: 16,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Metode build yang benar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.home, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomeScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return Stack(
                        children: [
                          _buildDoor(context, animation, true),
                          _buildDoor(context, animation, false),
                          FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ],
                      );
                    },
                    transitionDuration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Menu Apa Yang Mau Kamu Pilih?',
                      style: TextStyle(
                        fontFamily: 'Lilita',
                        fontSize: 25,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
  child: Transform.translate(
    offset: Offset(-20, 0), // Geser kedua container ke kiri
    child: Row(
      mainAxisSize: MainAxisSize.min, // Buat row seminimal mungkin
      children: [
        _buildContainer(
          'Informasi', 
          'assets/images/book.png',
        ),
        _buildContainer(
          'Quiz', 
          'assets/images/quiz.png',
        ),
      ],
    ),
  ),
),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HoneycombPageRoute extends PageRouteBuilder {
  final Widget page;
  HoneycombPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return HoneycombTransition(
              animation: animation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 1000),
          reverseTransitionDuration: Duration(milliseconds: 1000),
        );
}

class HoneycombTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  HoneycombTransition({required this.child, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        if (animation.status == AnimationStatus.completed) {
          return child!;
        }
        return ClipPath(
          clipper: HoneycombClipper(progress: animation.value),
          child: child,
        );
      },
      child: child,
    );
  }
}

class HoneycombClipper extends CustomClipper<Path> {
  final double progress;

  HoneycombClipper({required this.progress});

  @override
  Path getClip(Size size) {
    if (progress >= 1.0) {
      return Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    final path = Path();
    final hexagonSize = size.width / 10;
    final columns = (size.width / hexagonSize).ceil() + 1;
    final rows = (size.height / (hexagonSize * math.sqrt(3) / 2)).ceil() + 1;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        final centerX = col * hexagonSize * 3 / 2;
        final centerY = row * hexagonSize * math.sqrt(3) / 2 +
            (col.isOdd ? hexagonSize * math.sqrt(3) / 4 : 0);
        final hexProgress =
            (progress * 2 - (centerX + centerY) / size.width).clamp(0.0, 1.0);

        if (hexProgress > 0) {
          drawHexagon(path, centerX, centerY, hexagonSize * hexProgress);
        }
      }
    }

    return path;
  }

  void drawHexagon(Path path, double centerX, double centerY, double size) {
    final vertices = List.generate(6, (index) {
      final angle = index * math.pi / 3;
      return Offset(
        centerX + size * math.cos(angle),
        centerY + size * math.sin(angle),
      );
    });

    path.moveTo(vertices[0].dx, vertices[0].dy);
    for (int i = 1; i < 6; i++) {
      path.lineTo(vertices[i].dx, vertices[i].dy);
    }
    path.close();
  }

  @override
  bool shouldReclip(HoneycombClipper oldClipper) =>
      progress != oldClipper.progress;
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.home, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomeScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return Stack(
                        children: [
                          _buildDoor(context, animation, true),
                          _buildDoor(context, animation, false),
                          FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ],
                      );
                    },
                    transitionDuration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Teks di atas tombol
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Menu Apa Yang Mau Kamu Pilih?',
                      style: TextStyle(
                        fontFamily: 'Lilita',
                        fontSize: 25,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Baris pertama tombol
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButtonWithAsset(
                        context,
                        'Informasi baceull',
                        'assets/images/book.png',
                        StartPage(),
                      ),
                      SizedBox(width: 70),
                      _buildButtonWithAsset(
                        context,
                        'Quiz',
                        'assets/images/quiz.png',
                        QuizPage(),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoor(
      BuildContext context, Animation<double> animation, bool isLeft) {
    final width = MediaQuery.of(context).size.width / 2;
    final height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          left: isLeft ? 0 : null,
          right: isLeft ? null : 0,
          child: Transform(
            alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY((isLeft ? -1 : 1) * (1 - animation.value) * 1.57),
            child: Container(
              width: width,
              height: height,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonWithAsset(
      BuildContext context, String buttonText, String assetPath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Stack(
        children: [
          // Background semi-transparan
          Opacity(
            opacity: 0.9,
            child: Container(
              width: 230,
              height: 210,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          // Konten tombol (gambar dan teks) dengan align center
          Container(
            width: 230,
            height: 210,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    assetPath,
                    height: 85,
                    width: 85,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontFamily: 'Lilita',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MenuPage()), // Ganti StartPage dengan MenuPage
                );
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Teks di atas tombol
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, bottom: 10.0, right: 17.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Tema Apa Yang Mau Kamu Pilih?',
                          style: TextStyle(
                            fontFamily: 'Lilita',
                            fontSize: 25,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 2.0,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Baris pertama tombol
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildButtonWithAsset(
                          context,
                          'Sejarah Semarang',
                          'android/assets/image/asetLB.png',
                          SejarahSemarangPage(),
                        ),
                        SizedBox(width: 20),
                        _buildButtonWithAsset(
                          context,
                          'Monumen',
                          'android/assets/image/mnon.png',
                          MonumenPage(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Baris kedua tombol
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildButtonWithAsset(
                          context,
                          'Destinasi',
                          'android/assets/image/dstn.png',
                          DestinasiPage(),
                        ),
                        SizedBox(width: 20),
                        _buildButtonWithAsset(
                          context,
                          'Makanan',
                          'android/assets/image/mkn.png',
                          MakananPage(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Tombol tambahan untuk Quiz
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWithAsset(
      BuildContext context, String buttonText, String assetPath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Stack(
        children: [
          // Background semi-transparan
          Opacity(
            opacity: 0.9,
            child: Container(
              width: 180,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          // Konten tombol (gambar dan teks)
          Container(
            width: 180,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  assetPath,
                  height: 85,
                  width: 85,
                ),
                SizedBox(height: 10),
                Text(
                  buttonText,
                  style: TextStyle(
                    fontFamily: 'Lilita',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class Mainkan extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Background(),
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment.center,
//               child: Image.asset(
//                 'android/assets/image/Biru_dan_Krem_Modern_Menuju_Stabilitas_Finansial_Presentation__1_-removebg-preview.png',
//               ),
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 40.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 125.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             'SMART',
//                             style: TextStyle(
//                               fontFamily: 'Lilita',
//                               fontSize: 39,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 1.0),
//                             child: Text(
//                               'Semarang’s Truth',
//                               style: TextStyle(
//                                 fontFamily: 'Lilita',
//                                 fontSize: 18,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Teks di atas tombol
//                   Padding(
//                     padding: const EdgeInsets.only(right: 40.0, bottom: 20.0),
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         'Tema apa yang mau kamu pilih?',
//                         style: TextStyle(
//                           fontFamily: 'Lilita',
//                           fontSize: 20,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Tombol Mainkan
//                   buildOpacityButton(context, 'Mainkan', StartPage()),
//                   SizedBox(height: 20),
//                   // Tombol Pengaturan
//                   buildOpacityButton(context, 'Pengaturan', MorePage()),
//                   SizedBox(height: 20),
//                   // Tombol Tentang Kami
//                   buildOpacityButton(context, 'Tentang Kami', SettingsPage()),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Fungsi untuk membangun tombol dengan opasitas
//   Widget buildOpacityButton(BuildContext context, String text, Widget page) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 40.0),
//         child: Opacity(
//           opacity: 0.7, // Opasitas tombol diatur di sini
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               fixedSize: Size(280, 45), // Perkecil ukuran tombol
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(11),
//               ),
//               backgroundColor: Color(0xFFFFE9CC),
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => page),
//               );
//             },
//             child: Text(
//               text,
//               style: TextStyle(
//                 fontFamily: 'Lilita',
//                 fontSize: 24,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Menggunakan pop untuk kembali ke halaman sebelumnya
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Teks di atas tombol
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, bottom: 10.0, right: 17.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Quiz Apa Yang Mau Kamu Pilih?',
                          style: TextStyle(
                            fontFamily: 'Lilita',
                            fontSize: 25,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 2.0,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Baris pertama tombol
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildButtonWithAsset(
                          context,
                          'Sejarah Semarang',
                          'android/assets/image/asetLB.png',
                          SejarahQuizPage(),
                        ),
                        SizedBox(width: 20),
                        _buildButtonWithAsset(
                          context,
                          'Monumen',
                          'android/assets/image/mnon.png',
                          MonumenQuizPage(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Baris kedua tombol
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildButtonWithAsset(
                          context,
                          'Destinasi',
                          'android/assets/image/dstn.png',
                          DestinasiQuizPage(),
                        ),
                        SizedBox(width: 20),
                        _buildButtonWithAsset(
                          context,
                          'Makanan',
                          'android/assets/image/mkn.png',
                          MakananQuizPage(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Tombol tambahan untuk Quiz
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWithAsset(
      BuildContext context, String buttonText, String assetPath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Stack(
        children: [
          // Background semi-transparan
          Opacity(
            opacity: 0.9,
            child: Container(
              width: 180,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          // Konten tombol (gambar dan teks)
          Container(
            width: 180,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  assetPath,
                  height: 85,
                  width: 85,
                ),
                SizedBox(height: 10),
                Text(
                  buttonText,
                  style: TextStyle(
                    fontFamily: 'Lilita',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SejarahQuizPage extends StatefulWidget {
  @override
  _SjQuizPageState createState() => _SjQuizPageState();
}

class _SjQuizPageState extends State<SejarahQuizPage> {
  int _currentQuestionIndex = 0;
  bool _isAnswered = false;
  String _selectedAnswer = '';
  int _score = 0;
  Timer? _timer;
  int _timeRemaining = 25;

  final List<Map<String, Object>> _questions = [
    {
      'question':
          'Peristiwa apakah yang memicu Pertempuran Lima Hari di Semarang? ',
      'options': [
        'a. Penyerbuan Jepang terhadap tentara Belanda ',
        'b. Penolakan tentara Jepang untuk menyerahkan senjata ',
        'c. Invasi militer Belanda setelah Proklamasi '
      ],
      'answer': 'b. Penolakan tentara Jepang untuk menyerahkan senjata ',
    },
    {
      'question':
          'Apa yang dimaksud dengan Pertempuran Lima Hari di Semarang? ',
      'options': [
        'a. Perlawanan rakyat Semarang terhadap tentara Belanda ',
        'b. Pertempuran antara Jepang dan Sekutu ',
        'c. Perlawanan rakyat Semarang terhadap tentara Jepang'
      ],
      'answer': 'c. Perlawanan rakyat Semarang terhadap tentara Jepang',
    },
    {
      'question': 'Pertempuran ini terjadi sebagai reaksi terhadap ',
      'options': [
        'a. Karena memiliki beragam gunung    ',
        'b. Karena kota ini memiliki keragaman ekonomi, sosial, dan budaya ',
        'c.Karena menjadi pusat perdagangan   '
      ],
      'answer':
          'b. Karena kota ini memiliki keragaman ekonomi, sosial, dan budaya ',
    },
    {
      'question': 'Kapan Pertempuran Lima Hari di Semarang terjadi? ',
      'options': [
        'a. 15-19 Oktober 1945 ',
        'b. 10-14 September 1945 ',
        'c. 1-5 November 1945 '
      ],
      'answer': 'a. 15-19 Oktober 1945 ',
    },
    {
      'question': 'Mengapa Dr. Kariadi dibunuh oleh tantara Jepang? ',
      'options': [
        'a. Karena dianggap mata-mata sekutu ',
        'b. Karena sedang memeriksa pencemaran air oleh tantara Jepang',
        'c. Karena menolak memberikan bantuan medis kepada tentara Jepang  '
      ],
      'answer': 'b. Karena sedang memeriksa pencemaran air oleh tantara Jepang',
    },
    {
      'question': 'Pertempuran Lima Hari di Semarang dipusatkan di daerah? ',
      'options': ['a. Tugu Muda ', 'b. Simpang Lima ', 'c. Taman Siranda'],
      'answer': 'a. Tugu Muda ',
    },
    {
      'question':
          'Siapa yang memimpin perlawanan rayat Semarang dalam pertempuran ini?  ',
      'options': ['a. Soekarno  ', 'b. TKR Soegijono ', 'c.Bung Tomo '],
      'answer': 'b. TKR Soegijono ',
    },
    {
      'question': 'Berapa  hari berlangsungnya pertempuran ini? ',
      'options': ['a. 3 hari ', 'b. 5 hari ', 'c. 7 hari '],
      'answer': 'b. 5 hari ',
    },
    {
      'question':
          'Pertempuran Lima Hari di Semarang menunjukkan semangat rakyat Indonesia dalam ',
      'options': [
        'a. Melawan penjajahan Jepang ',
        'b. Melindungi sekutu   ',
        'c. Mendukung pemerintahan colonial  '
      ],
      'answer': 'a. Melawan penjajahan Jepang ',
    },
    {
      'question':
          'Sebelum menjadi sebuah kota, dulunya, Semarang merupakan daerah pesisir yang merupakan bagian dari Kerajaan Mataram Kuno yang disebut…  ',
      'options': ['a. Margonda', 'b. Pragota', 'c. Pratogar '],
      'answer': 'b. Pragota',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _showAnswerFeedback(false);
        }
      });
    });
  }

  void _nextQuestion() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _isAnswered = false;
      _selectedAnswer = '';
      _timeRemaining = 25;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _startTimer();
      } else {
        _navigateToScorePage();
      }
    });
  }

  void _answerQuestion(String answer) {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        _selectedAnswer = answer;
        _timer?.cancel();
      });

      bool isCorrect = answer == _questions[_currentQuestionIndex]['answer'];
      if (isCorrect) {
        _score += 10;
      }
      _showAnswerFeedback(isCorrect);
    }
  }

  void _showAnswerFeedback(bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? "Jawaban Benar!" : "Jawaban Salah!"),
        content: Text(isCorrect
            ? "Anda mendapatkan 10 poin."
            : "Jawaban yang benar adalah: ${_questions[_currentQuestionIndex]['answer']}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextQuestion();
            },
            child: Text("Lanjut"),
          ),
        ],
      ),
    );
  }

  void _navigateToScorePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScorePage(
          score: _score,
          maxScore:
              _questions.length * 10, // Misalnya setiap soal bernilai 10 poin
          totalQuestions: _questions.length,
          quizTitle: "Quiz 1 - Sejarah Semarang", // Judul kuis yang sesuai
        ),
      ),
    );
  }

  Color _getOptionColor(String option) {
    if (!_isAnswered) return Colors.green[800]!;
    if (option == _questions[_currentQuestionIndex]['answer'] &&
        option == _selectedAnswer) {
      return Colors.lightGreen;
    } else if (option == _selectedAnswer &&
        option != _questions[_currentQuestionIndex]['answer']) {
      return Colors.red;
    } else {
      return Colors.green[800]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 5.0),
                Text(
                  'SEMAR\nSeputar Semarang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 560,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _questions[_currentQuestionIndex]['question']
                                as String,
                            style: TextStyle(
                              fontFamily: 'Lilita',
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ...(_questions[_currentQuestionIndex]['options']
                                as List<String>)
                            .map((option) {
                          return GestureDetector(
                            onTap: () => _answerQuestion(option),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: _getOptionColor(option),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                option,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Waktu tersisa: $_timeRemaining detik',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int maxScore;
  final String quizTitle;

  ScorePage({
    required this.score,
    required this.totalQuestions,
    required this.maxScore,
    required this.quizTitle,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (score / maxScore) * 100;

    String achievementMessage;
    if (percentage == 100) {
      achievementMessage =
          "Selamat! Kamu berhasil menyelesaikan kuis ini dengan luar biasa!";
    } else if (percentage >= 90) {
      achievementMessage =
          "Luar biasa! Kamu berhasil menyelesaikan kuis ini dengan baik!";
    } else if (percentage >= 75) {
      achievementMessage = "Keren, ini sebuah pencapaian yang bagus";
    } else if (percentage >= 55) {
      achievementMessage = "Hebat, Anda sudah hampir menguasai materi ini";
    } else {
      achievementMessage = "Anda belum menguasai materi ini, ayo coba lagi";
    }

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quizTitle,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container untuk Skor
                  Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 290,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 60,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Selesai!",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Anda mendapatkan",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$score",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  // Container untuk Persentase dan Tombol
                  Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Tombol Benar
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.check,
                                      color: Colors.white, size: 16),
                                  SizedBox(width: 5),
                                  Text("Benar",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                            ),
                            // Tombol Salah
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  SizedBox(width: 5),
                                  Text("Salah",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Lingkaran Persentase
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: CircularProgressIndicator(
                                value: percentage / 100,
                                strokeWidth: 6,
                                color: Colors.green,
                                backgroundColor: Colors.grey[300],
                              ),
                            ),
                            Text(
                              "${percentage.toStringAsFixed(0)}%",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          achievementMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Tingkatkan pemahaman anda mengenai ${quizTitle.split(' - ')[1]} lebih lanjut.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 15),
                        // Row untuk tombol "Ulangi" dan "Kembali"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              onPressed: () {
                                // Menentukan halaman yang akan dituju berdasarkan judul kuis
                                if (quizTitle == "Quiz 1 - Sejarah Semarang") {
                                  Navigator.pushNamed(
                                      context, '/SejarahQuizPage');
                                } else if (quizTitle == "Quiz 2 - Monumen") {
                                  Navigator.pushNamed(
                                      context, '/MonumenQuizPage');
                                } else if (quizTitle == "Quiz 3 - Destinasi") {
                                  Navigator.pushNamed(
                                      context, '/DestinasiQuizPage');
                                } else if (quizTitle == "Quiz 4 - Makanan") {
                                  Navigator.pushNamed(
                                      context, '/MakananQuizPage');
                                }
                              },
                              child: Text("Ulangi"),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context,
                                    '/QuizPage'); // Sesuaikan rute halaman beranda kuis
                              },
                              child: Text("Kembali"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MonumenQuizPage extends StatefulWidget {
  @override
  _MonQuizPageState createState() => _MonQuizPageState();
}

class _MonQuizPageState extends State<MonumenQuizPage> {
  int _currentQuestionIndex = 0;
  bool _isAnswered = false;
  String _selectedAnswer = '';
  int _score = 0;
  Timer? _timer;
  int _timeRemaining = 25;

  final List<Map<String, Object>> _questions = [
    {
      'question':
          'Apa nama monumen yang menjadi simbol peringatan perjuangan lima hari di Semarang?',
      'options': [
        'a. Tugu Muda',
        'b. Patung Diponegoro',
        'c. Tugu Proklamator'
      ],
      'answer': 'a. Tugu Muda',
    },
    {
      'question': 'Di mana lokasi Tugu Muda di Semarang?',
      'options': [
        'a. Simpang Lima',
        'b. Kawasan Lawang Sewu',
        'c. Jalan Pemuda'
      ],
      'answer': 'b. Kawasan Lawang Sewu',
    },
    {
      'question': 'Tugu Proklamator didirikan untuk mengenang siapa?',
      'options': [
        'a. Ir. Soekarno dan Drs. Moh. Hatta',
        'b. Ki Hajar Dewantara',
        'c. RA Kartini'
      ],
      'answer': 'a. Ir. Soekarno dan Drs. Moh. Hatta',
    },
    {
      'question':
          'Apa yang menjadi ciri khas utama dari Patung Diponegoro di Semarang?',
      'options': [
        'a. Diponegoro menunggang kuda',
        'b. Diponegoro memegang keris',
        'c. Diponegoro menggunakan sorban'
      ],
      'answer': 'a. Diponegoro menunggang kuda',
    },
    {
      'question': 'Monumen Tugu Muda dibangun untuk mengenang peristiwa apa?',
      'options': [
        'a. Perang Diponegoro',
        'b. Perjuangan Lima Hari di Semarang',
        'c. Proklamasi Kemerdekaan'
      ],
      'answer': 'b. Perjuangan Lima Hari di Semarang',
    },
    {
      'question': 'Tugu Proklamator terletak di kota mana?',
      'options': ['a. Semarang', 'b. Jakarta', 'c. Yogyakarta'],
      'answer': 'b. Jakarta',
    },
    {
      'question':
          'Patung Diponegoro di Semarang sering dikunjungi untuk tujuan apa?',
      'options': [
        'a. Wisata religi',
        'b. Mengenang sejarah pahlawan',
        'c. Melihat keindahan arsitektur modern'
      ],
      'answer': 'b. Mengenang sejarah pahlawan',
    },
    {
      'question': 'Apa warna utama Tugu Muda di Semarang?',
      'options': ['a. Merah', 'b. Hitam', 'c. Putih'],
      'answer': 'b. Hitam',
    },
    {
      'question':
          'Patung Diponegoro yang ada di Semarang terletak di area mana?',
      'options': [
        'a. Alun-Alun Simpang Lima',
        'b. Kawasan Taman Diponegoro',
        'c. Depan Kantor Gubernur'
      ],
      'answer': 'b. Kawasan Taman Diponegoro',
    },
    {
      'question':
          'Tugu Muda memiliki bentuk arsitektur yang terinspirasi dari apa?',
      'options': ['a. Obelisk', 'b. Stupa', 'c. Pilar Yunani'],
      'answer': 'a. Obelisk',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _showAnswerFeedback(false);
        }
      });
    });
  }

  void _nextQuestion() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _isAnswered = false;
      _selectedAnswer = '';
      _timeRemaining = 25;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _startTimer();
      } else {
        _navigateToScorePage();
      }
    });
  }

  void _answerQuestion(String answer) {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        _selectedAnswer = answer;
        _timer?.cancel();
      });

      bool isCorrect = answer == _questions[_currentQuestionIndex]['answer'];
      if (isCorrect) {
        _score += 10;
      }
      _showAnswerFeedback(isCorrect);
    }
  }

  void _showAnswerFeedback(bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? "Jawaban Benar!" : "Jawaban Salah!"),
        content: Text(isCorrect
            ? "Anda mendapatkan 10 poin."
            : "Jawaban yang benar adalah: ${_questions[_currentQuestionIndex]['answer']}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextQuestion();
            },
            child: Text("Lanjut"),
          )
        ],
      ),
    );
  }

  void _navigateToScorePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScorePage(
          score: _score,
          maxScore:
              _questions.length * 10, // Misalnya setiap soal bernilai 10 poin
          totalQuestions: _questions.length,
          quizTitle: "Quiz 2 - Monumen", // Judul kuis yang sesuai
        ),
      ),
    );
  }

  Color _getOptionColor(String option) {
    if (!_isAnswered) return Colors.green[800]!;
    if (option == _questions[_currentQuestionIndex]['answer'] &&
        option == _selectedAnswer) {
      return Colors.lightGreen;
    } else if (option == _selectedAnswer &&
        option != _questions[_currentQuestionIndex]['answer']) {
      return Colors.red;
    } else {
      return Colors.green[800]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 5.0),
                Text(
                  'SEMAR\nSeputar Semarang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 560,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _questions[_currentQuestionIndex]['question']
                                as String,
                            style: TextStyle(
                              fontFamily: 'Lilita',
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ...(_questions[_currentQuestionIndex]['options']
                                as List<String>)
                            .map((option) {
                          return GestureDetector(
                            onTap: () => _answerQuestion(option),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: _getOptionColor(option),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                option,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Waktu tersisa: $_timeRemaining detik',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DestinasiQuizPage extends StatefulWidget {
  @override
  _DesQuizPageState createState() => _DesQuizPageState();
}

class _DesQuizPageState extends State<DestinasiQuizPage> {
  int _currentQuestionIndex = 0;
  bool _isAnswered = false;
  String _selectedAnswer = '';
  int _score = 0;
  Timer? _timer;
  int _timeRemaining = 25;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'Goa Kreo dihuni oleh?',
      'options': [
        'a. Kucing Liar',
        'b. Monyet Ekor Panjang',
        'c. Burung Merpati'
      ],
      'answer': 'a. Asem Arang',
    },
    {
      'question': ' Lawang Sewu awalnya dibangun sebagai kantor untuk ?',
      'options': [
        'a. Pt. Kereta Api Indonesia',
        'b. Perusahaan Kereta Api NIS',
        'c. Pemerintahan Belanda'
      ],
      'answer': 'b. Perusahaan Kereta Api Indonesia NIS',
    },
    {
      'question': 'Saat ini Goa Kreo dikelilingi oleh apa?',
      'options': [
        'a. Waduk Jati Barang',
        'b. Sungai Banjir Kanal',
        'c. Danau Rawa Pening'
      ],
      'answer': 'a. Waduk Jati Barang',
    },
    {
      'question':
          'Pada masa pendudukan Jepang, Lawang Sewu digunakan sebagai: ',
      'options': [
        'a. Museum Kereta Api',
        'b. Markas Belanda',
        'c. Penjara dan Kantor Transportasi'
      ],
      'answer': 'c. Penjara dan Kantor Transportasi',
    },
    {
      'question':
          'Nama “Blenduk” berasal dari bahasa Jawa “mblenduk” yang artinya: ',
      'options': [
        'a. Menonjol atau Membesar',
        'b. Besar dan Megah',
        'c. Tinggi dan Kokoh'
      ],
      'answer': 'a. Menonjol atau Membesar',
    },
    {
      'question':
          'Siapa yang dipercaya sebagai tokoh yang menjadi inspirasi dibangunnya Klenteng Sampokong?',
      'options': [
        'a. Sunan Kalijaga',
        'b. Laksamana Cheng Ho',
        'c. Admiral Yi'
      ],
      'answer': 'b. Laksamana Cheng Ho',
    },
    {
      'question':
          'Klenteng Sampokong merupakan tempat ibadah yang digunakan oleh umat?',
      'options': ['a. Hindu', 'b. Islam', 'c. Konghucu'],
      'answer': 'c. Konghucu',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _showAnswerFeedback(false);
        }
      });
    });
  }

  void _nextQuestion() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _isAnswered = false;
      _selectedAnswer = '';
      _timeRemaining = 25;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _startTimer();
      } else {
        _navigateToScorePage();
      }
    });
  }

  void _answerQuestion(String answer) {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        _selectedAnswer = answer;
        _timer?.cancel();
      });

      bool isCorrect = answer == _questions[_currentQuestionIndex]['answer'];
      if (isCorrect) {
        _score += 10;
      }
      _showAnswerFeedback(isCorrect);
    }
  }

  void _showAnswerFeedback(bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? "Jawaban Benar!" : "Jawaban Salah!"),
        content: Text(isCorrect
            ? "Anda mendapatkan 10 poin."
            : "Jawaban yang benar adalah: ${_questions[_currentQuestionIndex]['answer']}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextQuestion();
            },
            child: Text("Lanjut"),
          )
        ],
      ),
    );
  }

  void _navigateToScorePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScorePage(
          score: _score,
          maxScore:
              _questions.length * 10, // Misalnya setiap soal bernilai 10 poin
          totalQuestions: _questions.length,
          quizTitle: "Quiz 3 - Destinasi", // Judul kuis yang sesuai
        ),
      ),
    );
  }

  Color _getOptionColor(String option) {
    if (!_isAnswered) return Colors.green[800]!;
    if (option == _questions[_currentQuestionIndex]['answer'] &&
        option == _selectedAnswer) {
      return Colors.lightGreen;
    } else if (option == _selectedAnswer &&
        option != _questions[_currentQuestionIndex]['answer']) {
      return Colors.red;
    } else {
      return Colors.green[800]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 5.0),
                Text(
                  'SEMAR\nSeputar Semarang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 560,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _questions[_currentQuestionIndex]['question']
                                as String,
                            style: TextStyle(
                              fontFamily: 'Lilita',
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ...(_questions[_currentQuestionIndex]['options']
                                as List<String>)
                            .map((option) {
                          return GestureDetector(
                            onTap: () => _answerQuestion(option),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: _getOptionColor(option),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                option,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Waktu tersisa: $_timeRemaining detik',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MakananQuizPage extends StatefulWidget {
  @override
  _MknQuizPageState createState() => _MknQuizPageState();
}

class _MknQuizPageState extends State<MakananQuizPage> {
  int _currentQuestionIndex = 0;
  bool _isAnswered = false;
  String _selectedAnswer = '';
  int _score = 0;
  Timer? _timer;
  int _timeRemaining = 25;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'Lumpia Semarang biasanya berisi campuran apa?',
      'options': [
        'a. Ayam dan sayuran',
        'b. Rebung dan daging',
        'c. Kacang dan ikan'
      ],
      'answer': 'b. Rebung dan daging',
    },
    {
      'question':
          'Apa bahan utama yang digunakan untuk membuat gimbal dalam tahu gimbal?',
      'options': ['a. Tahu', 'b. Udang', 'c. Tempe'],
      'answer': 'b. Udang',
    },
    {
      'question':
          'Apa ciri khas dari bandeng presto yang membuatnya berbeda dengan ikan bandeng biasa?',
      'options': [
        'a. Ukurannya lebih besar',
        'b. Dimasak tanpa duri',
        'c. Dimasak dengan tekanan tinggi sehingga durinya lunak'
      ],
      'answer': 'c. Dimasak dengan tekanan tinggi sehingga durinya lunak',
    },
    {
      'question': 'Apa bahan utama dalam pembuatan Wingko Babat?',
      'options': [
        'a. Kelapa dan tepung ketan',
        'b. Singkong dan gula merah',
        'c. Beras dan kelapa'
      ],
      'answer': 'a. Kelapa dan tepung ketan',
    },
    {
      'question': 'Lumpia Semarang sering disajikan dengan saus berwarna apa?',
      'options': ['a. Cokelat', 'b. Merah', 'c. Kuning'],
      'answer': 'a. Cokelat',
    },
    {
      'question': 'Tahu gimbal disajikan dengan kuah berbahan dasar apa?',
      'options': ['a. Kecap', 'b. Sambal kacang', 'c. Kuah santan'],
      'answer': 'b. Sambal kacang',
    },
    {
      'question': 'Wingko Babat biasanya berbentuk apa?',
      'options': ['a. Kotak', 'b. Bulat', 'c. Segitiga'],
      'answer': 'b. Bulat',
    },
    {
      'question':
          'Bandeng presto biasanya dijual dalam kemasan yang memiliki ciri khas apa?',
      'options': [
        'a. Kemasan bambu',
        'b. Kemasan plastik',
        'c. Kemasan daun pisang'
      ],
      'answer': 'a. Kemasan bambu',
    },
    {
      'question': 'Apa nama saus khas yang sering disajikan dengan lumpia?',
      'options': ['a. Sambal terasi', 'b. Saus kacang', 'c. Saus bawang putih'],
      'answer': 'c. Saus bawang putih',
    },
    {
      'question': 'Tahu gimbal sering disajikan dengan bahan pelengkap apa?',
      'options': ['a. Kerupuk udang', 'b. Lontong', 'c. Bakso'],
      'answer': 'b. Lontong',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _showAnswerFeedback(false);
        }
      });
    });
  }

  void _nextQuestion() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _isAnswered = false;
      _selectedAnswer = '';
      _timeRemaining = 25;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _startTimer();
      } else {
        _navigateToScorePage();
      }
    });
  }

  void _answerQuestion(String answer) {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        _selectedAnswer = answer;
        _timer?.cancel();
      });

      bool isCorrect = answer == _questions[_currentQuestionIndex]['answer'];
      if (isCorrect) {
        _score += 10;
      }
      _showAnswerFeedback(isCorrect);
    }
  }

  void _showAnswerFeedback(bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? "Jawaban Benar!" : "Jawaban Salah!"),
        content: Text(isCorrect
            ? "Anda mendapatkan 10 poin."
            : "Jawaban yang benar adalah: ${_questions[_currentQuestionIndex]['answer']}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextQuestion();
            },
            child: Text("Lanjut"),
          )
        ],
      ),
    );
  }

  void _navigateToScorePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScorePage(
          score: _score,
          maxScore:
              _questions.length * 10, // Misalnya setiap soal bernilai 10 poin
          totalQuestions: _questions.length,
          quizTitle: "Quiz 4 - Makanan", // Judul kuis yang sesuai
        ),
      ),
    );
  }

  Color _getOptionColor(String option) {
    if (!_isAnswered) return Colors.green[800]!;
    if (option == _questions[_currentQuestionIndex]['answer'] &&
        option == _selectedAnswer) {
      return Colors.lightGreen;
    } else if (option == _selectedAnswer &&
        option != _questions[_currentQuestionIndex]['answer']) {
      return Colors.red;
    } else {
      return Colors.green[800]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 5.0),
                Text(
                  'SEMAR\nSeputar Semarang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 560,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _questions[_currentQuestionIndex]['question']
                                as String,
                            style: TextStyle(
                              fontFamily: 'Lilita',
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ...(_questions[_currentQuestionIndex]['options']
                                as List<String>)
                            .map((option) {
                          return GestureDetector(
                            onTap: () => _answerQuestion(option),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: _getOptionColor(option),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                option,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Waktu tersisa: $_timeRemaining detik',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          // Positioned.fill(
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: Image.asset(
          //       'android/assets/image/Biru_dan_Krem_Modern_Menuju_Stabilitas_Finansial_Presentation__1_-removebg-preview.png',
          //       // Same background image as in HomeScreen
          //     ),
          //   ),
          // ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.home, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // Navigate back to home
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'DALAM PENGEMBANGAN',
                style: TextStyle(
                  fontFamily: 'Lilita',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double volumeSuara = 0.5; // Default volume for "SUARA"
  double volumeMusik = 0.5;
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  get currentVolume => null; // Default volume for "MUSIK"

  @override
  void initState() {
    super.initState();
    // Initialize volume levels (0.0 - 1.0 scale)
    FlutterVolumeController.getVolume().then((value) {
      setState(() {
        volumeSuara = value; 
        volumeMusik = value;
      });
    });
  }

void showVolumeDialog(String type) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.85),
        title: Text(
          'Atur Volume $type',
          style: const TextStyle(
            fontFamily: 'Lilita',
            fontSize: 20,
          ),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            double currentVolume = type == 'Suara' ? volumeSuara : volumeMusik;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: currentVolume,
                  min: 0.0,
                  max: 1.0,
                  activeColor: Colors.cyanAccent,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      if (type == 'Suara') {
                        volumeSuara = value;
                      } else {
                        volumeMusik = value;
                      }
                    });
                    setStateDialog(() {}); // Perbarui slider di dalam dialog
                    FlutterVolumeController.setVolume(value); // Panggil metode untuk mengatur volume
                    _audioPlayer.setVolume(value);
                  },
                ),

                // Menambahkan angka di bawah slider
                Text(
                  '${(currentVolume * 100).toStringAsFixed(0)}', // Menampilkan nilai persentase
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lilita',
                    color: Colors.black,
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            child: const Text(
              'Tutup',
              style: TextStyle(
                fontFamily: 'Lilita',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> playSound() async {
    // Memutar file suara lokal atau dari URL
    await _audioPlayer.play(DeviceFileSource('assets/audio/audiocoba1.mp3')); // Ganti path dengan file audio Anda
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/PENGATURAN.1 (2).png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: Row(
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Pengaturan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lilita',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'SUARA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lilita',
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    showVolumeDialog('Suara');
                  },
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'MUSIK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lilita',
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      playSound();
                      showVolumeDialog('Musik');
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlutterVolumeController {
  static void setVolume(double value) {
    // Implementasi setVolume Anda
  }

  static Future<double> getVolume() async {
    // Pastikan fungsi ini mengembalikan nilai double yang valid
    // Gunakan nilai default jika hasilnya null
    double? volume = await FlutterVolumeController.getVolume();
    return volume; // default 0.5 jika null
  }
}

class SejarahSemarangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to home
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'SEJARAH SEMARANG',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Teks di atas tombol
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                      right: 160.0,
                      left: 100.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Mau Mulai Darimana?',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 30,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Baris pertama tombol
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildButtonWithAsset(
                        context,
                        'Pertempuran Lima Hari Di Semarang',
                        'android/assets/image/asetLB.png',
                        PertempuranPage(), // Navigasi ke PertempuranPage
                      ),
                      SizedBox(width: 20),
                      _buildButtonWithAsset(
                        context,
                        'Asal Usul Semarang',
                        'android/assets/image/mnon.png',
                        AsalUsulPage(), // Navigasi ke AsalUsulPage
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua tombol
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun tombol dengan asset dan teks yang berbeda
  Widget _buildButtonWithAsset(
      BuildContext context, String buttonText, String assetPath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade, // Pilih jenis transisi
            child: page,
            duration: Duration(milliseconds: 500), // Durasi transisi
            reverseDuration:
                Duration(milliseconds: 500), // Durasi transisi balik
          ),
        );
      },
      child: Stack(
        children: [
          Opacity(
            opacity: 0.9,
            child: Container(
              width: 220,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          Container(
            width: 220,
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  assetPath,
                  height: 85,
                  width: 80,
                ),
                SizedBox(height: 10),
                Text(
                  buttonText,
                  style: TextStyle(
                    fontFamily: 'Lilita',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PertempuranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to home
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'SEJARAH SEMARANG',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox() {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pertempuran Lima Hari Di Semarang',
                    style: TextStyle(
                      fontFamily: 'Lilita',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 270, // Membatasi lebar maksimum
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          'Pada 17 Agustus 1945, Soekarno dan Hatta memproklamasikan kemerdekaan Indonesia, membawa semangat baru bagi pejuang dan rakyat. Kabar ini menyebar hingga ke Semarang, di mana sedang berlangsung pelucutan senjata tentara Jepang. Namun, pada 14 Oktober 1945, Mayor Kido menolak menyerahkan senjata, memicu kemarahan warga Semarang yang menjadikan aula Rumah Sakit Purusara sebagai markas perlawanan. Pada hari yang sama, pemuda-pemuda rumah sakit menghadang tentara Jepang dan berhasil melucuti senjata mereka, namun balasan datang. Tentara Jepang menyiksa delapan polisi istimewa yang menjaga persediaan air di Wungkal. Ketika Dr. Kariadi berusaha memeriksa air yang diduga diracuni, ia ditembak di Jl. Pandanaran dan meninggal.  Kematian Dr. Kariadi memperkeruh keadaan. Pada 15 Oktober 1945, Angkatan Muda Semarang dan Tentara Keamanan Rakyat melawan 2.000 tentara Jepang. Pertempuran terjadi di Kintelan, Pandanaran, Jombang, dan Simpang Lima. Jepang membalas serangan Indonesia dengan memecah pasukannya dan menyerang hingga 16 Oktober, merebut penjara Bulu.  Pertempuran berlangsung hingga 19 Oktober. Gencatan senjata akhirnya tercapai setelah perundingan antara Indonesia, Jepang, dan perwakilan Sekutu, yang melucuti senjata Jepang pada 20 Oktober 1945, menandai berakhirnya Pertempuran Lima Hari di Semarang.',
                          style: TextStyle(
                            fontFamily: 'Poppins ',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 250,
            color: Colors.black, // Warna garis vertikal
            margin: EdgeInsets.only(
                top: 20, bottom: 20), // Margin atas dan bawah garis vertikal
          ),
          SizedBox(width: 80), // Jarak antara garis vertikal dan aset gambar
          Image.asset(
            'android/assets/image/asetLB.png', // Ganti dengan path aset gambar Anda
            width: 150,
            height: 150,
          ),
        ],
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Amara Silvia',
      'role': 'Ketua Project',
      'image': 'assets/images/foca1/1.png'
    },
    {
      'name': 'Raihan Latif',
      'role': 'Front-End Developer',
      'image': 'assets/images/foca1/2.png'
    },
    {
      'name': 'Nabila Rachmawati',
      'role': 'Front-End Developer',
      'image': 'assets/images/foca1/3.png'
    },
    {
      'name': 'Satrya Arif',
      'role': 'Front-End Developer',
      'image': 'assets/images/foca1/4.png'
    },
    {
      'name': 'Deviana Alma',
      'role': 'Ilustrator',
      'image': 'assets/images/foca1/5.png'
    },
    {
      'name': 'Najiya Rizqi',
      'role': 'System Analyst',
      'image': 'assets/images/foca1/6.png'
    },
    {
      'name': 'Velia Ariyani',
      'role': 'System Analyst',
      'image': 'assets/images/foca1/7.png'
    },
    {
      'name': 'Raisa Sacharissa',
      'role': 'UI/UX Designer',
      'image': 'assets/images/foca1/8.png'
    },
    {
      'name': 'Setia Larasati',
      'role': 'Marketing',
      'image': 'assets/images/foca1/9.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar untuk memastikan layout responsif
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              // Header tanpa AppBar, dengan icon back di bagian kiri
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 20.0, right: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Teams',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: 'LilitaOne',
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'About Unikki Developer',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'MontserratAl',
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    // Kotak "UNIKKI DEVELOPER" di sebelah kiri
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight:
                                screenHeight * 0.7, // Batas maksimal ketinggian
                          ),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            color: Colors.white.withOpacity(0.8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      'assets/images/logo_unikki2.png',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'UNIKKI DEVELOPER',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  // Membuat konten bisa digulir dengan baik
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        'Apa itu Unikki?\nUnikki Developer adalah nama dari tim kami yang beranggotakan 9 orang, kami memiliki visi - misi untuk menciptakan sebuah program berkualitas sebagai bahan edukasi untuk masyarakat Indonesia untuk mudah memahami materi dan mengingat sejarah - sejarah yang sudah terjadi di masa lampau.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: 'MontserratAl',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Grid teams di sebelah kanan
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount =
                                (constraints.maxWidth < 600) ? 2 : 3;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: teamMembers.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.0,
                              ),
                              itemBuilder: (context, index) {
                                return buildPersonCard(
                                  name: teamMembers[index]['name']!,
                                  role: teamMembers[index]['role']!,
                                  image: teamMembers[index]['image']!,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card untuk setiap person di grid
  Widget buildPersonCard(
      {required String name, required String role, required String image}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(image),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2),
          Text(
            role,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class AsalUsulPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to home
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'SEMAR\nSeputar Semarang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox() {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Asal Usul Semarang',
                    style: TextStyle(
                      fontFamily: 'Lilita',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 270, // Membatasi lebar maksimum
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          'Pada masa lampau, Semarang memiliki peran penting bagi Hindia Belanda sebagai salah satu dari tiga pelabuhan utama (bersama Jakarta dan Surabaya) yang memasok hasil bumi dari pedalaman Jawa. Sejarahnya dimulai pada abad ke-8 M, ketika wilayah ini masih bernama Pragota, bagian dari Kerajaan Mataram Kuno. Dulunya, Pragota adalah pelabuhan dengan gugusan pulau-pulau kecil yang akhirnya menyatu membentuk daratan. Pada akhir abad ke-15, Pangeran Made Pandan ditempatkan di Perbukitan Pragota oleh Kerajaan Demak dengan maksud menyebarkan ajaran Islam.    Seiring berjalannya waktu, daerah tersebut semakin subur dan tumbuh pohon asam arang yang menjadi awal mula pemberian nama Semarang. Secara etimologis, nama Semarang berasal dari kata “sem” yang berarti asam/pohon asam dan kata “arang” yang berarti jarang.  Jika digabungkan, maka arti Semarang adalah asam yang jarang-jarang.    Pada tanggal 2 Mei 1547 yang bertepatan dengan Maulid Nabi Muhammad, yaitu 12 Rabiul Awal 954 Hijriah, ditetapkan sebagai hari jadi Kota Semarang berdasarkan hasil diskusi Sultan Hadiwijaya dan Sunan Kalijaga. ',
                          style: TextStyle(
                            fontFamily: 'Poppins ',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 250,
            color: Colors.black, // Warna garis vertikal
            margin: EdgeInsets.only(
                top: 20, bottom: 20), // Margin atas dan bawah garis vertikal
          ),
          SizedBox(width: 80), // Jarak antara garis vertikal dan aset gambar
          Image.asset(
            'android/assets/image/mnon.png', // Ganti dengan path aset gambar Anda
            width: 165,
            height: 165,
          ),
        ],
      ),
    );
  }
}

class MonumenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to home
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MONUMEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Tugu Muda',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/tugumd.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MonumenTugmudPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonumenTugmudPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MONUMEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Tugu Muda',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Tugu Muda di Semarang dibangun sebagai monumen penghormatan bagi para pejuang yang gugur dalam Pertempuran Lima Hari melawan tentara Jepang pada Oktober 1945. Awalnya dibangun pada 1945, namun sempat dihancurkan oleh Belanda. Pada 1952, pembangunan dimulai kembali di Simpang Lima dan diresmikan oleh Presiden Sukarno pada 20 Mei 1953. Tugu ini berbentuk lilin menyala yang melambangkan semangat perjuangan. Struktur tugu terdiri dari landasan, badan, dan kepala, serta dihiasi lima relief yang menggambarkan penderitaan rakyat, pertempuran, penyerangan, korban, dan kemenangan, sekaligus merefleksikan simbol-simbol perjuangan rakyat Indonesia.',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MonumenTugpro1Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonumenTugpro1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MONUMEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Tugu Proklamator',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/tugmud.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MonumenTugpro2Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonumenTugpro2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MONUMEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Tugu Proklamator',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Tugu Proklamator Semarang dibangun pada tahun 1946 untuk memperingati satu tahun Kemerdekaan Indonesia. Tugu ini dirancang oleh Dra. Yos Masdani Tumbuan, seorang mahasiswi dari Ikatan Wanita Djakarta, dan berupa dua patung perunggu Sukarno dan Hatta yang berdiri berdampingan, dengan tinggi masing-masing 46 meter untuk Sukarno dan 43 meter untuk Hatta. Awalnya bernama Tugu Peringatan Satoe Tahoen Repoeblik Indonesia, nama ini kemudian diubah menjadi Tugu Proklamator untuk lebih mencerminkan penghormatan terhadap Soekarno dan Hatta sebagai proklamator. Tugu ini kini menjadi simbol perjuangan kemerdekaan dan tempat peringatan nasional di Semarang, yang mengingatkan masyarakat, terutama generasi muda, tentang pentingnya semangat persatuan dan pengorbanan dalam mempertahankan kemerdekaan.',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MonumenPatdip1Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonumenPatdip1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MONUMEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Patung Diponegoro',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/tugmud.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MonPatdip2Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonPatdip2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MONUMEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Patung Diponegoro',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Patung Diponegoro di Semarang adalah monumen yang didirikan untuk menghormati Pangeran Diponegoro, seorang pahlawan nasional yang memimpin Perang Jawa melawan pemerintah kolonial Belanda pada awal abad ke-19. Patung ini menggambarkan sosok Pangeran Diponegoro yang menunggang kuda, dengan ekspresi penuh semangat dan kepahlawanan. Patung ini terletak di **Simpang Lima**, yang merupakan kawasan pusat kota Semarang, sehingga menjadi salah satu ikon kota yang cukup dikenal. Monumen ini tidak hanya menjadi simbol perlawanan dan keberanian, tetapi juga sebagai pengingat tentang semangat patriotisme dan keteguhan dalam melawan penjajahan. Banyak pengunjung yang datang untuk melihat dan berfoto di depan patung ini sebagai bagian dari wisata sejarah di Semarang.',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MonTitikPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonTitikPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MONUMEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Titik 0 KM',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/tugmud.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MonTitik2Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonTitik2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MONUMEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Titik 0 KM',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Titik Nol Kilometer (0 KM) Semarang adalah penanda geografis yang menandai pusat atau titik awal pengukuran jarak di Kota Semarang. Titik Nol ini berada di kawasan **Kota Lama Semarang**, dekat dengan Gereja Blenduk, yang merupakan area bersejarah dan pusat pemerintahan pada masa kolonial. Titik Nol KM sering menjadi tempat wisatawan memulai perjalanan mereka di Semarang, karena di sekitar area ini terdapat banyak bangunan bersejarah yang mencerminkan arsitektur kolonial Belanda. Selain sebagai landmark, Titik Nol KM ini juga menjadi simbol sejarah dan perkembangan kota Semarang dari masa ke masa.',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DestinasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'DESTINASI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Goa Kreo',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/tugmuod.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DesGoaKreo(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DesGoaKreo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'DESTINASI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Goa Kreo',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Goa Kreo di perbukitan Gunung Krincing, Semarang, adalah tempat wisata alam yang dihuni ratusan monyet ekor panjang, yang terkait dengan legenda Sunan Kalijaga dalam pencarian kayu jati untuk Masjid Agung Demak. Berdasarkan cerita, monyet-monyet tersebut mendapat tugas menjaga kawasan ini sebagai balas jasa. Kini, Goa Kreo dikelilingi oleh Waduk Jatibarang, memberikan kesan seperti pulau kecil. Lokasi ini populer sebagai tempat berfoto, dengan tangga menuju gua dan upacara “Rewanda” untuk memberi makan monyet sebagai wujud syukur. Goa Kreo menjadi objek wisata yang kaya akan nuansa mistis dan sejarah.',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DesSampoPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DesSampoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'DESTINASI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Klenteng Sam Poo Kong',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/Sampookong-removebg-preview.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DesSampoPage2(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DesSampoPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'DESTINASI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Klenteng Sam Poo Kong',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet nulla auctor, vestibulum magna sed, convallis ex.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DesLawangPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DesLawangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'DESTINASI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Lawang Sewu',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/lawang.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DesLawang2Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DesLawang2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'DESTINASI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Lawang Sewu',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Lawang Sewu adalah bangunan bersejarah di Semarang yang awalnya dibangun sebagai kantor Perusahaan Kereta Api NIS pada 1904. Dirancang oleh arsitek Cosman Citroen dengan gaya kolonial Belanda, bangunan ini memiliki banyak pintu dan jendela untuk ventilasi. Selesai dibangun pada 1918, Lawang Sewu digunakan sebagai kantor transportasi dan penjara saat pendudukan Jepang. Setelah itu, gedung ini beralih fungsi beberapa kali hingga kembali ke PT Kereta Api Indonesia pada 1994. Setelah restorasi pada 2009, Lawang Sewu diresmikan sebagai museum cagar budaya pada 2011 dan menjadi destinasi wisata yang menampilkan sejarah kereta api Indonesia serta ornamen khas yang mencerminkan keindahan budaya Jawa.',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DesGereja(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DesGereja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'DESTINASI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Gereja Belenduk',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/gereja.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DesGereja2(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DesGereja2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'DESTINASI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Gereja Blenduk',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'GPIB Immanuel atau yang lebih sering disebut sebagai Gereja Blenduk, memiliki kubah yang menggembung atau mblenduk dan inilah yang menjadi daya tariknya. Menurut catatan sejarah Gereja Belenduk dibangun pada awal 1753 oleh arsitek warga Belanda yang bermukim di Semarang saat itu,yaitu De Wilde Westmas. Hiasan interior di dalam gereja masih asli sejak pendeta pertama Johanes Wihelkmus Semkar mendirikan gereja ini pada 1753-1760.  organ piano antik karya p farwangler dan humer bangku bangku dari kayu jati dan tempat mimbar untuk khotbah. Gereja ini masih dipergunakan setiap hari minggu. kapasitasnya mampu menampung 400 jemaah dan selain untuk kebaktian juga difungsikan untuk acara pemberkatan pengantin  gereja belenduk juga membuka pintu untuk wisatawan untuk berkunjung dan menyasikan kemegahan arsitektur peninggalan kolonial ini.',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MakananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MAKANAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Lumpia',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/lumpiaa.png',
                    width: 660, // Increase the width
                    height: 230, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MknLumpia2Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MknLumpia2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MAKANAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Lumpia',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Lumpia Semarang, makanan khas yang muncul pada abad ke-19, merupakan hasil perpaduan budaya Tionghoa dan Jawa. Sejarahnya bermula ketika Tjoa Thay Joe, imigran dari Fujian, Tiongkok, bertemu dengan Mbak Wasih, seorang perempuan Jawa. Keduanya menjual makanan dengan isian berbeda, Tjoa Thay Joe menggunakan daging babi dan rebung, sedangkan Mbak Wasih menggunakan udang dan kentang. Mereka jatuh cinta, menikah, dan menggabungkan dagangan mereka menjadi lumpia dengan isian ayam atau udang, rebung, dan kulit lumpia renyah. Usaha mereka diteruskan oleh anak-anaknya, dan hingga kini Lumpia Semarang menjadi ikon kuliner yang populer, baik dalam versi basah maupun goreng. ',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MknBandengPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MknBandengPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MAKANAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Bandeng Presto',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/bndg.png',
                    width: 640, // Increase the width
                    height: 210, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MknBandeng2Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MknBandeng2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MAKANAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Bandeng Presto',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Bandeng Presto ditemukan pada tahun 1977 oleh Ibu Hanna Budimulya, seorang ibu rumah tangga yang terinspirasi memulai usaha setelah melihat ibu-ibu lain berjualan di sekolah anaknya. Panci presto, yang menjadi kunci kesuksesan produknya, pertama kali dikenalkan oleh suaminya. Sebelumnya, panci presto digunakan oleh suaminya untuk melunakkan daging, tetapi Ibu Hanna mencoba menggunakannya untuk melunakkan duri ikan bandeng. Panci presto inilah yang memberikan ciri khas unik pada produknya, sekaligus menjadi dasar nama “Bandeng Presto”. Awalnya, Ibu Hanna hanya membuat tiga kilogram bandeng, dan meski penjualan awalnya lambat, popularitasnya segera meningkat. Bersama suaminya yang mulai membantu membeli bandeng dari pasar, bisnis ini tumbuh pesat dan Bandeng Presto kini telah dipatenkan serta dijual hingga luar negeri, termasuk Hong Kong dan Amerika.',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MknTahuPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MknTahuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MAKANAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Tahu Gimbal ',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(-14, -4), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/tahu.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MknTahu2Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MknTahu2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MAKANAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Tahu Gimbal',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Tahu gimbal adalah kuliner khas Semarang yang telah ada sejak era penjajahan Belanda, diperkirakan muncul pada abad ke-19. Awalnya, tahu yang digunakan adalah tahu pong (tahu kopong), namun sekarang lebih sering menggunakan tahu yang lebih padat. Tahu dalam kuliner Nusantara dipengaruhi oleh budaya Tionghoa, dengan tahu pertama kali ditemukan di Tiongkok pada 164 SM oleh Liu An dan menyebar ke Indonesia melalui perantau Tionghoa. Tahu gimbal tetap menjadi ikon kuliner Semarang, dengan udang goreng tepung (gimbal) sebagai komponen khasnya. ',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MknWingkoPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MknWingkoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MAKANAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(
                          context), // Pass the context to the _buildBox function
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kotak tanpa aset
  Widget _buildBox(BuildContext context) {
    // Add the BuildContext parameter
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Wingko Babat',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Add some space between the text and the image
              // Use Transform.translate to move the image up
              Transform.translate(
                offset:
                    Offset(0, -30), // Adjust the y-value to move the image up
                child: Center(
                  child: Image.asset(
                    'android/assets/image/wingko.png',
                    width: 650, // Increase the width
                    height: 220, // Increase the height
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 120, // Adjust this value to move the button down
            child: IconButton(
              icon: Image.asset('android/assets/image/pixelarticons_next.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MknWingko2Page(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ));
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MknWingko2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPg(),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                ),
                SizedBox(
                    width: 1.0), // Add some space between the icon and the text
                Text(
                  'MAKANAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Baris pertama kotak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildBox(context), // Pass context if needed
                    ],
                  ),
                  SizedBox(height: 20),
                  // Baris kedua kotak
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example of a method that might need context
  Widget _buildBox(BuildContext context) {
    return Container(
      width: 560,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Wingko Babat',
                        style: TextStyle(
                          fontFamily: 'Lilita',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, left: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        'Wingko babat pertama kali dibuat oleh pasangan Loe Soe Siang dan Djoa Kiet Nio di Babat, Lamongan, pada 1898. Usaha ini dilanjutkan oleh anak mereka, yang memperkenalkan wingko ke Semarang pada 1946. Mulanya dijual tanpa merek, tetapi akhirnya dikenal sebagai "Cap Kereta Api." Pada 1958, D Mulyono mendaftarkan merek dagang untuk melindungi produk ini. Kini, wingko babat menjadi ikon oleh-oleh khas Semarang, meskipun asalnya dari Babat. Sentra penjualannya pun berkembang di wilayah Simpang Lima dan Jalan Pandanaran, menjadikannya camilan yang identik dengan kota Semarang.',
                        style: TextStyle(
                          fontFamily: 'Poppins ',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 120,
            child: IconButton(
              icon: Image.asset('android/assets/image/back.png',
                  width: 45, height: 45),
              onPressed: () {
                Navigator.pop(context); // Use context here
              },
            ),
          ),
        ],
      ),
    );
  }
}
