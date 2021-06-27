import 'package:flutter/widgets.dart';
import 'package:payflow/modules/extract/extract_order_items.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/utils/shared_preferences_instance.dart';
import 'package:payflow/shared/extensions/list_boleto_model_extensions.dart';

class BoletoListController with ChangeNotifier {
  final _boletos = <BoletoModel>[];

  List<BoletoModel> get boletos => List<BoletoModel>.from(_boletos);
  List<BoletoModel> get paidBoletos => boletos.filterOnlyPaid();
  List<BoletoModel> get notPaidBoletos => boletos.filterOnlyNotPaid();

  BoletoListController({bool? isGetBoletos = true}) {
    if (isGetBoletos ?? true) {
      getBoletos();
    }
  }

  void getBoletos() async {
    try {
      final instance = SharedPreferencesInstance.instance!;
      final response = instance.getStringList(BoletoModel.key);
      final boletosFromSharedPreferences = response!.map((e) => BoletoModel.fromJson(e)).toList();
      _boletos.clear();
      _boletos.addAll(boletosFromSharedPreferences);
      notifyListeners();
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

    if (indexBoletoOnList > -1) {
      final newBoletos = [...boletos];
      newBoletos[indexBoletoOnList] = data;

      final instance = SharedPreferencesInstance.instance;
      final newBoletosInJson = newBoletos.map((e) => e.toJson()).toList();
      await instance!.setStringList(BoletoModel.key, newBoletosInJson);
      _boletos.clear();
      _boletos.addAll(newBoletos);
      notifyListeners();
    }
  }

  void addBoleto(BoletoModel newBoleto) {
    _boletos.add(newBoleto);
    notifyListeners();
  }
}
