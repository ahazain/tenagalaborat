// import 'package:flutter/material.dart';

// class LayananPage extends StatefulWidget {
//   @override
//   _LayananPageState createState() => _LayananPageState();
// }

// class _LayananPageState extends State<LayananPage> {
//   void _saveAndNavigateToHistory() {
//     // Simulate saving and navigation
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Data layanan disimpan')),
//     );
//     Future.delayed(Duration(seconds: 1), () {
//       Navigator.popUntil(context, ModalRoute.withName('/riwayat'));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Layanan'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _saveAndNavigateToHistory,
//           child: Text('Simpan dan Kembali ke Riwayat'),
//         ),
//       ),
//     );
//   }
// }
