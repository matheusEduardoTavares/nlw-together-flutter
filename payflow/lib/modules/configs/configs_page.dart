import 'package:flutter/material.dart';
import 'package:payflow/modules/configs/configs_controller.dart';
import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/widgets/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class ConfigsPage extends StatefulWidget {
  const ConfigsPage({ 
    Key? key,
  }) : super(key: key);

  @override
  _ConfigsPageState createState() => _ConfigsPageState();
}

class _ConfigsPageState extends State<ConfigsPage> {
  final _controller = ConfigsController();

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ControllerTheme>(context);
    final isDarkTheme = themeController.isDarkTheme;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Configurações',
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Tema escuro: '),
                  Switch(
                    value: isDarkTheme,
                    onChanged: (value) {
                      _controller.changeTheme(value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}