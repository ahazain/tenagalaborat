import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenagalaborat/mainscreeen.dart'; // Import MainScreen

class UrineLengkap extends StatefulWidget {
  final String patientId;

  const UrineLengkap({super.key, required this.patientId});

  @override
  State<UrineLengkap> createState() => _UrineLengkapState();
}

class _UrineLengkapState extends State<UrineLengkap> {
  final TextEditingController _phController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _phController.dispose();
    _proteinController.dispose();
    super.dispose();
  }

  void _saveData() {
    String ph = _phController.text;
    String protein = _proteinController.text;

    firestore.collection('urine_lengkap').add({
      'patientId': widget.patientId,
      'ph': ph,
      'protein': protein,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data Tersimpan'),
          content: Text('Data urine lengkap berhasil disimpan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                ); // Navigate to MainScreen
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
        title: Text('Urine Lengkap'),
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
                    controller: _phController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nilai pH',
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
                        'pH (satuan: -):',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Keterangan nilai rujukan:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '4.5 - 8.0',
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
                    controller: _proteinController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nilai protein',
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
                        'Protein (satuan: mg/dL):',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Keterangan nilai rujukan:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '< 15 mg/dL',
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
