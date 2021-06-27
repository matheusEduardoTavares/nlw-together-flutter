import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:payflow/modules/configs/configs_page.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/utils/controller_navigator.dart';
import 'package:payflow/shared/utils/routes_name.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ControllerTheme>(
      context,
    );

    final isDarkTheme = themeController.isDarkTheme;

    final colorBasedTheme = isDarkTheme ? Colors.white : Colors.black;

    return MaterialApp(
      navigatorKey: ControllerNavigator.navigator,
      title: 'Pay Flow',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.orange,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: colorBasedTheme,
          ),
        ),
      ),
      initialRoute: RoutesName.splash,
      routes: {
        RoutesName.home: (ctx) => HomePage(),
        RoutesName.login: (ctx) => LoginPage(),
        RoutesName.splash: (ctx) => SplashPage(),
        RoutesName.barcodeScanner: (ctx) => BarcodeScannerPage(),
        RoutesName.insertBoleto: (ctx) => InsertBoletoPage(),
        RoutesName.configs: (ctx) => ConfigsPage(),
      }
    );
  }
}