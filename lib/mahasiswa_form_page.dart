// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MahasiswaFormPage extends StatefulWidget {
  const MahasiswaFormPage({Key? key}) : super(key: key);

  @override
  _MahasiswaFormPageState createState() => _MahasiswaFormPageState();
}

class _MahasiswaFormPageState extends State<MahasiswaFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _programStudiController =
      TextEditingController(text: 'SI');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Mhs'),
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
                onTap: () async {
                  var pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    _tanggalLahirController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
              ),
              DropdownButtonFormField(
                isExpanded: true,
                value: _programStudiController.text,
                decoration: InputDecoration(
                  labelText: 'Program Studi',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'SI',
                    child: Text('Sistem Informasi'),
                  ),
                  DropdownMenuItem(
                    value: 'TI',
                    child: Text('Teknik Informatika'),
                  ),
                  DropdownMenuItem(
                    value: 'SK',
                    child: Text('Sistem Komputer'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _programStudiController.text = value.toString();
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    EasyLoading.show();
                    var url = Uri.parse(
                        'http://belajar-api.unama.ac.id/api/mahasiswa');
                    var data = {
                      'nama': _namaController.text,
                      'nim': _nimController.text,
                      'tanggal_lahir': _tanggalLahirController.text,
                      'program_studi': _programStudiController.text,
                    };
                    var response = await http.post(url, body: data, headers: {
                      'Accept': 'application/json',
                    });
                    EasyLoading.dismiss();
                    if (response.statusCode == 201) {
                      EasyLoading.showSuccess('Data berhasil disimpan');
                    } else {
                      var responJson = jsonDecode(response.body);
                      EasyLoading.showError('Ops..' + responJson['message']);
                    }
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
