import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class WorkshopDetailPage extends StatelessWidget {
//   final String workshopId;

//   const WorkshopDetailPage({Key? key, required this.workshopId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Bengkel'),
//       ),
//       body: FutureBuilder(
//         future: FirebaseFirestore.instance
//             .collection('workshop_outlets')
//             .doc(workshopId)
//             .get(),
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text('Bengkel tidak ditemukan'));
//           }

//           var workshop = snapshot.data!.data() as Map<String, dynamic>;

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Nama Outlet: ${workshop['nama_outlet']}'),
//                 Text('Alamat: ${workshop['alamat']}'),
//                 SizedBox(height: 16),
//                 Text('Layanan:'),
//                 for (var service in workshop['layanan'] ?? [])
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('   - Jenis Layanan: ${service['layanan']}'),
//                       Text('   - Harga: ${service['harga']}'),
//                     ],
//                   ),
//                 SizedBox(height: 16),
//                 Text('Total Harga: ${workshop['total_harga']}'),
//                 Text('User ID: ${workshop['user_id']}'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class WorkshopDetailPage extends StatefulWidget {
//   final String workshopId;

//   const WorkshopDetailPage({Key? key, required this.workshopId})
//       : super(key: key);

//   @override
//   _WorkshopDetailPageState createState() => _WorkshopDetailPageState();
// }

// class _WorkshopDetailPageState extends State<WorkshopDetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Bengkel'),
//       ),
//       body: FutureBuilder(
//         future: FirebaseFirestore.instance
//             .collection('workshop_outlets')
//             .doc(widget.workshopId)
//             .get(),
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text('Bengkel tidak ditemukan'));
//           }

//           var workshop = snapshot.data!.data() as Map<String, dynamic>;

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Nama Outlet: ${workshop['nama_outlet']}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Alamat: ${workshop['alamat']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Layanan:',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: workshop['layanan']?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     var service = workshop['layanan'][index];
//                     return ListTile(
//                       title: Text('Jenis Layanan: ${service['layanan']}'),
//                       subtitle: Text('Harga: ${service['harga']}'),
//                       trailing: Checkbox(
//                         value: false, // Ganti dengan nilai sesuai kebutuhan
//                         onChanged: (value) {
//                           // Tambahkan logika sesuai kebutuhan
//                         },
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Total Harga: ${workshop['total_harga']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 Text(
//                   'User ID: ${workshop['user_id']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class WorkshopDetailPage extends StatefulWidget {
  final String workshopId;

  const WorkshopDetailPage({Key? key, required this.workshopId})
      : super(key: key);

  @override
  _WorkshopDetailPageState createState() => _WorkshopDetailPageState();
}

class _WorkshopDetailPageState extends State<WorkshopDetailPage> {
  Map<String, dynamic> workshop = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Bengkel'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('workshop_outlets')
            .doc(widget.workshopId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Bengkel tidak ditemukan'));
          }

          workshop = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Outlet: ${workshop['nama_outlet']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Alamat: ${workshop['alamat']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Layanan:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: workshop['layanan']?.length ?? 0,
                  itemBuilder: (context, index) {
                    var service = workshop['layanan'][index];
                    bool isChecked = service['isChecked'] ?? false;

                    return ListTile(
                      title: Text('Jenis Layanan: ${service['layanan']}'),
                      subtitle: Text('Harga: ${service['harga']}'),
                      trailing: Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            service['isChecked'] = value;
                          });

                          // Update total harga
                          updateTotalHarga();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Total Harga: ${workshop['total_harga']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'User ID: ${workshop['user_id']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => placeOrder(),
                  child: Text('Pesan Sekarang'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void updateTotalHarga() {
    int totalHarga = 0;
    for (var service in workshop['layanan'] ?? []) {
      if (service['isChecked']) {
        totalHarga += int.parse(service['harga']);
      }
    }

    setState(() {
      workshop['total_harga'] = totalHarga;
    });
  }

  void placeOrder() {
    // Logika untuk menyimpan data ke services_transactions
    // Gunakan workshopId dan data lain yang diperlukan
    FirebaseFirestore.instance.collection('services_transactions').add({
      'workshop_id': widget.workshopId,
      'user_id': workshop['user_id'],
      'total_harga': workshop['total_harga'],
      // tambahkan field lain sesuai kebutuhan
    });

    // Tampilkan snackbar berhasil melakukan pemesanan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Berhasil melakukan pemesanan')),
    );
  }
}
