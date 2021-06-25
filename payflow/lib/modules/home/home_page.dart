import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/routes_name.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({ 
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = HomeController();
  final _boletoController = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152.0),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: 'Olá, ', style: AppTextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: '${widget.user.name}', 
                      style: AppTextStyles.titleBoldBackground,
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                'Mantenha as suas contas em dia',
                style: AppTextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.user.photoURL,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: [
        MeusBoletosPage(
          key: UniqueKey(),
        ),
        ExtractPage(
          key: UniqueKey(),
        ),
      ][_homeController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _homeController.setPage(0);
                });
              },
              icon: Icon(
                Icons.home,
                color: _homeController.currentPage == 0 ? 
                  AppColors.primary : AppColors.body,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  RoutesName.barcodeScanner,
                  arguments: _boletoController,
                );
                setState(() {});
              },
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _homeController.setPage(1);
                });
              },
              icon: Icon(
                Icons.description_outlined,
                color: _homeController.currentPage == 1 ? 
                  AppColors.primary : AppColors.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}