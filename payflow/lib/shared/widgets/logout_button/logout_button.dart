import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/controller_navigator.dart';
import 'package:payflow/shared/utils/routes_name.dart';
import 'package:payflow/shared/widgets/button_loading/button_loading.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({ 
    Key? key,
    this.isProcessingLogout = false,
    this.endProcessingLogout,
    this.startProcessingLogout,
  }) : super(key: key);

  final bool isProcessingLogout;
  final VoidCallback? startProcessingLogout;
  final VoidCallback? endProcessingLogout;

  @override
  Widget build(BuildContext context) {
    return ButtonLoading(
      child: Text(
        'Sair',
        style: AppTextStyles.buttonBackground,
      ),
      isLoading: isProcessingLogout,
      onPressed: () async {
        startProcessingLogout?.call();
        try {
          final _googleSignIn = GoogleSignIn(
            scopes: [
              'email',
            ],
          );
          await _googleSignIn.signOut();
          final _authController = AuthController();
          await _authController.removeUser();
          ControllerNavigator.removeAllRoutesAndPushNew(
            RoutesName.login,
          );
        }
        catch (_) {
          showGeneralDialog(
            context: context, 
            pageBuilder: (_, __, ___) => AlertDialog(
              title: const Text('Erro'),
              content: const Text('Erro ao tentar sair'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );

          ///Só precisa setar para false o andamento aqui pois se der sucesso
          ///irá dar um pop na rota, logo, a variável local já será deletada
          endProcessingLogout?.call();
        }
      },
    );
  }
}