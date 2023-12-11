import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otoranger/screens/jager/profile/index.dart';
import 'package:otoranger/screens/jager/workshop_outlet/detail.dart';

class JagerHomePage extends StatefulWidget {
  @override
  _JagerHomePageState createState() => _JagerHomePageState();
}

class _JagerHomePageState extends State<JagerHomePage> {
  final CollectionReference _workshopOutlets =
      FirebaseFirestore.instance.collection('workshop_outlets');

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jager Home Page'),
      ),
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => _createWorkshopOutlet(),
              child: const Icon(Icons.add),
            )
          : null, // Tampilkan FAB hanya di halaman Home
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return StreamBuilder(
          stream: _workshopOutlets.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  var workshop =
                      documentSnapshot.data() as Map<String, dynamic>;

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(workshop['nama_outlet'] ?? ''),
                      subtitle: Text(workshop['alamat'] ?? ''),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman detail bengkel
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkshopDetailPage(
                                workshopId: documentSnapshot.id,
                              ),
                            ),
                          );
                        },
                        child: Text('Lihat Bengkel'),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      case 1:
        // Menampilkan pesanan berdasarkan UUID pengguna yang sedang login
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('services_transactions')
              .where('user_id',
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  var transactionData =
                      documentSnapshot.data() as Map<String, dynamic>;

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                          'Bengkel ID: ${transactionData['workshop_id'] ?? ''}'),
                      subtitle: Text(
                          'Total Harga: ${transactionData['total_harga'] ?? ''}'),
                      // Tambahkan logika lain sesuai kebutuhan
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

      case 2:
        // Tambahkan logika untuk halaman "Berita"
        return Center(
          child: Text('Berita Page'),
        );
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JagerProfileTab()),
        );
        break;
      default:
        return Container(); // Default, jika tidak ada halaman yang sesuai
    }
    return Container();
  }

  Future<void> _createWorkshopOutlet() async {
    // Logika pembuatan workshop outlet
  }
}

void main() {
  runApp(MaterialApp(
    home: JagerHomePage(),
  ));
}
