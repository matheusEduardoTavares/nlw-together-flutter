import  'package:flutter/material.dart';
import  'package:google_fonts/google_fonts.dart';
import  'package:payflow/shared/themes/app_colors.dart';

///OBS: Uma classe que apenas contém 
///atributos / métodos estáticos (no
///caso só atributos), deve ser 
///abstrata, afinal, não faz
///sentido instanciá-la
///Referência:
///https://github.com/rocketseat-education/nlw-06-flutter/tree/textstyles
///Esta referência está mais atualizada:
///https://github.com/rocketseat-education/nlw-06-flutter/blob/aula04/lib/shared/themes/app_text_styles.dart
abstract class AppTextStyles {
  static final input = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.input,
  );
  static final titleHome = GoogleFonts.lexendDeca(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final titleRegular = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.background,
  );
  static final titleHeading = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  static final titleBoldHeading = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final titleBoldBackground = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
  );
  static final titleListTile = GoogleFonts.lexendDeca(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final trailingRegular = GoogleFonts.lexendDeca(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.heading,
  );
  static final trailingBold = GoogleFonts.lexendDeca(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final buttonPrimary = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );
  static final buttonHeading = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.heading,
  );
  static final buttonGrey = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  static final buttonBackground = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.background,
  );
  static final buttonBoldPrimary = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );
  static final buttonBoldHeading = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.heading,
  );
  static final buttonBoldGrey = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.grey,
  );
  static final buttonBoldBackground = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.background,
  );
  static final captionBackground = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.background,
  );
  static final captionShape = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.shape,
  );
  static final captionBody = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.body,
  );
  static final captionBoldBackground = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
  );
  static final captionBoldShape = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.shape,
  );
  static final captionBoldBody = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.body,
  );
  static final drawerHeader = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.title,
  );

  static TextStyle getStyleBasedTheme({
    required TextStyle style, 
    required bool isDarkTheme,
    Color? colorToReturnIfIsDarkTheme,
    Color? colorToReturnIfIsLightTheme,
  }) {
    if (isDarkTheme) {
      return style.copyWith(
        color: colorToReturnIfIsDarkTheme ?? Colors.white,
      );
    }
    else if (colorToReturnIfIsLightTheme != null) {
      return style.copyWith(
        color: colorToReturnIfIsLightTheme,
      );
    }

    return style;
  }
}