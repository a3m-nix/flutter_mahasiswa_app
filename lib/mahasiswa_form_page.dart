// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
=======
>>>>>>> parent of ac51c3e (refactor)

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
<<<<<<< HEAD
  final TextEditingController _listProgramStudiController =
      TextEditingController(text: 'SI');
=======
  final TextEditingController _programStudiController = TextEditingController();

  void _simpanForm(context) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      var url = Uri.parse('http://belajar-api.unama.ac.id/api/mahasiswa');
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
        Navigator.pop(context);
      } else {
        var responJson = jsonDecode(response.body);
        EasyLoading.showError('Ops..' + responJson['message']);
      }
    }
  }
>>>>>>> parent of ac51c3e (refactor)

  var listProgramStudi = [];

  @override
  void initState() {
    super.initState();
    getProgramStudi();
  }

  void getProgramStudi() async {
    var data = await Supabase.instance.client.from('program_studi').select();
    setState(() {
      listProgramStudi = data;
    });
  }

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
              ),
<<<<<<< HEAD
              DropdownButtonFormField(
                isExpanded: true,
                value: _listProgramStudiController.text,
                decoration: InputDecoration(
                  labelText: 'Program Studi',
                ),
                items: listProgramStudi.map((item) {
                  return DropdownMenuItem(
                    value: item['singkatan'],
                    child: Text(item['nama']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _listProgramStudiController.text = value.toString();
                  });
=======
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
>>>>>>> parent of ac51c3e (refactor)
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
<<<<<<< HEAD
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    EasyLoading.show();

                    var data = {
                      'nama': _namaController.text,
                      'nim': _nimController.text,
                      'tanggal_lahir': _tanggalLahirController.text,
                      'program_studi': _listProgramStudiController.text,
                    };
                    try {
                      final supabase = Supabase.instance.client;
                      await supabase.from('mahasiswa').insert(data);
                      EasyLoading.showSuccess('Data berhasil disimpan');
                    } catch (e) {
                      EasyLoading.showError('Ops..$e');
                    }
                    EasyLoading.dismiss();
                  }
                },
=======
                onPressed: () => _simpanForm(context),
>>>>>>> parent of ac51c3e (refactor)
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
