import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/utils/shared_preferences_instance.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:uuid/uuid.dart';

class InsertBoletoController {
  var model = BoletoModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateVencimento(String? value) {
    if (value?.isEmpty ?? true) {
      return "A data de vencimento não pode ser vazio";
    }

    final formattedValue = value!.split('/').reversed.join('-');

    if(DateTime.tryParse(formattedValue) == null) {
      return 'Digite uma data válida';
    }
    ///Se houver um intervalo maior que de 250 anos, o seu intervalo é inválido
    else if (DateTime.now().difference(DateTime.parse(formattedValue)).inDays > 91250) {
      return 'Intervalo de data inválido';
    }

    return null;
  }
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

  Future<void> saveBankSlip(BoletoListController boletoProvider) async {
    final instance = SharedPreferencesInstance.instance!;
    final boletos = instance.getStringList(BoletoModel.key) ?? <String>[];
    final generator = Uuid();
    final uuid = generator.v4();
    final modelWithUuid = model.copyWith(
      uuid: uuid,
      isPaid: false,
    );
    assert(modelWithUuid.uuid != null, 'ANTES DE SALVAR NO BANCO É OBRIGATÓRIO ADICIONAR O UUID PARA IDENTIFICAR A ENTIDADE');
    boletos.add(modelWithUuid.toJson());
    await instance.setStringList(BoletoModel.key, boletos);
    boletoProvider.addBoleto(modelWithUuid);
    return;
  }

  Future<void> createBankSlip(BoletoListController boletoProvider) async {
    return await saveBankSlip(boletoProvider);
  }
}
