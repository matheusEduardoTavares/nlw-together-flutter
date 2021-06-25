import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/routes_name.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({ 
    Key? key,
   }) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final _controller = BarcodeScannerController();

  @override 
  void initState() {
    super.initState();

    _controller.getAvailableCameras();

    _controller.statusNotifier.addListener(() {
      if (_controller.status.hasBarcode) {
        Navigator.of(context).pushReplacementNamed(
          RoutesName.insertBoleto,
          arguments: _controller.status.barcode
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: _controller.statusNotifier, 
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  color: Colors.blue,
                  child: _controller.cameraController!.buildPreview(),
                );
              }
              return Container();
            }
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                centerTitle: true,
                title: Text(
                  'Escaneie o código de barras do boleto',
                  style: AppTextStyles.buttonBackground,
                ),
                leading: BackButton(
                  color: AppColors.background,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                primaryLabel: 'Inserir código do boleto',
                primaryOnPressed: () {
                  _controller.status = BarcodeScannerStatus.error("Error");
                },
                secondaryLabel: 'Adicionar da galeria',
                secondaryOnPressed: _controller.scanWithImagePicker,
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: _controller.statusNotifier, 
            builder: (_, status, __) {
              if (status.hasError) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: BottomSheetWidget(
                    title: 'Não foi possível identificar um código de barras.',
                    subtitle: 'Tente escanear novamente ou digite o código do seu boleto.',
                    primaryLabel: 'Escanear novamente',
                    primaryOnPressed: () {
                      _controller.scanWithCamera();
                    },
                    secondaryLabel: 'Digitar código',
                    secondaryOnPressed: () {
                      Navigator.of(context).pushNamed(
                        RoutesName.insertBoleto,
                      );
                    },
                  ),
                );
              }
              return Container();
            }
          ),
        ],
      ),
    );
  }

  @override 
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}