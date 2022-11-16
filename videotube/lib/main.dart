import 'package:flutter/material.dart';
import 'package:videotube/screen/home_page.dart';
import 'package:videotube/screen/loading_page.dart';

import 'model/api_handler.dart';
import 'model/channel.dart';
import 'model/page.dart';
import 'page_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        /*
        Greeper: flutter color hex opacity
         */
        scaffoldBackgroundColor: const Color(0xFF02040A),
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageContainer containerWidget;
  static List screens = [
    HomePage(),
    HomePage(),
    HomePage(),
  ];
  List<PageModel> pageList = <PageModel>[];


  _MainPageState() {
    //setScreens();
    pageList.add(PageModel(
        id: 0,
        name: "Home",
        icon: const ImageIcon(AssetImage("assets/icons/home.png")),
        color: const Color(0xffDFDDDD)));
    pageList.add(PageModel(
        id: 1,
        name: "Search",
        icon: const ImageIcon(AssetImage("assets/icons/search.png")),
        color: const Color(0xffDFDDDD)));
    pageList.add(PageModel(
        id: 2,
        name: "Settings",
        icon: const ImageIcon(AssetImage("assets/icons/search.png")),
        color: const Color(0xffDFDDDD)));
    containerWidget = PageContainer(pages: pageList, screens: screens);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: containerWidget,
    );
  }
}
