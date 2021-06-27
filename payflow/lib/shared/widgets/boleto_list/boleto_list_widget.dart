import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_order_items.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';

class BoletoListWidget extends StatefulWidget {
  BoletoListWidget({
    Key? key,
    required this.boletoProvider,
    this.orderBy,
    this.isOrderByExtracts = true,
    this.showOnlyPaid = false,
  }) : super(key: key);

  final ExtractOrderItems? orderBy;
  final bool? isOrderByExtracts;
  final bool? showOnlyPaid;
  final BoletoListController boletoProvider;

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  @override
  Widget build(BuildContext context) {
    final boletos = widget.boletoProvider.boletos;

    List<BoletoModel> items;
    items = [...boletos];

    if (widget.showOnlyPaid ?? false) {
      items = widget.boletoProvider.paidBoletos;
    }
    if ((widget.isOrderByExtracts ?? true) && widget.orderBy != null) {
      items = widget.boletoProvider.orderBoletos(items, defineOrder: widget.orderBy);
    }

    return Column(
      children: items.map(
        (e) => BoletoTileWidget(
          data: e,
          boletoProvider: widget.boletoProvider,
        ),
      ).toList(),
    );
  }
}
