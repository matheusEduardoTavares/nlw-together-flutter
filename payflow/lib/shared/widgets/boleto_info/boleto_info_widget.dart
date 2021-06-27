import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

class BoletoInfoWidget extends StatefulWidget {
  BoletoInfoWidget({
    Key? key,
    required this.boletoProvider,
  }) : super(key: key);

  final BoletoListController boletoProvider;

  @override
  _BoletoInfoWidgetState createState() => _BoletoInfoWidgetState();
}

class _BoletoInfoWidgetState extends State<BoletoInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary, 
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                AppImages.logomini,
                height: 34,
                width: 56,
                color: AppColors.background,
              ),
              Container(
                width: 1,
                height: 32,
                color: AppColors.background,
              ),
              Text.rich(
                TextSpan(
                  text: 'Você tem ',
                  style: AppTextStyles.captionBackground,
                  children: [
                    TextSpan(
                      text: '${widget.boletoProvider.notPaidBoletos.length} boletos\n',
                      style: AppTextStyles.captionBoldBackground,
                    ),
                    TextSpan(
                      text: 'cadastrados para pagar',
                      style: AppTextStyles.captionBackground,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
