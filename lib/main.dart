// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tenagalaborat/Hematologi.dart';
// import 'package:tenagalaborat/firebase_options.dart';
// import 'package:tenagalaborat/home.dart'; // Add this line
// import 'dart:ui';

// import 'package:tenagalaborat/riwayat.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Add this line
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/':
//             return MaterialPageRoute(
//                 builder: (context) =>
//                     Hematologi(patientId: 'examplePatientId'));
//           case '/riwayat':
//             return MaterialPageRoute(builder: (context) => Riwayat());
//           default:
//             return MaterialPageRoute(
//               builder: (context) => Scaffold(
//                 appBar: AppBar(
//                   title: Text('Page Not Found'),
//                 ),
//                 body: Center(
//                   child: Text('404 - Page Not Found'),
//                 ),
//               ),
//             );
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tenagalaborat/home.dart';
import 'package:tenagalaborat/riwayat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(), // Halaman utama
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TambahPasien(), // Halaman TambahPasien
    Riwayat(), // Halaman Riwayat
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }
}
