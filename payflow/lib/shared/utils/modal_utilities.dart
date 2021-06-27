import 'package:flutter/material.dart';
import 'package:payflow/shared/utils/controller_navigator.dart';

abstract class ModalUtilities {

  static Future<void> showSuccessModal({required final String content}) async {
    final context = ControllerNavigator.navigator.currentState!.overlay!.context;
    await showGeneralDialog(
      context: context, 
      pageBuilder: (_, __, ___) => AlertDialog(
        title: const Text('Sucesso'),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: const Text('OK'),
          ),
        ],
      )
    );
    Navigator.of(context).pop();
  }

  static Future<void> showErrorModal({required final String content}) async {
    final context = ControllerNavigator.navigator.currentState!.overlay!.context;
    await showGeneralDialog(
      context: context, 
      pageBuilder: (_, __, ___) => AlertDialog(
        title: const Text('Erro'),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: const Text('OK'),
          ),
        ],
      )
    );
    Navigator.of(context).pop();
  }
}