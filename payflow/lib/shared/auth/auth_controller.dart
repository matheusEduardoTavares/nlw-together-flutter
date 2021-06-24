import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  ///O usuário pode estar nulo, 
  ///então temos que por um ? 
  ///após o [UserModel], ou
  ///um ! após a variável do usuário,
  ///significando que esta variável 
  ///nunca estará nula, ou seja, 
  ///garantimos que só chamaremos 
  ///o getter se de fato o usuário
  ///estiver preenchido
  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(
        context,
        '/home'
      );
    }
    else {
      Navigator.pushReplacementNamed(
        context,
        '/login'
      );
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    if (instance.containsKey('user')) {
      final json = instance.getString('user')!;
      setUser(context, UserModel.fromJson(json));
      return;
    }

    setUser(context, null);
    return;
  }
}