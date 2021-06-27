import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/determine_paid_buttons/determine_paid_buttons_controller.dart';

class DeterminePaidButtons extends StatefulWidget {
  const DeterminePaidButtons({ 
    Key? key,
    required this.boleto,
    required this.boletoProvider,
  }) : super(key: key);

  final BoletoModel boleto;
  final BoletoListController boletoProvider;

  @override
  _DeterminePaidButtonsState createState() => _DeterminePaidButtonsState();
}

class _DeterminePaidButtonsState extends State<DeterminePaidButtons> {
  var _isUpdating = false;
  final _controller = DeterminePaidButtonsController();
  final _defaultButtonHeight = 55.0;

  Future<void> _updateBoleto(bool isPaid) async {
    setState(() {
      _isUpdating = true;
    });

    try {
      await _controller.setIsPaidBoleto(isPaid, widget.boleto, widget.boletoProvider);
      await showGeneralDialog(
        context: context, 
        pageBuilder: (_, __, ___) => AlertDialog(
          title: const Text('Sucesso'),
          content: Text('O boleto ${widget.boleto.name} ${isPaid ? 'foi pago' : 'não foi pago'} !!'),
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
    catch (_) {}

    if (mounted) {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isUpdating ? Center(
      child: CircularProgressIndicator(),
    ) : Row(
      children: [
        Expanded(
          child: Container(
            height: _defaultButtonHeight,
            child: ElevatedButton(
              child: const Text('Ainda não'),
              onPressed: () async {
                _updateBoleto(false);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AppColors.shape,
                ),
                foregroundColor: MaterialStateProperty.all(
                  AppColors.heading,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Container(
            height: _defaultButtonHeight,
            child: ElevatedButton(
              child: const Text('Sim'),
              onPressed: () async {
                _updateBoleto(true);
              },
            ),
          ),
        ),
      ],
    );
  }
}