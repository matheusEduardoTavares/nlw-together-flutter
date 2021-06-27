import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

class DeterminePaidButtonsController {
  Future<void> setIsPaidBoleto(bool isPaid, BoletoModel boleto, BoletoListController providerBoleto) async {
    if (boleto.isPaid == isPaid) {
      return;
    }

    final boletoUpdated = boleto.copyWith(
      isPaid: isPaid,
    );

    await providerBoleto.updateBoleto(
      boletoUpdated,
    );
  }
}