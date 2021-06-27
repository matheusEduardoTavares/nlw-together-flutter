import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

class DeterminePaidButtonsController {
  final _boletoController = BoletoListController();

  Future<void> setIsPaidBoleto(bool isPaid, BoletoModel boleto) async {
    if (boleto.isPaid == isPaid) {
      return;
    }

    final boletoUpdated = boleto.copyWith(
      isPaid: isPaid,
    );

    await _boletoController.updateBoleto(
      boletoUpdated,
    );
  }
}