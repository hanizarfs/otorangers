import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditWorkshopOutlet extends StatefulWidget {
  final String workshopOutletId;

  EditWorkshopOutlet({required this.workshopOutletId});

  @override
  _EditWorkshopOutletState createState() => _EditWorkshopOutletState();
}

class _EditWorkshopOutletState extends State<EditWorkshopOutlet> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final List<Map<String, dynamic>> _layananList = [];
  final TextEditingController _layananController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  int _totalHarga = 0;

  @override
  void initState() {
    super.initState();
    // Fetch workshop outlet data when the widget is initialized
    _fetchWorkshopOutletData();
  }

  void _fetchWorkshopOutletData() async {
    try {
      // Fetch workshop outlet data from Firestore based on workshopOutletId
      DocumentSnapshot workshopOutlet =
          await FirebaseFirestore.instance.collection('workshop_outlets').doc(widget.workshopOutletId).get();

      // Update state with fetched data
      setState(() {
        _namaController.text = workshopOutlet['nama_outlet'];
        _alamatController.text = workshopOutlet['alamat'];
        _layananList.addAll(List<Map<String, dynamic>>.from(workshopOutlet['layanan']));
        _updateTotalHarga(); // Update total harga based on fetched layananList
      });
    } catch (e) {
      print('Error fetching workshop outlet data: $e');
    }
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

  void _updateWorkshopOutlet() async {
    final String namaOutlet = _namaController.text;
    final String alamat = _alamatController.text;

    if (namaOutlet.isNotEmpty && alamat.isNotEmpty && _layananList.isNotEmpty) {
      try {
        // Update workshop outlet data in Firestore based on workshopOutletId
        await FirebaseFirestore.instance.collection('workshop_outlets').doc(widget.workshopOutletId).update({
          'nama_outlet': namaOutlet,
          'alamat': alamat,
          'layanan': _layananList,
          'total_harga': _totalHarga,
        });

        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Workshop Outlet berhasil diupdate.'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate back to previous screen
        Navigator.pop(context);
      } catch (e) {
        print('Error updating workshop outlet data: $e');
        // Show error Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengupdate Workshop Outlet. Silakan coba lagi.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      // Show error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengupdate Workshop Outlet. Pastikan semua input diisi.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Workshop Outlet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              onPressed: _updateWorkshopOutlet,
              child: Text('Update Workshop Outlet'),
            ),
          ],
        ),
      ),
    );
  }
}
