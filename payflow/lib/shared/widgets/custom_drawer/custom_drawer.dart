import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/utils/routes_drawer.dart';

class CustomDrawer extends StatelessWidget {
  static var _selectedIndex = 0;

  @override 
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Image.asset(
              AppImages.drawerLogo,
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: RoutesDrawer.items.length,
                itemBuilder: (_, index) => Column(
                  children: [
                    Card(
                      elevation: 5.0,
                      child: ListTile(
                        selected: _selectedIndex == index,
                        leading: RoutesDrawer.items[index].leading,
                        title: Text(RoutesDrawer.items[index].title),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                            RoutesDrawer.items[index].routeName,
                            arguments: RoutesDrawer.items[index].arguments,
                          );

                          _selectedIndex = index;
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}