import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KimiaKlinik extends StatefulWidget {
  final String patientId;

  const KimiaKlinik({super.key, required this.patientId});

  @override
  State<KimiaKlinik> createState() => _KimiaKlinikState();
}

class _KimiaKlinikState extends State<KimiaKlinik> {
  final TextEditingController _ureaController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _ureaController.dispose();
    super.dispose();
  }

  void _saveData() {
    String urea = _ureaController.text;

    firestore.collection('kimia_klinik').add({
      'patientId': widget.patientId,
      'urea': urea,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data Tersimpan'),
          content: Text('Data kimia klinik berhasil disimpan.'),
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
        title: Text('Kimia Klinik'),
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
                    controller: _ureaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nilai urea',
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
                        'Urea (satuan: mg/dL):',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Keterangan nilai rujukan:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '15 - 45 mg/dL',
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
