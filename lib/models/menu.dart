import 'package:flutter/material.dart';
import 'package:plant_identify_care/models/rive_model.dart';
import 'package:plant_identify_care/views/home/home_screen.dart';
import 'package:plant_identify_care/views/plantDoctor/plant_doctor_screen.dart';
import 'package:plant_identify_care/views/plant_heal.dart';
import 'package:plant_identify_care/views/profile_page.dart';
import 'package:plant_identify_care/views/search_screen.dart';

class Menu {
  final String title;
  final RiveModel rive;
  final Widget page;

  Menu({required this.title, required this.rive, required this.page});
}

List<Menu> sidebarMenus = [
  Menu(
    title: "Home",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
    page: const HomeScreen(isSideBarOpen: false),
  ),
  Menu(
    title: "Search",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity"),
    page: const SearchScreen(),
  ),
  Menu(
    title: "Profile",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
    page: const ProfilePage(),
  ),
];

List<Menu> sidebarMenus2 = [
  Menu(
    title: "Bitki Doktoru",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "CHAT",
        stateMachineName: "CHAT_Interactivity"),
    page: const PlantDoctor(),
  ),
  Menu(
    title: "History",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "TIMER",
        stateMachineName: "TIMER_Interactivity"),
    page: const Center(child: Text('History Page')),
  ),
  Menu(
    title: "Notifications",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "BELL",
        stateMachineName: "BELL_Interactivity"),
    page: const Center(child: Text('Notifications Page')),
  ),
];

List<Menu> bottomNavItems = [
  Menu(
    title: "Home",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
    page: const HomeScreen(isSideBarOpen: false),
  ),
  Menu(
    title: "Search",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity"),
    page: const SearchScreen(),
  ),
  Menu(
    title: "Add",
    rive: RiveModel(
        src: "assets/RiveAssets/add_icon_demo.riv",
        artboard: "New Artboard",
        stateMachineName: "State Machine 1"),
    page: const PlantHeal(),
  ),
  Menu(
    title: "Profile",
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
    page: const ProfilePage(),
  ),
];
