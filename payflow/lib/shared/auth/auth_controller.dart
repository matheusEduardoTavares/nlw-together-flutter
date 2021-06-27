import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/utils/routes_name.dart';
import 'package:payflow/shared/utils/shared_preferences_instance.dart';

class AuthController {
  static UserModel? userModel;

  ///O usuário pode estar nulo, 
  ///então temos que por um ? 
  ///após o [UserModel], ou
  ///um ! após a variável do usuário,
  ///significando que esta variável 
  ///nunca estará nula, ou seja, 
  ///garantimos que só chamaremos 
  ///o getter se de fato o usuário
  ///estiver preenchido
  // UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      userModel = user;
      saveUser(user);
      Navigator.pushReplacementNamed(
        context,
        RoutesName.home,
      );
    }
    else {
      Navigator.pushReplacementNamed(
        context,
        RoutesName.login,
      );
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = SharedPreferencesInstance.instance!;
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = SharedPreferencesInstance.instance!;
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