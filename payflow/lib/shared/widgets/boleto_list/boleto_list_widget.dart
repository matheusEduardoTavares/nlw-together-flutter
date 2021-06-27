import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_order_items.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';

class BoletoListWidget extends StatefulWidget {
  BoletoListWidget({
    Key? key,
    this.orderBy,
  }) : super(key: key);

  final ExtractOrderItems? orderBy;

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  final _controller = BoletoListController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: _controller.boletosNotifier,
      builder: (_, boletos, __) {
        List<BoletoModel> items;
        items = [...boletos];

        if (widget.orderBy != null) {
          if (widget.orderBy == ExtractOrderItems.dueDate) {
            items.sort(
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
          else if (widget.orderBy == ExtractOrderItems.value) {
            items.sort(
              (a, b) => a.value!.compareTo(b.value!)
            );
          }
        }

        return Column(
          children: items.map(
            (e) => BoletoTileWidget(data: e),
          ).toList(),
        );
      },
    );
  }
}
