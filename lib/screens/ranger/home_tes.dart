// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class RangerHomePage1 extends StatefulWidget {
//   const RangerHomePage1({Key? key}) : super(key: key);

//   @override
//   State<RangerHomePage1> createState() => _RangerHomePage1State();
// }

// class _RangerHomePage1State extends State<RangerHomePage1> {
//   // text fields' controllers
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();

//   final CollectionReference _productss =
//       FirebaseFirestore.instance.collection('products');

//   var formatter = NumberFormat.decimalPatternDigits(
//     locale: 'id_ID',
//     decimalDigits: 0,
//   );

//   // Fungsi ini dijalankan saat floatting action button di tekan
//   // Menambahkan product jika tidak ada documentSnapshot yang dimasukkan sebagai parameter
//   // Jika documentSnapshot != null maka product yang ditampilkan akan di update
// // Add these variables to your _RangerHomePage1State class
//   bool _otoTires = false;
//   bool _otoServices = false;
//   bool _otoPickup = false;
//   bool _otoInspect = false;
//   bool _otoShop = false;

// // Update your _createOrUpdate function
//   Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
//     String action = 'create';
//     if (documentSnapshot != null) {
//       action = 'update';
//       _nameController.text = documentSnapshot['name'];
//       _priceController.text = documentSnapshot['price'].toString();
//       _otoTires = documentSnapshot['ototires'] ?? false;
//       _otoServices = documentSnapshot['otoservices'] ?? false;
//       _otoPickup = documentSnapshot['otopickup'] ?? false;
//       _otoInspect = documentSnapshot['otoinspect'] ?? false;
//       _otoShop = documentSnapshot['otoshop'] ?? false;
//     }

//     await showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext ctx) {
//         return Padding(
//           padding: EdgeInsets.only(
//             top: 20,
//             left: 20,
//             right: 20,
//             // prevent the soft keyboard from covering text fields
//             bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 keyboardType:
//                     const TextInputType.numberWithOptions(decimal: true),
//                 controller: _priceController,
//                 decoration: const InputDecoration(
//                   labelText: 'Price',
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               // Checkbox for ototires
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoTires,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoTires = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Tires'),
//                 ],
//               ),
//               // Checkbox for otoservices
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoServices,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoServices = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Services'),
//                 ],
//               ),
//               // Checkbox for otopickup
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoPickup,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoPickup = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Pickup'),
//                 ],
//               ),
//               // Checkbox for otoinspect
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoInspect,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoInspect = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Inspect'),
//                 ],
//               ),
//               // Checkbox for otoshop
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoTires,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoTires = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Tires'),
//                   if (_otoTires) Icon(Icons.check, color: Colors.green),
//                 ],
//               ),
//               ElevatedButton(
//                 child: Text(action == 'create' ? 'Create' : 'Update'),
//                 onPressed: () async {
//                   final String? name = _nameController.text;
//                   final int? price = int.tryParse(_priceController.text);
//                   if (name != null && price != null) {
//                     if (action == 'create') {
//                       // Persist a new product to Firestore
//                       await _productss.add({
//                         "name": name,
//                         "price": price,
//                         "ototires": _otoTires,
//                         "otoservices": _otoServices,
//                         "otopickup": _otoPickup,
//                         "otoinspect": _otoInspect,
//                         "otoshop": _otoShop,
//                       });
//                     }

//                     if (action == 'update') {
//                       // Update the product
//                       await _productss.doc(documentSnapshot!.id).update({
//                         "name": name,
//                         "price": price,
//                         "ototires": _otoTires,
//                         "otoservices": _otoServices,
//                         "otopickup": _otoPickup,
//                         "otoinspect": _otoInspect,
//                         "otoshop": _otoShop,
//                       });
//                     }

//                     // Clear the text fields and checkboxes
//                     _nameController.text = '';
//                     _priceController.text = '';
//                     _otoTires = false;
//                     _otoServices = false;
//                     _otoPickup = false;
//                     _otoInspect = false;
//                     _otoShop = false;

//                     // Hide the bottom sheet
//                     if (!context.mounted) return;
//                     Navigator.of(context).pop();
//                   }
//                 },
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Fungsi untuk menghapus product berdasarkan productId
//   Future<void> _deleteProduct(String productId) async {
//     await _productss.doc(productId).delete();

//     // Show a snackbar
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('You have successfully deleted a product')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Firestore CRUD'),
//       ),
//       // StreamBuilder digunakan untuk menampilkan semua product dari Firestore
//       body: StreamBuilder(
//         stream: _productss.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     streamSnapshot.data!.docs[index];
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(documentSnapshot['name']),
//                     subtitle: Text(formatter.format(documentSnapshot['price'])),
//                     trailing: SizedBox(
//                       width: 100,
//                       child: Row(
//                         children: [
//                           // Tombol untuk edit product
//                           IconButton(
//                               icon: const Icon(Icons.edit),
//                               onPressed: () =>
//                                   _createOrUpdate(documentSnapshot)),
//                           // Tombol untuk menghapus product
//                           IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () =>
//                                   _deleteProduct(documentSnapshot.id)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//       // Menambahkan product
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _createOrUpdate(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class RangerHomePage1 extends StatefulWidget {
//   const RangerHomePage1({Key? key}) : super(key: key);

//   @override
//   State<RangerHomePage1> createState() => _RangerHomePage1State();
// }

// class _RangerHomePage1State extends State<RangerHomePage1> {
//   final TextEditingController _nameController = TextEditingController();
//    final TextEditingController _basePriceController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController(); // Added address controller

//   final CollectionReference _productss =
//       FirebaseFirestore.instance.collection('products');

//   var formatter = NumberFormat.decimalPatternDigits(
//     locale: 'id_ID',
//     decimalDigits: 0,
//   );

//   bool _otoTires = false;
//   bool _otoServices = false;
//   bool _otoPickup = false;
//   bool _otoInspect = false;
//   bool _otoShop = false;
//   bool _showCheckmark = false;

//   Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
//     String action = 'create';
//     if (documentSnapshot != null) {
//       action = 'update';
//       _nameController.text = documentSnapshot['name'];
//       _priceController.text = documentSnapshot['price'].toString();
//       _addressController.text = documentSnapshot['address'] ?? ''; // Added address
//       _otoTires = documentSnapshot['ototires'] ?? false;
//       _otoServices = documentSnapshot['otoservices'] ?? false;
//       _otoPickup = documentSnapshot['otopickup'] ?? false;
//       _otoInspect = documentSnapshot['otoinspect'] ?? false;
//       _otoShop = documentSnapshot['otoshop'] ?? false;
//     }

//     await showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext ctx) {
//         return Padding(
//           padding: EdgeInsets.only(
//             top: 20,
//             left: 20,
//             right: 20,
//             bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 keyboardType:
//                     const TextInputType.numberWithOptions(decimal: true),
//                 controller: _basePriceController,
//                 decoration: const InputDecoration(
//                   labelText: 'Base Price',
//                 ),
//               ),
//               TextField(
//                 controller: _addressController,
//                 decoration: const InputDecoration(labelText: 'Address'),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoTires,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoTires = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Tires'),
//                   if (_otoTires)
//                     Expanded(
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: _otoTiresPriceController,
//                         decoration: InputDecoration(labelText: 'Price'),
//                       ),
//                     ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoServices,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoServices = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Services'),
//                   if (_otoServices)
//                     Expanded(
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: _otoServicesPriceController,
//                         decoration: InputDecoration(labelText: 'Price'),
//                       ),
//                     ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoPickup,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoPickup = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Pickup'),
//                   if (_otoPickup)
//                     Expanded(
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: _otoPickupPriceController,
//                         decoration: InputDecoration(labelText: 'Price'),
//                       ),
//                     ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoInspect,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoInspect = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Inspect'),
//                   if (_otoInspect)
//                     Expanded(
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: _otoInspectPriceController,
//                         decoration: InputDecoration(labelText: 'Price'),
//                       ),
//                     ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _otoShop,
//                     onChanged: (value) {
//                       setState(() {
//                         _otoShop = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('Oto Shop'),
//                   if (_otoShop)
//                     Expanded(
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller: _otoShopPriceController,
//                         decoration: InputDecoration(labelText: 'Price'),
//                       ),
//                     ),
//                 ],
//               ),
//               // Display total price based on input prices
//               Text('Total Price: ${_calculateTotalPrice()}'),
//               ElevatedButton(
//                 child: Text(action == 'create' ? 'Create' : 'Update'),
//                 onPressed: () async {
//                   final String? name = _nameController.text;
//                   final int? basePrice = int.tryParse(_basePriceController.text);
//                   final String? address = _addressController.text;
//                   if (name != null && basePrice != null && address != null) {
//                     // ... (previous code)
//                   }
//                 },
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Method to calculate total price based on input prices
//   int _calculateTotalPrice() {
//     int basePrice = int.tryParse(_basePriceController.text) ?? 0;
//     if (_otoTires) basePrice += int.tryParse(_otoTiresPriceController.text) ?? 0;
//     if (_otoServices)
//       basePrice += int.tryParse(_otoServicesPriceController.text) ?? 0;
//     if (_otoPickup) basePrice += int.tryParse(_otoPickupPriceController.text) ?? 0;
//     if (_otoInspect)
//       basePrice += int.tryParse(_otoInspectPriceController.text) ?? 0;
//     if (_otoShop) basePrice += int.tryParse(_otoShopPriceController.text) ?? 0;

//     return basePrice;
//   }
//       },
//     );
//   }

//   Future<void> _deleteProduct(String productId) async {
//     await _productss.doc(productId).delete();

//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('You have successfully deleted a product')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Firestore CRUD'),
//       ),
//       body: StreamBuilder(
//         stream: _productss.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     streamSnapshot.data!.docs[index];
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(documentSnapshot['name']),
//                     subtitle: Text(formatter.format(documentSnapshot['price'])),
//                     trailing: SizedBox(
//                       width: 100,
//                       child: Row(
//                         children: [
//                           IconButton(
//                               icon: const Icon(Icons.edit),
//                               onPressed: () =>
//                                   _createOrUpdate(documentSnapshot)),
//                           IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () =>
//                                   _deleteProduct(documentSnapshot.id)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _createOrUpdate(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RangerHomePage1 extends StatefulWidget {
  const RangerHomePage1({Key? key}) : super(key: key);

  @override
  State<RangerHomePage1> createState() => _RangerHomePage1State();
}

class _RangerHomePage1State extends State<RangerHomePage1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _basePriceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _otoTiresPriceController =
      TextEditingController();
  final TextEditingController _otoServicesPriceController =
      TextEditingController();
  final TextEditingController _otoPickupPriceController =
      TextEditingController();
  final TextEditingController _otoInspectPriceController =
      TextEditingController();
  final TextEditingController _otoShopPriceController = TextEditingController();

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  var formatter = NumberFormat.decimalPatternDigits(
    locale: 'id_ID',
    decimalDigits: 0,
  );

  bool _otoTires = false;
  bool _otoServices = false;
  bool _otoPickup = false;
  bool _otoInspect = false;
  bool _otoShop = false;
  bool _showCheckmark = false;

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _basePriceController.text = documentSnapshot['basePrice'].toString();
      _addressController.text = documentSnapshot['address'] ?? '';
      _otoTires = documentSnapshot['ototires'] ?? false;
      _otoServices = documentSnapshot['otoservices'] ?? false;
      _otoPickup = documentSnapshot['otopickup'] ?? false;
      _otoInspect = documentSnapshot['otoinspect'] ?? false;
      _otoShop = documentSnapshot['otoshop'] ?? false;
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                controller: _basePriceController,
                decoration: const InputDecoration(
                  labelText: 'Base Price',
                ),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                title: Text('Oto Tires'),
                value: _otoTires,
                onChanged: (value) {
                  setState(() {
                    _otoTires = value ?? false;
                  });
                },
                secondary: _otoTires
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _otoTiresPriceController,
                        decoration: InputDecoration(labelText: 'Price'),
                      )
                    : null,
              ),
              CheckboxListTile(
                title: Text('Oto Services'),
                value: _otoServices,
                onChanged: (value) {
                  setState(() {
                    _otoServices = value ?? false;
                  });
                },
                secondary: _otoServices
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _otoServicesPriceController,
                        decoration: InputDecoration(labelText: 'Price'),
                      )
                    : null,
              ),
              CheckboxListTile(
                title: Text('Oto Pickup'),
                value: _otoPickup,
                onChanged: (value) {
                  setState(() {
                    _otoPickup = value ?? false;
                  });
                },
                secondary: _otoPickup
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _otoPickupPriceController,
                        decoration: InputDecoration(labelText: 'Price'),
                      )
                    : null,
              ),
              CheckboxListTile(
                title: Text('Oto Inspect'),
                value: _otoInspect,
                onChanged: (value) {
                  setState(() {
                    _otoInspect = value ?? false;
                  });
                },
                secondary: _otoInspect
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _otoInspectPriceController,
                        decoration: InputDecoration(labelText: 'Price'),
                      )
                    : null,
              ),
              CheckboxListTile(
                title: Text('Oto Shop'),
                value: _otoShop,
                onChanged: (value) {
                  setState(() {
                    _otoShop = value ?? false;
                  });
                },
                secondary: _otoShop
                    ? TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _otoShopPriceController,
                        decoration: InputDecoration(labelText: 'Price'),
                      )
                    : null,
              ),
              // Display total price based on input prices
              Text('Total Price: ${_calculateTotalPrice()}'),
              ElevatedButton(
                child: Text(action == 'create' ? 'Create' : 'Update'),
                onPressed: () async {
                  final String? name = _nameController.text;
                  final int? basePrice =
                      int.tryParse(_basePriceController.text);
                  final String? address = _addressController.text;
                  if (name != null && basePrice != null && address != null) {
                    // ... (previous code)
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to calculate total price based on input prices
  int _calculateTotalPrice() {
    int basePrice = int.tryParse(_basePriceController.text) ?? 0;
    if (_otoTires)
      basePrice += int.tryParse(_otoTiresPriceController.text) ?? 0;
    if (_otoServices)
      basePrice += int.tryParse(_otoServicesPriceController.text) ?? 0;
    if (_otoPickup)
      basePrice += int.tryParse(_otoPickupPriceController.text) ?? 0;
    if (_otoInspect)
      basePrice += int.tryParse(_otoInspectPriceController.text) ?? 0;
    if (_otoShop) basePrice += int.tryParse(_otoShopPriceController.text) ?? 0;

    return basePrice;
  }

  Future<void> _deleteProduct(String productId) async {
    await _products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You have successfully deleted a product'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore CRUD'),
      ),
      body: StreamBuilder(
        stream: _products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(formatter.format(documentSnapshot['price'])),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _createOrUpdate(documentSnapshot),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteProduct(documentSnapshot.id),
                          ),
                        ],
                      ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
