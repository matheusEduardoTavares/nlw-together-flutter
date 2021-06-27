import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/controller_theme.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/routes_name.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({ 
    Key? key,
    required this.boletoProvider,
  }) : super(key: key);

  final BoletoListController boletoProvider;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = HomeController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  final themeController = Provider.of<ControllerTheme>(context);
  final isDarkTheme = themeController.isDarkTheme;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152.0),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () { _scaffoldKey.currentState!.openDrawer(); },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                color: AppColors.getColorBasedTheme(
                  isDarkTheme,
                ),
              ),
              title: Text.rich(
                TextSpan(
                  text: 'Olá, ', style: AppTextStyles.getStyleBasedTheme(
                    style: AppTextStyles.titleRegular,
                    isDarkTheme: isDarkTheme,
                    colorToReturnIfIsLightTheme: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '${AuthController.userModel!.name}', 
                      style: AppTextStyles.getStyleBasedTheme(
                        style: AppTextStyles.titleBoldBackground,
                        isDarkTheme: isDarkTheme,
                        colorToReturnIfIsLightTheme: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                'Mantenha as suas contas em dia',
                style: AppTextStyles.getStyleBasedTheme(
                  style: AppTextStyles.captionShape,
                  isDarkTheme: isDarkTheme,
                  colorToReturnIfIsLightTheme: Colors.black,
                ),
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      AuthController.userModel!.photoURL,
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
          boletoProvider: widget.boletoProvider,
        ),
        ExtractPage(
          key: UniqueKey(),
          boletoProvider: widget.boletoProvider,
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