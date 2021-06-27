import 'package:flutter/material.dart';
import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_widget.dart';
import 'package:provider/provider.dart';

class ExtractPage extends StatefulWidget {
  ExtractPage({
    Key? key
  }) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ControllerTheme>(context);
    final isDarkTheme = themeController.isDarkTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(
              color: AppColors.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BoletoListWidget(
              key: UniqueKey(),
            ),
          )
        ],
      ),
    );
  }
}
