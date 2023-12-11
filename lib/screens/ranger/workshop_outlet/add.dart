import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddWorkshopOutlet extends StatefulWidget {
  @override
  _AddWorkshopOutletState createState() => _AddWorkshopOutletState();
}

class _AddWorkshopOutletState extends State<AddWorkshopOutlet> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final List<Map<String, dynamic>> _layananList = [];
  final TextEditingController _layananController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  User? _user; // User object to store the logged-in user
  int _totalHarga = 0;

  @override
  void initState() {
    super.initState();
    // Get the current user when the widget is initialized
    _user = FirebaseAuth.instance.currentUser;
  }

  void _addLayanan() {
    final String layanan = _layananController.text;
    final String harga = _hargaController.text;

    if (layanan.isNotEmpty && harga.isNotEmpty) {
      setState(() {
        _layananList.add({'layanan': layanan, 'harga': harga});
        _layananController.clear();
        _hargaController.clear();
        _updateTotalHarga(); // Update total harga when adding a new service
      });
    }
  }

  void _removeLayanan(int index) {
    setState(() {
      _layananList.removeAt(index);
      _updateTotalHarga(); // Update total harga when removing a service
    });
  }

  void _updateTotalHarga() {
    // Calculate total harga from the _layananList
    int totalHarga = 0;
    for (var layanan in _layananList) {
      totalHarga += int.parse(layanan['harga']);
    }

    setState(() {
      _totalHarga = totalHarga;
    });
  }

  void _addWorkshopOutlet() {
    final String namaOutlet = _namaController.text;
    final String alamat = _alamatController.text;

    if (namaOutlet.isNotEmpty && alamat.isNotEmpty && _layananList.isNotEmpty) {
      FirebaseFirestore.instance.collection('workshop_outlets').add({
        'user_id': _user?.uid,
        'nama_outlet': namaOutlet,
        'alamat': alamat,
        'layanan': _layananList,
        'total_harga': _totalHarga,
      });

      // Clear the input fields and reset total harga
      _namaController.clear();
      _alamatController.clear();
      _layananList.clear();
      _totalHarga = 0;

      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Workshop Outlet berhasil ditambahkan.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Show error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Gagal menambahkan Workshop Outlet. Pastikan semua input diisi.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Workshop Outlet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('User ID: ${_user?.uid}'),
            SizedBox(height: 16.0),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Outlet Bengkel'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            SizedBox(height: 16.0),
            Text('Layanan:'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _layananController,
                    decoration: InputDecoration(labelText: 'Layanan'),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _hargaController,
                    decoration: InputDecoration(labelText: 'Harga'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _addLayanan,
                  child: Text('Tambah Layanan'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Layanan Terpilih:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _layananList.asMap().entries.map((entry) {
                final int index = entry.key;
                final Map<String, dynamic> layanan = entry.value;

                return ListTile(
                  title: Text('${layanan['layanan']} - ${layanan['harga']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => _removeLayanan(index),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text('Total Harga: $_totalHarga'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addWorkshopOutlet,
              child: Text('Tambah Workshop Outlet'),
            ),
          ],
        ),
      ),
    );
  }
}
