// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:otoranger/auth.dart';
// import 'package:otoranger/screens/ranger/workshop_outlet/add.dart';
// import 'package:otoranger/screens/ranger/workshop_outlet/index.dart';

// class RangerHomePage extends StatefulWidget {
//   @override
//   _RangerHomePageState createState() => _RangerHomePageState();
// }

// class _RangerHomePageState extends State<RangerHomePage> {
//   int _currentIndex = 0;

//   final User? user = Auth().currentUser;

//   Future<void> signOut() async {
//     await Auth().signOut();
//   }

//   Widget _title() {
//     return const Text('OTORANGER');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _title(),
//       ),
//       body: _getPage(_currentIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'Pesanan',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'Keuangan',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getPage(int index) {
//     switch (index) {
//       case 0:
//         return HomeTabPage();
//       case 1:
//         return OrderTabPage();
//       case 2:
//         return FinanceTabPage();
//       case 3:
//         return ProfileTabPage();
//       default:
//         return Container();
//     }
//   }
// }

// class HomeTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Home Ranger'),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddWorkshopOutlet()),
//               );
//             },
//             child: Text('Tambah Outlet Bengkel'),
//           ),
//           SizedBox(height: 20),
//           WorkshopOutletListPage(), // Memasukkan WorkshopOutletListPage di sini
//         ],
//       ),
//     );
//   }
// }

// class OrderTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text('tes'),
//       ),
//     );
//   }
// }

// class FinanceTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text('finance'),
//       ),
//     );
//   }
// }

// class ProfileTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text('profile'),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:otoranger/auth.dart';
// import 'package:otoranger/screens/ranger/workshop_outlet/add.dart';
// import 'package:otoranger/screens/ranger/workshop_outlet/edit.dart';
// import 'package:otoranger/screens/ranger/workshop_outlet/index.dart';

// class RangerHomePage extends StatefulWidget {
//   @override
//   _RangerHomePageState createState() => _RangerHomePageState();
// }

// class _RangerHomePageState extends State<RangerHomePage> {
//   int _currentIndex = 0;

//   final User? user = Auth().currentUser;

//   Future<void> signOut() async {
//     await Auth().signOut();
//   }

//   Widget _title() {
//     return const Text('OTORANGER');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _title(),
//       ),
//       body: _getPage(_currentIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'Pesanan',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'Keuangan',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getPage(int index) {
//     switch (index) {
//       case 0:
//         return HomeTabPage();
//       case 1:
//         return OrderTabPage();
//       case 2:
//         return FinanceTabPage();
//       case 3:
//         return ProfileTabPage();
//       default:
//         return Container();
//     }
//   }
// }

// class HomeTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Home Ranger'),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddWorkshopOutlet()),
//               );
//             },
//             child: Text('Tambah Outlet Bengkel'),
//           ),
//           SizedBox(height: 20),
//           WorkshopOutletListPage(),
//         ],
//       ),
//     );
//   }
// }

// class OrderTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text('tes'),
//       ),
//     );
//   }
// }

// class WorkshopOutletListPage extends StatefulWidget {
//   @override
//   _WorkshopOutletListPageState createState() => _WorkshopOutletListPageState();
// }

// class _WorkshopOutletListPageState extends State<WorkshopOutletListPage> {
//   late Stream<QuerySnapshot<Map<String, dynamic>>> _workshopOutletsStream;

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
//       body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otoranger/auth.dart';
import 'package:otoranger/screens/ranger/workshop_outlet/add.dart';
import 'package:otoranger/screens/ranger/workshop_outlet/index.dart';

class RangerHomePage extends StatefulWidget {
  @override
  _RangerHomePageState createState() => _RangerHomePageState();
}

class _RangerHomePageState extends State<RangerHomePage> {
  int _currentIndex = 0;

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
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
      body: _getPage(_currentIndex),
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

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeTabPage();
      case 1:
        return OrderTabPage();
      case 2:
        return FinanceTabPage();
      case 3:
        return ProfileTabPage();
      default:
        return Container();
    }
  }
}

class HomeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Ranger'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddWorkshopOutlet()),
              );
            },
            child: Text('Tambah Outlet Bengkel'),
          ),
          SizedBox(height: 20),
          Expanded(
            child:
                WorkshopOutletListPage(), // Use Expanded to fill available space
          ),
        ],
      ),
    );
  }
}

// Remaining parts of the code (OrderTabPage, FinanceTabPage, ProfileTabPage) stay the same...
class OrderTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('order'),
      ),
    );
  }
}

class FinanceTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('finance'),
      ),
    );
  }
}

class ProfileTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('profile'),
      ),
    );
  }
}
