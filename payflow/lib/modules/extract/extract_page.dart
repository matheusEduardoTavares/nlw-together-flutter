import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_order_items.dart';
import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_widget.dart';
import 'package:provider/provider.dart';

class ExtractPage extends StatefulWidget {
  ExtractPage({
    Key? key,
    required this.boletoProvider,
  }) : super(key: key);

  final BoletoListController boletoProvider;

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  var _extractOrder = ExtractOrderItems.none;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ControllerTheme>(context);
    final isDarkTheme = themeController.isDarkTheme;

    if (widget.boletoProvider.paidBoletos.isEmpty) {
      return Center(
        child: Text(
          'Não há nenhum boleto pago', 
          style: AppTextStyles.getStyleBasedTheme(
            style: AppTextStyles.titleBoldHeading,
            isDarkTheme: isDarkTheme,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
            child: Row(
              children: [
                Text(
                  'Meus extratos', 
                  style: AppTextStyles.getStyleBasedTheme(
                    style: AppTextStyles.titleBoldHeading,
                    isDarkTheme: isDarkTheme,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: _extractOrder == ExtractOrderItems.dueDate ? MaterialStateProperty.all(
                        Colors.green,
                      ) : null,
                    ),
                    child: const Text('Ordenar por data'),
                    onPressed: () {
                      if (_extractOrder == ExtractOrderItems.dueDate) {
                        setState(() {
                          _extractOrder = ExtractOrderItems.none;
                        });
                      }
                      else {
                        setState(() {
                          _extractOrder = ExtractOrderItems.dueDate;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Ordenar por valor'),
                    style: ButtonStyle(
                      backgroundColor: _extractOrder == ExtractOrderItems.value ? MaterialStateProperty.all(
                        Colors.green,
                      ) : null,
                    ),
                    onPressed: () {
                      if (_extractOrder == ExtractOrderItems.value) {
                        setState(() {
                          _extractOrder = ExtractOrderItems.none;
                        });
                      }
                      else {
                        setState(() {
                          _extractOrder = ExtractOrderItems.value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(
              color: AppColors.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BoletoListWidget(
              key: UniqueKey(),
              orderBy: _extractOrder,
              showOnlyPaid: true,
              boletoProvider: widget.boletoProvider,
            ),
          )
        ],
      ),
    );
  }
}
