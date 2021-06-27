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

  List<BoletoModel> filterOnlyPaid() {
    final onlyPaid = this.fold<List<BoletoModel>>(
      <BoletoModel>[],
      (allItemsToReturn, currentBoleto) {
        final newList = [...allItemsToReturn];
        if (currentBoleto.isPaid ?? false) {
          newList.add(currentBoleto);
        }
        return newList;
      } 
    );

    return onlyPaid;
  }

  List<BoletoModel> filterOnlyNotPaid() {
    final onlyNotPaid = this.fold<List<BoletoModel>>(
      <BoletoModel>[],
      (allItemsToReturn, currentBoleto) {
        final newList = [...allItemsToReturn];
        if (!(currentBoleto.isPaid ?? true)) {
          newList.add(currentBoleto);
        }
        return newList;
      } 
    );

    return onlyNotPaid;
  }
}