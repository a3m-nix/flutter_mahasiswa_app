// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class MahasiswaListPage extends StatefulWidget {
  const MahasiswaListPage({Key? key}) : super(key: key);

  @override
  _MahasiswaListPageState createState() => _MahasiswaListPageState();
}

class _MahasiswaListPageState extends State<MahasiswaListPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void deleteData(id) {
    EasyLoading.show();
    var url = Uri.parse('http://belajar-api.unama.ac.id/api/mahasiswa/$id');
    http.delete(url).then((response) {
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Data berhasil dihapus');
        getData();
      } else {
        var responJson = jsonDecode(response.body);
        EasyLoading.showError('Ops..' + responJson['message']);
      }
    });
  }

  List listData = [];
  void getData() async {
    EasyLoading.show();
    final supabase = Supabase.instance.client;
    final data = await supabase.from('mahasiswa').select();
    setState(() {
      listData = data;
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
      ),
      body: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: SizedBox(
              width: 80,
              child: Row(
                children: [
                  IconButton(
<<<<<<< HEAD
                    onPressed: () async {
                      EasyLoading.show();
                      final supabase = Supabase.instance.client;
                      await supabase
                          .from('mahasiswa')
                          .delete()
                          .match({'id': listData[index]['id']});
                      EasyLoading.dismiss();
                      getData();
=======
                    onPressed: () {
                      deleteData(listData[index]['id']);
>>>>>>> parent of ac51c3e (refactor)
                    },
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/mahasiswa-edit',
                          arguments: listData[index]);
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/mahasiswa-detail',
                  arguments: listData[index]);
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(listData[index]['foto']),
            ),
            title: Text('Nama: ' + listData[index]['nim']),
            subtitle: Text('NIM:' + listData[index]['nama']),
          );
        },
      ),
    );
  }
}
