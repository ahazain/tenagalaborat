// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tenagalaborat/Pelayanan.dart';
// import 'package:tenagalaborat/tambahPasienPage.dart';

// class TambahPasien extends StatefulWidget {
//   @override
//   _TambahPasienState createState() => _TambahPasienState();
// }

// class _TambahPasienState extends State<TambahPasien> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final CollectionReference patients =
//       FirebaseFirestore.instance.collection('patients');

//   String? selectedPatientId;

//   void _navigateToFormPage({String? editingId}) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => TambahPasienForm(editingId: editingId),
//       ),
//     ).then((_) {
//       setState(() {}); // Refresh the list after returning from the form page
//     });
//   }

//   void _navigateToPelayananPage() {
//     if (selectedPatientId == null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Tidak ada pasien yang dipilih'),
//             content: Text('Silakan pilih pasien terlebih dahulu.'),
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
//     } else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Pelayanan(
//             patientIds: [selectedPatientId!],
//             patientId: '',
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tambah Pasien'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () => _navigateToFormPage(),
//           ),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: patients.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView(
//               children: snapshot.data!.docs.map((doc) {
//                 final data = doc.data() as Map<String, dynamic>;
//                 return ListTile(
//                   title: Text(data['name']),
//                   subtitle: Text(data['nik']),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Radio<String>(
//                         value: doc.id,
//                         groupValue: selectedPatientId,
//                         onChanged: (String? value) {
//                           setState(() {
//                             selectedPatientId = value;
//                           });
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () => _navigateToFormPage(editingId: doc.id),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () {
//                           patients.doc(doc.id).delete();
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _navigateToPelayananPage,
//         child: Icon(Icons.navigate_next),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenagalaborat/Pelayanan.dart'; // Pastikan ini benar
import 'package:tenagalaborat/tambahPasienPage.dart'; // Pastikan ini benar

class TambahPasien extends StatefulWidget {
  @override
  _TambahPasienState createState() => _TambahPasienState();
}

class _TambahPasienState extends State<TambahPasien> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');

  String? selectedPatientId;

  void _navigateToFormPage({String? editingId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahPasienForm(editingId: editingId),
      ),
    ).then((_) {
      setState(() {}); // Refresh the list after returning from the form page
    });
  }

  void _navigateToPelayananPage() {
    if (selectedPatientId == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tidak ada pasien yang dipilih'),
            content: Text('Silakan pilih pasien terlebih dahulu.'),
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
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Pelayanan(
            patientId: selectedPatientId!,
            patientIds: [],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pasien'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToFormPage(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: patients.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['nik']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<String>(
                        value: doc.id,
                        groupValue: selectedPatientId,
                        onChanged: (String? value) {
                          setState(() {
                            selectedPatientId = value;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _navigateToFormPage(editingId: doc.id),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          patients.doc(doc.id).delete();
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToPelayananPage,
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
