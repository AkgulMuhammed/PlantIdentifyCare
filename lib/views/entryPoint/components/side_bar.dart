import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_identify_care/constants/app_colors.dart';
import 'package:plant_identify_care/models/menu.dart';

import '../../../utils/rive_utils.dart';
import '../../auth/auth_screen.dart';
import 'info_card.dart';
import 'side_menu.dart';

class SideBar extends StatefulWidget {
  final Function(Menu) onMenuSelected;

  const SideBar({required this.onMenuSelected, Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Menu selectedSideMenu = sidebarMenus.first;
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    String userName = user?.displayName ?? 'Misafir';
    String userEmail = user?.email ?? '';
    if (userEmail.length > 16) {
      userEmail = userEmail.substring(0, 16) + "...";
    }
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InfoCard(
                name: userName,
                mail: userEmail,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 16, right: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Gezinti".toUpperCase(),
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              ...sidebarMenus
                  .map((menu) => SideMenu(
                        menu: menu,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);

                          setState(() {
                            selectedSideMenu = menu;
                          });

                          widget.onMenuSelected(menu);
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 16, right: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Bitki Sağlığı ".toUpperCase(),
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              ...sidebarMenus2
                  .map((menu) => SideMenu(
                        menu: menu,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);

                          setState(() {
                            selectedSideMenu = menu;
                          });

                          widget.onMenuSelected(menu);
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AuthScreen())));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: kPrimaryColor,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Çıkış yap'),
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Plant Identify Care',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'OUA Bootcamp Projesidir\nCoded By Muhammed Akgül',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
