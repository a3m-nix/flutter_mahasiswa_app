import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LatihanPage extends StatefulWidget {
  const LatihanPage({Key? key}) : super(key: key);

  @override
  _LatihanPageState createState() => _LatihanPageState();
}

class _LatihanPageState extends State<LatihanPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  List listData = [];
  void getData() async {
    EasyLoading.show();
    var url = Uri.parse('https://doa-doa-api-ahmadramadhan.fly.dev/api');
    var respon = await http.get(url);
    var responJson = jsonDecode(respon.body);
    print(responJson);
    setState(() {
      listData = responJson;
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(listData[index]['ayat']),
          );
        },
      ),
    );
  }
}
