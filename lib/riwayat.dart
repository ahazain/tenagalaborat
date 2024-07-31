import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> _selectedIds = [];
  bool _isSelecting = false;
  bool _isDeleting = false;

  get name => null;

  void _toggleSelectionMode() {
    setState(() {
      _isSelecting = !_isSelecting;
      if (!_isSelecting) {
        _selectedIds.clear();
      }
    });
  }

  Future<void> _deleteSelected(List<String> ids) async {
    setState(() {
      _isDeleting = true;
    });

    try {
      for (String id in ids) {
        await firestore.collection('hematologi').doc(id).delete();
        await firestore.collection('kimia_klinik').doc(id).delete();
        await firestore.collection('immuna_serologi').doc(id).delete();
        await firestore.collection('urine_lengkap').doc(id).delete();
      }
      setState(() {
        _isDeleting = false;
        _selectedIds.clear();
        _isSelecting = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data berhasil dihapus')));
    } catch (error) {
      setState(() {
        _isDeleting = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $error')));
    }
  }

  Future<Map<String, dynamic>> _getPatientData(String patientId) async {
    final doc = await firestore.collection('patients').doc(patientId).get();
    if (doc.exists) {
      return doc.data()!;
    } else {
      return {'nama': 'Tidak tersedia', 'nik': 'Tidak tersedia'};
    }
  }

  Widget _buildServiceSection(String title, List<QueryDocumentSnapshot> docs) {
    if (docs.isEmpty) {
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Divider(),
        ...docs.map((doc) {
          final id = doc.id;
          final data = doc.data() as Map<String, dynamic>;
          final patientId = data['patientId'] as String?;
          final timestamp = data['timestamp'] as Timestamp?;

          String dateText = timestamp != null
              ? 'Tanggal: ${timestamp.toDate().toLocal()}'
              : 'Tanggal: Tidak tersedia';
          String detailText = '';

          if (data.containsKey('eritrosit')) {
            detailText =
                'Eritrosit: ${data['eritrosit']} juta\nLeukosit: ${data['leukosit']} Ul';
          } else if (data.containsKey('urea')) {
            detailText = 'Urea: ${data['urea']} mg/dL';
          } else if (data.containsKey('antiHbs')) {
            detailText =
                'Anti-HBs: ${data['antiHbs']}\nAnti-HCV: ${data['antiHcv']}';
          } else if (data.containsKey('ph')) {
            detailText = 'pH: ${data['ph']}\nProtein: ${data['protein']}';
          }

          return FutureBuilder<Map<String, dynamic>>(
            future: _getPatientData(patientId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListTile(
                  leading: CircularProgressIndicator(),
                  title: Text('Loading...'),
                );
              }
              final patientData = snapshot.data!;
              final name = patientData['name'];
              final nik = patientData['nik'];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: _isSelecting
                      ? Checkbox(
                          value: _selectedIds.contains(id),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                _selectedIds.add(id);
                              } else {
                                _selectedIds.remove(id);
                              }
                            });
                          },
                        )
                      : null,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama: $name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'NIK: $nik',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(dateText),
                      SizedBox(height: 8),
                      Text(detailText),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat'),
        actions: [
          IconButton(
            icon: _isDeleting
                ? CircularProgressIndicator()
                : Icon(_isSelecting ? Icons.delete : Icons.delete_outline),
            onPressed: _isDeleting
                ? null
                : () {
                    if (_isSelecting) {
                      if (_selectedIds.isNotEmpty) {
                        _deleteSelected(_selectedIds);
                      }
                    } else {
                      _toggleSelectionMode();
                    }
                  },
          ),
        ],
      ),
      body: FutureBuilder<List<QuerySnapshot>>(
        future: Future.wait([
          firestore.collection('hematologi').get(),
          firestore.collection('kimia_klinik').get(),
          firestore.collection('immuna_serologi').get(),
          firestore.collection('urine_lengkap').get(),
        ]),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshots.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshots.error}'));
          }

          final hematologiDocs = snapshots.data![0].docs;
          final kimiaKlinikDocs = snapshots.data![1].docs;
          final immunaSerologiDocs = snapshots.data![2].docs;
          final urineLengkapDocs = snapshots.data![3].docs;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildServiceSection('Hematologi', hematologiDocs),
              _buildServiceSection('Kimia Klinik', kimiaKlinikDocs),
              _buildServiceSection('Immuna Serologi', immunaSerologiDocs),
              _buildServiceSection('Urine Lengkap', urineLengkapDocs),
            ],
          );
        },
      ),
    );
  }
}
