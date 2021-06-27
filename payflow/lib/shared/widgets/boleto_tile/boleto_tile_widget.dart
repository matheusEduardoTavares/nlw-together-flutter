import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/determine_paid_buttons/determine_paid_buttons.dart';
import 'package:provider/provider.dart';

class BoletoTileWidget extends StatelessWidget {
  final BoletoModel data;

  const BoletoTileWidget({
    Key? key, 
    required this.data,
    required this.boletoProvider,
  }) : super(key: key);

  final BoletoListController boletoProvider;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ControllerTheme>(
      context,
    );

    final isDarkTheme = themeController.isDarkTheme;

    final _textStyle = AppTextStyles.getStyleBasedTheme(
      style: AppTextStyles.titleHeading,
      isDarkTheme: isDarkTheme,
    );

    final _titleStyle = AppTextStyles.getStyleBasedTheme(
      style: AppTextStyles.titleBoldHeading,
      isDarkTheme: isDarkTheme,
    );

    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          showModalBottomSheet(
            context: context, 
            builder: (_) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Center(
                    child: Container(
                      color: AppColors.input,
                      width: 43,
                      height: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(78.0, 38.0, 78.0, 0.0),
                  child: Text.rich(
                    TextSpan(
                      style: _textStyle,
                      text: 'O boleto ',
                      children: [
                        TextSpan(
                          text: data.name,
                          style: _titleStyle,
                        ),
                        TextSpan(
                          text: ' no valor de R\$ ',
                          style: _textStyle,
                        ),
                        TextSpan(
                          text: data.value?.toString() ?? ' -',
                          style: _titleStyle,
                        ),
                        TextSpan(
                          text: ' foi pago ?',
                          style: _textStyle,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 24.0,
                  ),
                  child: DeterminePaidButtons(
                    boleto: data,
                    boletoProvider: boletoProvider,
                  ),
                ),
                Divider(
                  height: 1.0,
                  color: AppColors.input,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.delete_outline_outlined),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      AppColors.delete,
                    )
                  ),
                  label: const Text('Deletar boleto'),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
        title: Text(
          data.name!,
          style: AppTextStyles.getStyleBasedTheme(
            style: AppTextStyles.titleListTile,
            isDarkTheme: isDarkTheme,
          ),
        ),
        subtitle: Text(
          'Vence em ${data.dueDate}',
          style: AppTextStyles.getStyleBasedTheme(
            style: AppTextStyles.captionBody,
            isDarkTheme: isDarkTheme,
          ),
        ),
        trailing: Text.rich(TextSpan(
          text: 'R\$ ',
          style: AppTextStyles.getStyleBasedTheme(
            style: AppTextStyles.trailingRegular,
            isDarkTheme: isDarkTheme,
          ),
          children: [
            TextSpan(
              text: '${data.value!.toStringAsFixed(2)}',
              style: AppTextStyles.getStyleBasedTheme(
                style: AppTextStyles.trailingBold,
                isDarkTheme: isDarkTheme,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
