import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImmunaSerologi extends StatefulWidget {
  final String patientId;

  const ImmunaSerologi({super.key, required this.patientId});

  @override
  State<ImmunaSerologi> createState() => _ImmunaSerologiState();
}

class _ImmunaSerologiState extends State<ImmunaSerologi> {
  final TextEditingController _antiHbsController = TextEditingController();
  final TextEditingController _antiHcvController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _antiHbsController.dispose();
    _antiHcvController.dispose();
    super.dispose();
  }

  void _saveData() {
    String antiHbs = _antiHbsController.text;
    String antiHcv = _antiHcvController.text;

    firestore.collection('immuna_serologi').add({
      'patientId': widget.patientId,
      'antiHbs': antiHbs,
      'antiHcv': antiHcv,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data Tersimpan'),
          content: Text('Data immuna serologi berhasil disimpan.'),
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
        title: Text('Immuna Serologi'),
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
                    controller: _antiHbsController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nilai anti-HBs',
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
                        'Anti-HBs (satuan: -):',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Keterangan nilai rujukan:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '> 10 IU/L (positif)',
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
                    controller: _antiHcvController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nilai anti-HCV',
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
                        'Anti-HCV (satuan: -):',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Keterangan nilai rujukan:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Non-reaktif (negatif)',
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
