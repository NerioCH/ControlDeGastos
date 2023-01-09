// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_null_comparison

import 'package:controldegastos/aplication/use_cases/frmPrincipal.dart';
import 'package:controldegastos/aplication/use_cases/login/login.dart';
import 'package:controldegastos/aplication/use_cases/services/authService.dart';
import 'package:controldegastos/aplication/use_cases/services/sharedPreferences.dart';
import 'package:controldegastos/domain/entities/authUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rutas extends StatelessWidget {
  const Rutas({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<UserAuth?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<UserAuth?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserAuth? user = snapshot.data;
          guardarEmail(user?.email);
          return user == null ? login() : frmPrincipal();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

void guardarEmail(String? email) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('email', email??'');
}