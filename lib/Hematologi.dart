import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenagalaborat/mainscreeen.dart';
import 'package:tenagalaborat/riwayat.dart'; // Import Riwayat

class Hematologi extends StatefulWidget {
  final String patientId;

  const Hematologi({super.key, required this.patientId});

  @override
  State<Hematologi> createState() => _HematologiState();
}

class _HematologiState extends State<Hematologi> {
  final TextEditingController _eritrositController = TextEditingController();
  final TextEditingController _leukositController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _eritrositController.dispose();
    _leukositController.dispose();
    super.dispose();
  }

  void _saveData() {
    String eritrosit = _eritrositController.text;
    String leukosit = _leukositController.text;

    firestore.collection('hematologi').add({
      'patientId': widget.patientId,
      'eritrosit': eritrosit,
      'leukosit': leukosit,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data Tersimpan'),
          content: Text('Data hematologi berhasil disimpan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                ); // Navigate to Riwayat page
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hematologi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _eritrositController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nilai eritrosit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Eritrosit (satuan: juta):',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Keterangan nilai rujukan:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'P: 4,5 - 6,5 ; W: 4,5 - 5,5',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _leukositController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nilai leukosit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leukosit (satuan: Ul):',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Keterangan nilai rujukan:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '4000 - 11000',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
