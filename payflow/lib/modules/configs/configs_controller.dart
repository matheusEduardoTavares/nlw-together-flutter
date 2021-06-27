import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/utils/controller_navigator.dart';
import 'package:payflow/shared/utils/shared_preferences_instance.dart';
import 'package:provider/provider.dart';

class ConfigsController {
  void changeTheme(bool isDarkTheme) {
    final instance = SharedPreferencesInstance.instance!;

    Provider.of<ControllerTheme>(
      ControllerNavigator.navigator.currentState!.overlay!.context,
      listen: false,
    ).setDarkTheme = isDarkTheme;

    instance.setBool(ControllerTheme.key, isDarkTheme);
  }
}