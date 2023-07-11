import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plant_identify_care/constants/app_colors.dart';
import 'package:plant_identify_care/models/menu.dart';
import 'package:plant_identify_care/utils/rive_utils.dart';
import 'package:plant_identify_care/views/home/home_screen.dart';
import 'package:rive/rive.dart';
import 'components/btm_nav_item.dart';
import 'components/menu_btn.dart';
import 'components/side_bar.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  bool isSideBarOpen = false;

  Menu selectedBottonNav = bottomNavItems.first;
  Menu selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    setupAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void setupAnimation() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Stack buildBody() {
    return Stack(
      children: [
        buildSideBar(),
        buildTransform(),
        buildMenuButton(),
      ],
    );
  }

  AnimatedPositioned buildSideBar() {
    return AnimatedPositioned(
      width: 288,
      height: MediaQuery.of(context).size.height,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      left: isSideBarOpen ? 0 : -288,
      top: 0,
      child: const SideBar(),
    );
  }

  Transform buildTransform() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(1 * animation.value - 30 * (animation.value) * pi / 180),
      child: Transform.translate(
        offset: Offset(animation.value * 265, 0),
        child: Transform.scale(
          scale: scalAnimation.value,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
            child: HomeScreen(isSideBarOpen: isSideBarOpen),
          ),
        ),
      ),
    );
  }

  AnimatedPositioned buildMenuButton() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      left: isSideBarOpen ? 220 : 0,
      top: 16,
      child: MenuBtn(
        press: handleMenuButtonPress,
        riveOnInit: handleRiveOnInit,
      ),
    );
  }

  void handleMenuButtonPress() {
    isMenuOpenInput.value = !isMenuOpenInput.value;

    if (_animationController.value == 0) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    setState(
      () {
        isSideBarOpen = !isSideBarOpen;
      },
    );
  }

  void handleRiveOnInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine");

    artboard.addController(controller!);

    isMenuOpenInput = controller.findInput<bool>("isOpen") as SMIBool;
    isMenuOpenInput.value = true;
  }

  Widget buildBottomNavigationBar() {
    return Transform.translate(
      offset: Offset(0, 100 * animation.value),
      child: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.3),
                offset: const Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buildBottomNavItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildBottomNavItems() {
    return List.generate(
      bottomNavItems.length,
      (index) {
        Menu navBar = bottomNavItems[index];
        return BtmNavItem(
          navBar: navBar,
          press: () {
            RiveUtils.chnageSMIBoolState(navBar.rive.status!);
            updateSelectedBtmNav(navBar);
            //Burada Bu Yöntemi Kullanamadım çünkü bu şekilde navbar çalışmaz :)
            //Navigator.pushNamed(context, navBar.routeName);
          },
          riveOnInit: (artboard) {
            navBar.rive.status = RiveUtils.getRiveInput(artboard,
                stateMachineName: navBar.rive.stateMachineName);
          },
          selectedNav: selectedBottonNav,
        );
      },
    );
  }
}
