import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/divider_vertical/divider_vertical_widget.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';

class SetLabelButtons extends StatelessWidget {
  const SetLabelButtons({ 
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    this.enablePrimaryColor = false,
  }) : super(key: key);

  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;
  final bool enablePrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.shape,
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: LabelButton(
              onPressed: primaryOnPressed,
              label: primaryLabel,
              style: enablePrimaryColor ? AppTextStyles.buttonPrimary : null,
            ),
          ),
          DividerVerticalWidget(),
          Expanded(
            child: LabelButton(
              onPressed: secondaryOnPressed,
              label: secondaryLabel,
            ),
          ),
        ],
      ),
    );
  }
}