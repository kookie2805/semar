class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B1C34), Color(0xFF155973)],
          ),
        ),
        child: Stack(children: [
          // Gambar Gedung
          Positioned.fill(
            child: Image.asset(
              'assets/images/PENGATURAN.1 (2).png', // Ganti dengan path gambar gedung Anda
              fit: BoxFit.cover,
            ),
          ),

          // Tombol Kembali
          Positioned(
            top: 80, // Ubah nilai top dari 70 menjadi 40
            left: 20,
            child: TombolKembali(),
          ),

          // Pengaturan
          Positioned(
            top: 80, // Atur posisi dari atas
            left: 100,
            child: TextPengaturan(),
          ),

          // Tombol Suara dan Musik
          Positioned(
            top: 150, // Atur posisi dari atas
            left: 20,
            child: TombolSuaraDanMusik(),
          ),
        ]),
      ),
    );
  }
}

//class TombolKembali
class TombolKembali extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.arrowLeft),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

//class TextPengaturan
class TextPengaturan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "PENGATURAN",
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lilita',
          color: Colors.white),
    );
  }
}

//class TombolSuaraDanMusik
class TombolSuaraDanMusik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //tombol kembali
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {
            // Aksi saat tombol Suara ditekan
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text(
            'SUARA',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lilita',
                color: Colors.black),
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            // Aksi saat tombol Musik ditekan
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text(
            'MUSIK',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lilita',
                color: Colors.black),
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text(
            'LOGIN',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lilita',
                color: Colors.black),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
