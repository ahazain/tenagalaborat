import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final CollectionReference patients;
  final String? editingId;

  const PatientForm(
      {required this.formKey, required this.patients, this.editingId});

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String gender = 'Laki-laki';
  String paymentStatus = 'BPJS';

  void _saveData() {
    if (widget.formKey.currentState!.validate()) {
      if (widget.editingId == null) {
        // Add new data
        widget.patients.add({
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
        if (widget.editingId != null && widget.editingId!.isNotEmpty) {
          widget.patients.doc(widget.editingId).update({
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
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
    );
  }
}
