import 'package:payflow/shared/models/boleto_model.dart';

extension ListBoletoModelUtilities on List<BoletoModel> {
  void orderByDate() {
    this.sort(
      (a, b) {
        final firstDate = DateTime.tryParse(a.dueDate!);
        final secondDate = DateTime.tryParse(b.dueDate!);

        if (firstDate == null || secondDate == null) {
          return 0;
        }

        return firstDate.compareTo(secondDate);
      }
    );
  }

  void orderByValue() {
    this.sort(
      (a, b) => a.value!.compareTo(b.value!)
    );
  }
}