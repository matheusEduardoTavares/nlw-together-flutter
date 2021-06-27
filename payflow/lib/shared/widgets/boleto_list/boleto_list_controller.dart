import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/utils/shared_preferences_instance.dart';

class BoletoListController {
  final boletosNotifier = 
    ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => 
    boletosNotifier.value = value;

  BoletoListController() {
    getBoletos();
  }

  void getBoletos() async {
    try {
      final instance = SharedPreferencesInstance.instance!;
      final response = instance.getStringList("boletos");
      boletos = response!.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {}
  }

  void dispose() {
    boletosNotifier.dispose();
  }
}
