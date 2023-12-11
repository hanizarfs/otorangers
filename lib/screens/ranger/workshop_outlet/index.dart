// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:otoranger/screens/ranger/workshop_outlet/edit.dart';

// class WorkshopOutletListPage extends StatefulWidget {
//   @override
//   _WorkshopOutletListPageState createState() => _WorkshopOutletListPageState();
// }

// class _WorkshopOutletListPageState extends State<WorkshopOutletListPage> {
//   late Stream<QuerySnapshot> _workshopOutletsStream;

//   @override
//   void initState() {
//     super.initState();

//     // Get the UID of the currently logged-in user
//     String? userUid = FirebaseAuth.instance.currentUser?.uid;

//     _workshopOutletsStream = FirebaseFirestore.instance
//         .collection('workshop_outlets')
//         .where('user_id', isEqualTo: userUid)
//         .snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _workshopOutletsStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           var workshopOutlets = snapshot.data!.docs;

//           if (workshopOutlets.isEmpty) {
//             return Center(
//               child: Text('No workshop outlets available'),
//             );
//           }

//           return ListView.builder(
//             itemCount: workshopOutlets.length,
//             itemBuilder: (context, index) {
//               var workshopOutlet =
//                   workshopOutlets[index].data() as Map<String, dynamic>;
//               var outletName =
//                   workshopOutlet['nama_outlet'] ?? 'Nama Outlet Tidak Tersedia';
//               var address = workshopOutlet['alamat'] ?? 'Alamat Tidak Tersedia';

//               return ListTile(
//                 title: Text(outletName),
//                 subtitle: Text(address),
//                 leading: Icon(Icons.home),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () {
//                         // Navigate to the edit page
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => EditWorkshopOutlet(
//                               workshopOutletId: workshopOutlets[index].id,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () async {
//                         // Show delete confirmation dialog and get response
//                         bool? deleteConfirmed =
//                             await _showDeleteConfirmationDialog(context);

//                         // If the response is true, delete the workshop outlet
//                         if (deleteConfirmed == true) {
//                           FirebaseFirestore.instance
//                               .collection('workshop_outlets')
//                               .doc(workshopOutlets[index].id)
//                               .delete();

//                           // Show a Snackbar that the item has been deleted successfully
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content:
//                                   Text('Workshop Outlet deleted successfully'),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Function to show the delete confirmation dialog
//   Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirmation'),
//           content:
//               Text('Are you sure you want to delete this workshop outlet?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otoranger/screens/ranger/profile/index.dart';
import 'package:otoranger/screens/ranger/workshop_outlet/edit.dart';
import 'package:otoranger/screens/ranger/workshop_outlet/add.dart'; // Import the add page

class WorkshopOutletListPage extends StatefulWidget {
  @override
  _WorkshopOutletListPageState createState() => _WorkshopOutletListPageState();
}

class _WorkshopOutletListPageState extends State<WorkshopOutletListPage> {
  late Stream<QuerySnapshot> _workshopOutletsStream;

  @override
  void initState() {
    super.initState();

    // Get the UID of the currently logged-in user
    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    _workshopOutletsStream = FirebaseFirestore.instance
        .collection('workshop_outlets')
        .where('user_id', isEqualTo: userUid)
        .snapshots();
  }

  Widget _title() {
    return const Text('OTORANGER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _workshopOutletsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          var workshopOutlets = snapshot.data!.docs;

          if (workshopOutlets.isEmpty) {
            return Center(
              child: Text('No workshop outlets available'),
            );
          }

          return ListView.builder(
            itemCount: workshopOutlets.length,
            itemBuilder: (context, index) {
              var workshopOutlet =
                  workshopOutlets[index].data() as Map<String, dynamic>;
              var outletName =
                  workshopOutlet['nama_outlet'] ?? 'Nama Outlet Tidak Tersedia';
              var address = workshopOutlet['alamat'] ?? 'Alamat Tidak Tersedia';

              return ListTile(
                title: Text(outletName),
                subtitle: Text(address),
                leading: Icon(Icons.home),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navigate to the edit page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditWorkshopOutlet(
                              workshopOutletId: workshopOutlets[index].id,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        // Show delete confirmation dialog and get response
                        bool? deleteConfirmed =
                            await _showDeleteConfirmationDialog(context);

                        // If the response is true, delete the workshop outlet
                        if (deleteConfirmed == true) {
                          FirebaseFirestore.instance
                              .collection('workshop_outlets')
                              .doc(workshopOutlets[index].id)
                              .delete();

                          // Show a Snackbar that the item has been deleted successfully
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Workshop Outlet deleted successfully'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Navigate to the add page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddWorkshopOutlet(),
            ),
          );
        },
        child: Text('Tambah Outlet'), // Adjust the text accordingly
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set the initial index (Home)
        onTap: (index) {
          // Handle taps on the bottom navigation items
          switch (index) {
            case 0:
              // Navigate to Home (this page)
              break;
            case 1:
              // Navigate to Pesanan
              // Add your navigation logic here
              break;
            case 2:
              // Navigate to Keuangan
              // Add your navigation logic here
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileTabPage()),
              );
              // Navigate to Profil
              // Add your navigation logic here
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Keuangan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // Function to show the delete confirmation dialog
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content:
              Text('Are you sure you want to delete this workshop outlet?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
