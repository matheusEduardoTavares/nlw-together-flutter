import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/utils/routes_drawer.dart';
import 'package:payflow/shared/widgets/logout_button/logout_button.dart';

class CustomDrawer extends StatefulWidget {
  static var _selectedIndex = 0;

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var _isProcessingLogout = false;

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
                        selected: CustomDrawer._selectedIndex == index,
                        leading: RoutesDrawer.items[index].leading,
                        title: Text(RoutesDrawer.items[index].title),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                            RoutesDrawer.items[index].routeName,
                            arguments: RoutesDrawer.items[index].arguments,
                          );

                          CustomDrawer._selectedIndex = index;
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
            LogoutButton(
              isProcessingLogout: _isProcessingLogout,
              startProcessingLogout: () => setState(() => _isProcessingLogout = true),
              endProcessingLogout: () => setState(() => _isProcessingLogout = false),
            ),
          ],
        ),
      ),
    );
  }
}