import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/utils/routes_name.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.orange,
      ),
      initialRoute: RoutesName.splash,
      routes: {
        RoutesName.home: (ctx) => HomePage(
          user: ModalRoute.of(ctx)!.settings.arguments as UserModel
        ),
        RoutesName.login: (ctx) => LoginPage(),
        RoutesName.splash: (ctx) => SplashPage(),
        RoutesName.barcodeScanner: (ctx) => BarcodeScannerPage(),
        RoutesName.insertBoleto: (ctx) => InsertBoletoPage(),
      }
    );
  }
}