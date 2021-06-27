import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_or_update_boleto/insert_or_update_boleto_controller.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/controller_navigator.dart';
import 'package:payflow/shared/utils/routes_name.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';
import 'package:provider/provider.dart';

class InsertOrUpdateBoletoPage extends StatefulWidget {
  InsertOrUpdateBoletoPage({ 
    Key? key,
    required this.boletoProvider,
  }) : super(key: key);

  final BoletoListController boletoProvider;

  @override
  _InsertOrUpdateBoletoPageState createState() => _InsertOrUpdateBoletoPageState();
}

class _InsertOrUpdateBoletoPageState extends State<InsertOrUpdateBoletoPage> {
  final _boletoController = InsertOrUpdateBoletoController();
  final _authController = AuthController();
  var _isLoadingRegister = false;
  final _formKey = GlobalKey<FormState>();
  bool? _isUpdate;
  BoletoModel? _boleto;

  var _dueDateInputTextController = MaskedTextController(
    mask: "00/00/0000"
  );

  var _moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$", 
    initialValue: 0, 
    decimalSeparator: ",",
  );

  var _barCodeInputTextController = TextEditingController();
  var _nameController = TextEditingController();

  @override 
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final barcode = arguments['barcode'];
    _isUpdate = arguments['isUpdate'];
    _boleto = arguments['boleto'];

    if (barcode != null) {
      _barCodeInputTextController.text = barcode;
      _boletoController.onChange(barcode: barcode);
    }
    if (_isUpdate! && _boleto != null) {
      setState(() {
        _dueDateInputTextController = MaskedTextController(
          mask: "00/00/0000",
          text: _boleto!.dueDate,
        );
        _moneyInputTextController = MoneyMaskedTextController(
          leftSymbol: "R\$", 
          initialValue: _boleto!.value!, 
          decimalSeparator: ",",
        );
        _barCodeInputTextController = TextEditingController(
          text: _boleto!.barcode,
        );
        _nameController = TextEditingController(
          text: _boleto!.name,
        );

        _boletoController.onChange(dueDate: _boleto!.dueDate);
        _boletoController.onChange(value: _boleto!.value);
        _boletoController.onChange(barcode: _boleto!.barcode);
        _boletoController.onChange(name: _boleto!.name);
      });
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
        title: Text('${_isUpdate! ? 'Atualizar' : 'Inserir'} boleto'),
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
                  '${_isUpdate! ? 'Atualize' : 'Preencha'} os dados do boleto',
                  style: AppTextStyles.getStyleBasedTheme(
                    style: AppTextStyles.titleBoldHeading,
                    isDarkTheme: isDarkTheme,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      controller: _nameController,
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
        secondaryLabel: _isUpdate! ? 'Atualizar' : 'Cadastrar',
        secondaryOnPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              setState(() {
                _isLoadingRegister = true;
              });
              if (!(_isUpdate!)) {
                await _boletoController.createBankSlip(widget.boletoProvider);
              }
              else {
                final updatedBoleto = _boleto!.copyWith(
                  barcode: _barCodeInputTextController.value.text,
                  dueDate: _dueDateInputTextController.value.text,
                  name: _nameController.value.text,
                  value: _moneyInputTextController.numberValue,
                );
                print(updatedBoleto);
                await _boletoController.updateBankSlip(widget.boletoProvider, updatedBoleto);
              }
              await _authController.currentUser(context);
              ControllerNavigator.removeAllRoutesAndPushNew(
                RoutesName.home,
              );
            }
            catch (_) {
              setState(() {
                _isLoadingRegister = false;
              });
            }
          }
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