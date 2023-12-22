// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final TextEditingController _listProgramStudiController =
      TextEditingController(text: 'SI');

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
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
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
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
