// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mahasiswa_app/latihan_page.dart';
import 'home_page.dart';
import 'mahasiswa_form_page.dart';
import 'mahasiswa_list_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'mahasiswa_detail_page.dart';
import 'mahasiswa_edit_page.dart';
import 'register_page.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
      routes: {
        '/mahasiswa-form': (context) => MahasiswaFormPage(),
        '/mahasiswa-list': (context) => MahasiswaListPage(),
        '/mahasiswa-detail': (context) => MahasiswaDetailPage(),
        '/mahasiswa-edit': (context) => MahasiswaEditPage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/latihan': (context) => LatihanPage(),
        '/home': (context) => HomePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
