import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  InsertBoletoPage({ 
    Key? key,
    this.barcode,
  }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final _controller = InsertBoletoController();

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
  void initState() {
    super.initState();

    if (widget.barcode != null) {
      _barCodeInputTextController.text = widget.barcode!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
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
                  style: AppTextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        _controller.onChange(name: value);
                      },
                      validator: _controller.validateName,
                    ),
                    InputTextWidget(
                      controller: _dueDateInputTextController,
                      label: "Vencimento",
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        _controller.onChange(dueDate: value);
                      },
                      validator: _controller.validateVencimento,
                    ),
                    InputTextWidget(
                      controller: _moneyInputTextController,
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => _controller
                        .validateValor(_moneyInputTextController.numberValue),
                      onChanged: (value) {
                        _controller.onChange(
                          value: _moneyInputTextController.numberValue
                        );
                      },
                    ),
                    InputTextWidget(
                      controller: _barCodeInputTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      validator: _controller.validateCodigo,
                      onChanged: (value) {
                        _controller.onChange(barcode: value);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        enableSecondaryColor: true,
        primaryLabel: 'Cancelar',
        primaryOnPressed: () {
          Navigator.of(context).pop();
        },
        secondaryLabel: 'Cadastrar',
        secondaryOnPressed: () async {
          await _controller.createBankSlip();

          Navigator.of(context).pop();
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