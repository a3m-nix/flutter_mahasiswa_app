// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mahasiswa_app/latihan_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';
import 'mahasiswa_form_page.dart';
import 'mahasiswa_list_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'mahasiswa_detail_page.dart';
import 'mahasiswa_edit_page.dart';
import 'register_page.dart';
import 'login_page.dart';
import 'home_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://gnrvmhpistflsqaoolzs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImducnZtaHBpc3RmbHNxYW9vbHpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwMzUyOTIsImV4cCI6MjAxODYxMTI5Mn0.t-TjXQ_0u2R0KUx449Krm25Yj4NMaK0n5ypMzOCueRQ',
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Supabase.instance.client.auth.currentUser == null
          ? LoginPage()
          : HomePage(),
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
