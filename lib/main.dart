import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:audioplayers/audioplayers.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEMAR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SEMAR - Seputar Semarang'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/HOME (1).png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Mengatur posisi ke kanan
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          right: 40.0), // Menambahkan padding di sisi kanan
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Mengatur posisi di tengah secara vertikal
                          crossAxisAlignment: CrossAxisAlignment
                              .end, // Mengatur posisi ke kanan
                          children: <Widget>[
                            const Text(
                              'SEMAR',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily:
                                    'Lilita', // Warna teks menyesuaikan background
                              ),
                            ),
                            const Text(
                              'Seputar Semarang',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors
                                    .white, // Warna teks menyesuaikan background
                              ),
                            ),
                            const SizedBox(
                                height: 20), // Spasi antara subtitle dan tombol
                            CustomButton(
                              text: 'Mainkan',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const GamePage()),
                                );
                              },
                            ),
                            CustomButton(
                              text: 'Pengaturan',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage()),
                                );
                              },
                            ),
                            CustomButton(
                              text: 'About Us',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AboutUsPage()),
                                );
                              },
                            )
                          ]))
                ])));
  }
}

//class custom button
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Menggunakan onPressed di sini
      child: Container(
        width: 275,
        height: 70, // Membuat tombol menjadi selebar mungkin
        padding:
            const EdgeInsets.symmetric(vertical: 20.0), // Menambah tinggi kotak
        margin:
            const EdgeInsets.symmetric(vertical: 8.0), // Margin antar tombol
        decoration: newMethod(),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lilita'),
          ),
        ),
      ),
    );
  }
  
  newMethod() {
    return BoxDecoration(
        color: Colors.white, //warna background
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(color: Colors.white, offset: Offset(2, 2))
        ]);
  }
}

//class GamePage
class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mainkan Game'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text(
          'Error',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); //kembali ke halama sebelumnya
        },
        child: const Icon(Icons.home),
        //ikon rmh
      ),
    );
  }
}

//class Pengaturan
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


//class LoginPage
/*class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/PENGATURAN.1 (2).png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.3),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Fungsi login
                      print('Email: $_email, Password: $_password');
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/

//class AboutUsPage
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Center(
        child: Text(
          'Error',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); //kembali ke halaman semula
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
