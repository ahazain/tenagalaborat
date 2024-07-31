// import 'package:flutter/material.dart';

// class TambahPasienPage extends StatelessWidget {
//   final TextEditingController nameController;
//   final TextEditingController nikController;
//   final TextEditingController dobController;
//   final TextEditingController addressController;
//   final TextEditingController genderController;
//   final TextEditingController paymentStatusController;
//   final VoidCallback onSave;

//   const TambahPasienPage({
//     Key? key,
//     required this.nameController,
//     required this.nikController,
//     required this.dobController,
//     required this.addressController,
//     required this.genderController,
//     required this.paymentStatusController,
//     required this.onSave,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(
//             controller: nameController,
//             decoration: InputDecoration(
//               labelText: 'Nama Lengkap',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 16),
//           TextField(
//             controller: nikController,
//             decoration: InputDecoration(
//               labelText: 'NIK',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 16),
//           TextField(
//             controller: dobController,
//             decoration: InputDecoration(
//               labelText: 'Tanggal Lahir',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 16),
//           TextField(
//             controller: addressController,
//             decoration: InputDecoration(
//               labelText: 'Alamat',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 16),
//           TextField(
//             controller: genderController,
//             decoration: InputDecoration(
//               labelText: 'Jenis Kelamin',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 16),
//           TextField(
//             controller: paymentStatusController,
//             decoration: InputDecoration(
//               labelText: 'Status Pembayaran',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: onSave,
//             child: Text('Simpan'),
//           ),
//         ],
//       ),
//     );
//   }
// }
