// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tenagalaborat/Hematologi.dart';
// import 'package:tenagalaborat/ImmunaSerologi.dart';
// import 'package:tenagalaborat/KimiaKlinik.dart';
// import 'package:tenagalaborat/UrineLengkap.dart';

// class Pelayanan extends StatefulWidget {
//   final List<String> patientIds;
//   final String patientId;

//   const Pelayanan({Key? key, required this.patientIds, required this.patientId})
//       : super(key: key);

//   @override
//   State<Pelayanan> createState() => _PelayananState();
// }

// class _PelayananState extends State<Pelayanan> {
//   String? _selectedService;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   void navigateToTambahPasien() {
//     Navigator.pop(context);
//   }

//   void navigateToDetailPelayanan() {
//     if (_selectedService == null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Layanan tidak dipilih'),
//             content: Text('Silakan pilih salah satu layanan.'),
//             actions: [
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }

//     for (String patientId in widget.patientIds) {
//       switch (_selectedService) {
//         case 'Hematologi':
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Hematologi(patientId: patientId),
//             ),
//           );
//           break;
//         case 'Kimia Klinik':
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => KimiaKlinik(patientId: patientId),
//             ),
//           );
//           break;
//         case 'Urine Lengkap':
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => UrineLengkap(patientId: patientId),
//             ),
//           );
//           break;
//         case 'Immuna Serologi':
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ImmunaSerologi(patientId: patientId),
//             ),
//           );
//           break;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pelayanan'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: navigateToTambahPasien,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             RadioListTile<String>(
//               title: const Text('Hematologi'),
//               value: 'Hematologi',
//               groupValue: _selectedService,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedService = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Kimia Klinik'),
//               value: 'Kimia Klinik',
//               groupValue: _selectedService,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedService = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Urine Lengkap'),
//               value: 'Urine Lengkap',
//               groupValue: _selectedService,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedService = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Immuna Serologi'),
//               value: 'Immuna Serologi',
//               groupValue: _selectedService,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedService = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: navigateToTambahPasien,
//                   child: const Text('Kembali'),
//                 ),
//                 ElevatedButton(
//                   onPressed: navigateToDetailPelayanan,
//                   child: const Text('Lanjut'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenagalaborat/ImmunaSerologi.dart';
import 'package:tenagalaborat/KimiaKlinik.dart';
import 'package:tenagalaborat/UrineLengkap.dart';
import 'hematologi.dart'; // Ensure this is correctly imported

class Pelayanan extends StatefulWidget {
  final List<String> patientIds;
  final String patientId;

  const Pelayanan({Key? key, required this.patientIds, required this.patientId})
      : super(key: key);

  @override
  State<Pelayanan> createState() => _PelayananState();
}

class _PelayananState extends State<Pelayanan> {
  String? _selectedService;

  void _navigateToDetailPelayanan() {
    if (_selectedService == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Layanan tidak dipilih'),
            content: Text('Silakan pilih salah satu layanan.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    // Menavigasi ke halaman detail layanan berdasarkan layanan yang dipilih
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (_selectedService) {
            case 'Hematologi':
              return Hematologi(patientId: widget.patientId);
            case 'Kimia Klinik':
              return KimiaKlinik(patientId: widget.patientId);
            case 'Urine Lengkap':
              return UrineLengkap(patientId: widget.patientId);
            case 'Immuna Serologi':
              return ImmunaSerologi(patientId: widget.patientId);
            default:
              return Container(); // atau mungkin bisa menampilkan halaman error
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Layanan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile<String>(
              title: Text('Hematologi'),
              value: 'Hematologi',
              groupValue: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Kimia Klinik'),
              value: 'Kimia Klinik',
              groupValue: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Urine Lengkap'),
              value: 'Urine Lengkap',
              groupValue: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Immuna Serologi'),
              value: 'Immuna Serologi',
              groupValue: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Kembali'),
                ),
                ElevatedButton(
                  onPressed: _navigateToDetailPelayanan,
                  child: Text('Lanjut'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
