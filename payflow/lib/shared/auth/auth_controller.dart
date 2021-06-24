import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  var _isAuthenticated = false;
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
      _user = user;
      _isAuthenticated = true;
      Navigator.pushReplacementNamed(
        context,
        '/home'
      );
    }
    else {
      _isAuthenticated = false;
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
    final user = instance.getString("user");
    setUser(context, user != null ? UserModel.fromJson(user) : null);
    return;
  }
}