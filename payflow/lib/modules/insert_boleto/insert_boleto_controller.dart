import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/utils/shared_preferences_instance.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();
  var model = BoletoModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateVencimento(String? value) =>
      value?.isEmpty ?? true ? 
        "A data de vencimento não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? 
        "O código do boleto não pode ser vazio" : null;

  void onChange({
    String? name, 
    String? dueDate, 
    double? value, 
    String? barcode
  }){
    model = model.copyWith(
      name: name, 
      dueDate: dueDate, 
      value: value, 
      barcode: barcode,
    );
  }

  Future<void> saveBankSlip() async {
    final instance = SharedPreferencesInstance.instance!;
    final boletos = instance.getStringList("boletos") ?? <String>[];
    boletos.add(model.toJson());
    await instance.setStringList("boletos", boletos);
    return;
  }

  Future<void> createBankSlip() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return await saveBankSlip();
    }
  }
}
