import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenagalaborat/Pelayanan.dart';

class TambahPasien extends StatefulWidget {
  @override
  _TambahPasienState createState() => _TambahPasienState();
}

class _TambahPasienState extends State<TambahPasien> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String gender = 'Laki-laki';
  String paymentStatus = 'BPJS';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');

  String? editingId;
  final _formKey = GlobalKey<FormState>();
  Set<String> selectedPatientIds = {};

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      if (editingId == null) {
        // Add new data
        patients.add({
          'name': nameController.text,
          'nik': nikController.text,
          'dob': dobController.text,
          'gender': gender,
          'address': addressController.text,
          'paymentStatus': paymentStatus,
        }).then((value) {
          // Handle success
          nameController.text = '';
          nikController.text = '';
          dobController.text = '';
          addressController.text = '';
        }).catchError((error) {
          // Handle error
          print('Error adding patient: $error');
        });
      } else {
        // Update existing data
        if (editingId != null && editingId!.isNotEmpty) {
          patients.doc(editingId).update({
            'name': nameController.text,
            'nik': nikController.text,
            'dob': dobController.text,
            'gender': gender,
            'address': addressController.text,
            'paymentStatus': paymentStatus,
          }).then((value) {
            // Handle success
            nameController.text = '';
            nikController.text = '';
            dobController.text = '';
            addressController.text = '';
          }).catchError((error) {
            // Handle error
            print('Error updating patient: $error');
          });
        } else {
          print('Error: editingId is null or empty');
        }
      }
    }
  }

  void _editData(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    nameController.text = data['name'];
    nikController.text = data['nik'];
    dobController.text = data['dob'];
    gender = data['gender'];
    addressController.text = data['address'];
    paymentStatus = data['paymentStatus'];
    editingId = doc.id;
    setState(() {});
  }

  void _deleteData(String id) {
    patients.doc(id).delete();
  }

  void _navigateToPelayananPage() {
    if (selectedPatientIds.isEmpty) {
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
            patientIds: selectedPatientIds.toList(),
            patientId: '',
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
      ),
      body: Column(
        children: [
          Padding(
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
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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
                            Checkbox(
                              value: selectedPatientIds.contains(doc.id),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    selectedPatientIds.add(doc.id);
                                  } else {
                                    selectedPatientIds.remove(doc.id);
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editData(doc),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteData(doc.id),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToPelayananPage,
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
