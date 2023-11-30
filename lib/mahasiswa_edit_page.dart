// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MahasiswaEditPage extends StatefulWidget {
  const MahasiswaEditPage({Key? key}) : super(key: key);

  @override
  _MahasiswaEditPageState createState() => _MahasiswaEditPageState();
}

class _MahasiswaEditPageState extends State<MahasiswaEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _programStudiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dataMhs = ModalRoute.of(context)!.settings.arguments as Map;
    _namaController.text = dataMhs['nama'];
    _nimController.text = dataMhs['nim'];
    _tanggalLahirController.text = dataMhs['tanggal_lahir'];
    _programStudiController.text = dataMhs['program_studi'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Edit Mahasiswa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(
                  labelText: 'NIM',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'NIM tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tanggalLahirController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tanggal Lahir tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _programStudiController,
                decoration: InputDecoration(
                  labelText: 'Program Studi',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Program Studi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    EasyLoading.show();
                    var url = Uri.parse(
                        'http://belajar-api.unama.ac.id/api/mahasiswa/${dataMhs['id']}');
                    var data = {
                      'nama': _namaController.text,
                      'nim': _nimController.text,
                      'tanggal_lahir': _tanggalLahirController.text,
                      'program_studi': _programStudiController.text,
                    };
                    var response = await http.put(url, body: data, headers: {
                      'Accept': 'application/json',
                    });
                    EasyLoading.dismiss();
                    if (response.statusCode == 200) {
                      EasyLoading.showSuccess('Data berhasil diupdate');
                    } else {
                      var responJson = jsonDecode(response.body);
                      EasyLoading.showError('Ops..' + responJson['message']);
                    }
                  }
                },
                child: Text('Update Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
