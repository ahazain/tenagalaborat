// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class TambahPasienForm extends StatefulWidget {
//   final String? editingId;

//   TambahPasienForm({this.editingId});

//   @override
//   _TambahPasienFormState createState() => _TambahPasienFormState();
// }

// class _TambahPasienFormState extends State<TambahPasienForm> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController nikController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   String gender = 'Laki-laki';
//   String paymentStatus = 'BPJS';

//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final CollectionReference patients =
//       FirebaseFirestore.instance.collection('patients');

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.editingId != null) {
//       _loadData(widget.editingId!);
//     }
//   }

//   void _loadData(String id) async {
//     DocumentSnapshot doc = await patients.doc(id).get();
//     final data = doc.data() as Map<String, dynamic>;
//     nameController.text = data['name'];
//     nikController.text = data['nik'];
//     dobController.text = data['dob'];
//     gender = data['gender'];
//     addressController.text = data['address'];
//     paymentStatus = data['paymentStatus'];
//     setState(() {});
//   }

//   void _saveData() {
//     if (_formKey.currentState!.validate()) {
//       final patientData = {
//         'name': nameController.text,
//         'nik': nikController.text,
//         'dob': dobController.text,
//         'gender': gender,
//         'address': addressController.text,
//         'paymentStatus': paymentStatus,
//       };

//       if (widget.editingId == null) {
//         patients.add(patientData).then((value) {
//           Navigator.pop(context);
//         }).catchError((error) {
//           print('Error adding patient: $error');
//         });
//       } else {
//         patients.doc(widget.editingId).update(patientData).then((value) {
//           Navigator.pop(context);
//         }).catchError((error) {
//           print('Error updating patient: $error');
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.editingId == null ? 'Tambah Pasien' : 'Edit Pasien'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(15),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(hintText: "Nama"),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Nama tidak boleh kosong';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: nikController,
//                 decoration: InputDecoration(hintText: "NIK"),
//                 keyboardType: TextInputType.number,
//                 maxLength: 16,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'NIK tidak boleh kosong';
//                   } else if (value.length != 16) {
//                     return 'NIK harus 16 digit';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: dobController,
//                 decoration: InputDecoration(hintText: "Tanggal Lahir"),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Tanggal lahir tidak boleh kosong';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               DropdownButtonFormField(
//                 value: gender,
//                 items: ['Laki-laki', 'Perempuan']
//                     .map((label) => DropdownMenuItem(
//                           child: Text(label),
//                           value: label,
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     gender = value!;
//                   });
//                 },
//                 decoration: InputDecoration(hintText: "Jenis Kelamin"),
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: addressController,
//                 decoration: InputDecoration(hintText: "Alamat"),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Alamat tidak boleh kosong';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               DropdownButtonFormField(
//                 value: paymentStatus,
//                 items: ['BPJS', 'Umum']
//                     .map((label) => DropdownMenuItem(
//                           child: Text(label),
//                           value: label,
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     paymentStatus = value!;
//                   });
//                 },
//                 decoration: InputDecoration(hintText: "Status Pembayaran"),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveData,
//                 child: Text('Simpan'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahPasienForm extends StatefulWidget {
  final String? editingId;

  TambahPasienForm({this.editingId});

  @override
  _TambahPasienFormState createState() => _TambahPasienFormState();
}

class _TambahPasienFormState extends State<TambahPasienForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String gender = 'Laki-laki';
  String paymentStatus = 'BPJS';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.editingId != null) {
      _loadData(widget.editingId!);
    }
  }

  void _loadData(String id) async {
    DocumentSnapshot doc = await patients.doc(id).get();
    final data = doc.data() as Map<String, dynamic>;
    nameController.text = data['name'];
    nikController.text = data['nik'];
    dobController.text = data['dob'];
    gender = data['gender'];
    addressController.text = data['address'];
    paymentStatus = data['paymentStatus'];
    setState(() {});
  }

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      final patientData = {
        'name': nameController.text,
        'nik': nikController.text,
        'dob': dobController.text,
        'gender': gender,
        'address': addressController.text,
        'paymentStatus': paymentStatus,
      };

      if (widget.editingId == null) {
        patients.add(patientData).then((value) {
          Navigator.pop(context);
        }).catchError((error) {
          print('Error adding patient: $error');
        });
      } else {
        patients.doc(widget.editingId).update(patientData).then((value) {
          Navigator.pop(context);
        }).catchError((error) {
          print('Error updating patient: $error');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editingId == null ? 'Tambah Pasien' : 'Edit Pasien'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Nama"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nikController,
                decoration: InputDecoration(hintText: "NIK"),
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK tidak boleh kosong';
                  } else if (value.length != 16) {
                    return 'NIK harus 16 digit';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(hintText: "Tanggal Lahir"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal lahir tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                value: gender,
                items: ['Laki-laki', 'Perempuan']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
                decoration: InputDecoration(hintText: "Jenis Kelamin"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(hintText: "Alamat"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                value: paymentStatus,
                items: ['BPJS', 'Umum']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    paymentStatus = value!;
                  });
                },
                decoration: InputDecoration(hintText: "Status Pembayaran"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
