import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payflow/app_widget.dart';
import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/utils/shared_preferences_instance.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesInstance.initializeInstance();
  final _isDarkTheme = SharedPreferencesInstance.instance!.getBool(
    ControllerTheme.key,
  );

  runApp(
    AppFirebase(
      isDarkTheme: _isDarkTheme,
    ),
  );
}

class AppFirebase extends StatelessWidget {
  AppFirebase({
    this.isDarkTheme,
  });

  final bool? isDarkTheme;

  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Material(
            child: Center(
              ///Como não há um `MaterialApp`, se não for 
              ///colocado a propriedade:
              ///```
              ///textDirection: TextDirection.ltr,
              ///```
              ///irá quebrar a aplicação
              child: const Text(
                'Não foi possível inicializar o Firebase',
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        }
        else if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<BoletoListController>(
            create: (ctx) => BoletoListController(),
            lazy: true,
            builder: (_ctx, _widget) {
              return ChangeNotifierProvider<ControllerTheme>(
                create: (_) => ControllerTheme(
                  isDarkTheme: isDarkTheme,
                ),
                builder: (_, __) => AppWidget(),
              );
            }
          );
        }

        return Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}