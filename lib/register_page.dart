// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void simpanData() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      var url = Uri.parse('http://belajar-api.unama.ac.id/api/register');
      var data = {
        'email': _emailController.text,
        'name': _nameController.text,
        'password': _passwordController.text,
      };
      var response = await http.post(url, body: data, headers: {
        'Accept': 'application/json',
      });
      EasyLoading.dismiss();
      if (response.statusCode == 201) {
        EasyLoading.showSuccess("Hore..Registrasi berhasil");
      } else {
        var responJson = jsonDecode(response.body);
        EasyLoading.showError('Ops...${responJson['message']}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendaftaran User'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text("Registrasi"),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Masukkan Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        hintText: 'Masukkan Nama',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Masukkan Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
<<<<<<< HEAD
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          EasyLoading.show();
                          try {
                            await Supabase.instance.client.auth.signUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                              data: {'name': _nameController.text},
                            );
                            EasyLoading.showSuccess(
                                "Hore..Registrasi berhasil");
                            Navigator.pushReplacementNamed(context, '/login');
                          } catch (e) {
                            EasyLoading.showError("Ops.. $e");
                          }
                          EasyLoading.dismiss();
                        }
                      },
=======
                      onPressed: () => simpanData(),
>>>>>>> parent of ac51c3e (refactor)
                      child: Text('Daftar'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.maxFinite, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
