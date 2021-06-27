import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_order_items.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/utils/shared_preferences_instance.dart';
import 'package:payflow/shared/extensions/list_boleto_model_extensions.dart';

class BoletoListController {
  final boletosNotifier = 
    ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  List<BoletoModel> get paidBoletos => boletosNotifier.value.filterOnlyPaid();
  set boletos(List<BoletoModel> value) => 
    boletosNotifier.value = value;

  BoletoListController() {
    getBoletos();
  }

  void getBoletos() async {
    try {
      final instance = SharedPreferencesInstance.instance!;
      final response = instance.getStringList(BoletoModel.key);
      boletos = response!.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {}
  }

  List<BoletoModel> orderBoletos(List<BoletoModel> listToOrderBy, {ExtractOrderItems? defineOrder}) {
    if (defineOrder == null) {
      return listToOrderBy;
    }

    final other = [...listToOrderBy];
    if (defineOrder == ExtractOrderItems.dueDate) {
      other.orderByDate();
    }
    else if (defineOrder == ExtractOrderItems.value) {
      other.orderByValue();
    }

    return other;
  }

  List<BoletoModel> filterOnlyPaidBoletos(List<BoletoModel> listToOrderBy) {
    return listToOrderBy.filterOnlyPaid();
  }

  Future<void> updateBoleto(BoletoModel data) async {
    final indexBoletoOnList = boletos.indexWhere(
      (currentBoleto) => currentBoleto.uuid == data.uuid,
    );

    final newBoletos = [...boletos];
    newBoletos[indexBoletoOnList] = data;

    final instance = SharedPreferencesInstance.instance;
    final newBoletosInJson = newBoletos.map((e) => e.toJson()).toList();
    await instance!.setStringList(BoletoModel.key, newBoletosInJson);

    boletos = newBoletos;
  }

  void dispose() {
    boletosNotifier.dispose();
  }
}
