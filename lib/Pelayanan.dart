// import 'package:flutter/material.dart';
// import 'package:tenagalaborat/Hematologi.dart';
// import 'package:tenagalaborat/ImmunaSerologi.dart';
// import 'package:tenagalaborat/KimiaKlinik.dart';
// import 'package:tenagalaborat/UrineLengkap.dart';

// class Pelayanan extends StatefulWidget {
//   final List<String> patientIds;

//   const Pelayanan({Key? key, required this.patientIds}) : super(key: key);

//   @override
//   State<Pelayanan> createState() => _PelayananState();
// }

// class _PelayananState extends State<Pelayanan> {
//   String? _selectedService;

//   void navigateToTambahPasien() {
//     Navigator.pop(context);
//   }

//   void navigateToDetailPelayanan() {
//     if (_selectedService != null && widget.patientIds.isNotEmpty) {
//       switch (_selectedService) {
//         case 'Hematologi':
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Hematologi(patientIds: widget.patientIds),
//             ),
//           );
//           break;
//         case 'Kimia Klinik':
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => KimiaKlinik(patientIds: widget.patientIds),
//             ),
//           );
//           break;
//         case 'Urine Lengkap':
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => UrineLengkap(patientIds: widget.patientIds),
//             ),
//           );
//           break;
//         case 'Immuna Serologi':
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Immuna(patientIds: widget.patientIds),
//             ),
//           );
//           break;
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Tidak ada Pasien yang Dipilih'),
//             content: Text('Silakan pilih minimal satu pasien untuk dilayani.'),
//             actions: <Widget>[
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
import 'package:tenagalaborat/Hematologi.dart';
import 'package:tenagalaborat/ImmunaSerologi.dart';
import 'package:tenagalaborat/KimiaKlinik.dart';
import 'package:tenagalaborat/UrineLengkap.dart';

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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void navigateToTambahPasien() {
    Navigator.pop(context);
  }

  void navigateToDetailPelayanan() {
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

    for (String patientId in widget.patientIds) {
      switch (_selectedService) {
        case 'Hematologi':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Hematologi(patientId: patientId),
            ),
          );
          break;
        case 'Kimia Klinik':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KimiaKlinik(patientId: patientId),
            ),
          );
          break;
        case 'Urine Lengkap':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UrineLengkap(patientId: patientId),
            ),
          );
          break;
        case 'Immuna Serologi':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImmunaSerologi(patientId: patientId),
            ),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pelayanan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: navigateToTambahPasien,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile<String>(
              title: const Text('Hematologi'),
              value: 'Hematologi',
              groupValue: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Kimia Klinik'),
              value: 'Kimia Klinik',
              groupValue: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Urine Lengkap'),
              value: 'Urine Lengkap',
              groupValue: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Immuna Serologi'),
              value: 'Immuna Serologi',
              groupValue: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: navigateToTambahPasien,
                  child: const Text('Kembali'),
                ),
                ElevatedButton(
                  onPressed: navigateToDetailPelayanan,
                  child: const Text('Lanjut'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
