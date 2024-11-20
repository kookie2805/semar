import 'package:flutter_test/flutter_test.dart';
import 'package:smart/main.dart'; // Ganti dengan path ke file main.dart kamu jika berbeda

void main() {
  testWidgets('Tombol Mulai, More, dan Settings muncul di tengah', (WidgetTester tester) async {
    // Build aplikasi
    await tester.pumpWidget(MyApp());

    // Verifikasi bahwa tombol-tombol muncul
    expect(find.text('Mulai'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Verifikasi bahwa tombol-tombol berada di tengah layar
    final Finder mulaiButton = find.text('Mulai');
    final Finder moreButton = find.text('More');
    final Finder settingsButton = find.text('Settings');

    // Mengambil posisi dari tombol-tombol untuk verifikasi lebih lanjut
    final mulaiButtonPosition = tester.getCenter(mulaiButton);
    final moreButtonPosition = tester.getCenter(moreButton);
    final settingsButtonPosition = tester.getCenter(settingsButton);

    // Verifikasi bahwa tombol-tombol berada di posisi yang sesuai
    expect(mulaiButtonPosition.dy, lessThan(moreButtonPosition.dy + 10));
    expect(moreButtonPosition.dy, lessThan(settingsButtonPosition.dy + 10));
  });
}
