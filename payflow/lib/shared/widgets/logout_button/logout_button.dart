import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/controller_navigator.dart';
import 'package:payflow/shared/utils/modal_utilities.dart';
import 'package:payflow/shared/utils/routes_name.dart';
import 'package:payflow/shared/widgets/loading_button/loading_button.dart';

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
    return LoadingButton(
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
          await ModalUtilities.showErrorModal(
            content: 'Erro ao tentar sair',
          );

          ///Só precisa setar para false o andamento aqui pois se der sucesso
          ///irá dar um pop na rota, logo, a variável local já será deletada
          endProcessingLogout?.call();
        }
      },
    );
  }
}