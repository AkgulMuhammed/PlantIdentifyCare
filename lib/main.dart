import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plant_identify_care/constants/app_colors.dart';
import 'package:plant_identify_care/views/entryPoint/entry_point.dart';
import 'package:plant_identify_care/views/plantDoctor/plant_doctor_screen.dart';


Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Identify Care',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),

      initialRoute: '/',
       routes: {
        '/': (context) => const EntryPoint(),
        '/search': (context) => const Scaffold(body: Center(child: Text('SearchPage'))),
        '/favorites': (context) => const Scaffold(body: Center(child: Text('FavoritesPage'))),
        '/help': (context) => const PlantDoctor(),
        '/history': (context) => const Scaffold(body: Center(child: Text('HistoryPage'))),
        '/notifications': (context) => const Scaffold(body: Center(child: Text('NotificationsPage'))),
        '/timer': (context) => const Scaffold(body: Center(child: Text('TimerPage'))),
        '/notification': (context) => const Scaffold(body: Center(child: Text('NotificationPage'))),
        '/profile': (context) => const Scaffold(body: Center(child: Text('ProfilePage'))),
      },
    );
  }
}
/*
Burası Tüm sayfalar oluşturulduğunda kullanacam

 routes: {
        '/': (context) => const EntryPoint(),
        '/search': (context) => SearchPage(),
        '/favorites': (context) => FavoritesPage(),
        '/help': (context) => const PlantDoctor(),
        '/history': (context) => HistoryPage(),
        '/notifications': (context) => NotificationsPage(),
        '/timer': (context) => TimerPage(),
        '/notification': (context) => NotificationPage(),
        '/profile': (context) => ProfilePage(),
      }, */