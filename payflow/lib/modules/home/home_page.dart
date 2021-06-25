import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final _pages = [
    Container(
      child: MeusBoletosPage(
        
      ),
    ),
    Container(
      color: Colors.blue,
    ),
  ];

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
                      text: 'Gabul', style: AppTextStyles.titleBoldBackground,
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                "Mantenha as suas contas em dia",
                style: AppTextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                    5.0,
                  )
                ),
              ),
            ),
          ),
        ),
      ),
      body: _pages[homeController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  homeController.setPage(0);
                });
              },
              icon: Icon(
                Icons.home,
                color: AppColors.primary,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/insert_boleto'
                );
                // Navigator.pushNamed(
                //   context,
                //   '/barcode_scanner'
                // );
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
                  homeController.setPage(1);
                });
              },
              icon: Icon(
                Icons.description_outlined,
                color: AppColors.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}