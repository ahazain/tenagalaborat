import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RiwayatPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pasien'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('patients').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada riwayat pasien.'));
          }
          final patients = snapshot.data!.docs;
          return ListView(
            children: patients.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text('NIK: ${data['nik']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RiwayatDetailPage(patientId: doc.id),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class RiwayatDetailPage extends StatelessWidget {
  final String patientId;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RiwayatDetailPage({required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pasien'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: firestore.collection('patients').doc(patientId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Data tidak ditemukan.'));
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama: ${data['name']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('NIK: ${data['nik']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Tanggal Lahir: ${data['dob']}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Alamat: ${data['address']}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Jenis Kelamin: ${data['gender']}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Status Pembayaran: ${data['paymentStatus']}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                Text('Hasil Layanan:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection('hematologi')
                        .where('patientId', isEqualTo: patientId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('Belum ada hasil layanan.'));
                      }
                      final hematologiResults = snapshot.data!.docs;
                      return ListView(
                        children: hematologiResults.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return ListTile(
                            title: Text('Eritrosit: ${data['eritrosit']} juta'),
                            subtitle: Text('Leukosit: ${data['leukosit']} Ul'),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
