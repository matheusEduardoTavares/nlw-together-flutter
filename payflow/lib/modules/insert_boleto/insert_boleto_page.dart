import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/controller_navigator.dart';
import 'package:payflow/shared/utils/routes_name.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';
import 'package:provider/provider.dart';

class InsertBoletoPage extends StatefulWidget {
  InsertBoletoPage({ 
    Key? key,
  }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final _boletoController = InsertBoletoController();
  final _authController = AuthController();
  var _isLoadingRegister = false;

  final _dueDateInputTextController = MaskedTextController(
    mask: "00/00/0000"
  );

  final _moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$", 
    initialValue: 0, 
    decimalSeparator: ",",
  );

  final _barCodeInputTextController = TextEditingController();

  @override 
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final barcode = arguments != null ? arguments.toString() : null;

    if (barcode != null) {
      _barCodeInputTextController.text = barcode;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ControllerTheme>(context);
    final isDarkTheme = themeController.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Inserir boleto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
                child: Text(
                  'Preencha os dados do boleto',
                  style: AppTextStyles.getStyleBasedTheme(
                    style: AppTextStyles.titleBoldHeading,
                    isDarkTheme: isDarkTheme,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _boletoController.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        _boletoController.onChange(name: value);
                      },
                      validator: _boletoController.validateName,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                    ),
                    InputTextWidget(
                      controller: _dueDateInputTextController,
                      label: "Vencimento",
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        _boletoController.onChange(dueDate: value);
                      },
                      validator: _boletoController.validateVencimento,
                    ),
                    InputTextWidget(
                      controller: _moneyInputTextController,
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => _boletoController
                        .validateValor(_moneyInputTextController.numberValue),
                      onChanged: (value) {
                        _boletoController.onChange(
                          value: _moneyInputTextController.numberValue
                        );
                      },
                    ),
                    InputTextWidget(
                      controller: _barCodeInputTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      validator: _boletoController.validateCodigo,
                      onChanged: (value) {
                        _boletoController.onChange(barcode: value);
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        isLoading: _isLoadingRegister,
        enableSecondaryColor: true,
        primaryLabel: 'Cancelar',
        primaryOnPressed: () {
          Navigator.of(context).pop();
        },
        secondaryLabel: 'Cadastrar',
        secondaryOnPressed: () async {
          setState(() {
            _isLoadingRegister = true;
          });
          await _boletoController.createBankSlip();
          await _authController.currentUser(context);
          
          ControllerNavigator.removeAllRoutesAndPushNew(
            RoutesName.home,
          );
        },
      ),
    );
  }

  @override 
  void dispose() {
    _barCodeInputTextController.dispose();
    _dueDateInputTextController.dispose();
    _moneyInputTextController.dispose();

    super.dispose();
  }
}