// ignore: must_be_immutable
import 'package:flutter/material.dart';

import 'model/page.dart';

class PageContainer extends StatefulWidget {
  List<PageModel> pages = <PageModel>[];
  var screens = [];

  PageContainer({
    Key? key,
    required this.pages,
    required this.screens,
  }) : super(key: key);

  @override
  _PageContainerState createState() =>
      // ignore: no_logic_in_create_state
      _PageContainerState(pages, screens);
}

class _PageContainerState extends State<PageContainer> {
  List<PageModel> pages = <PageModel>[];
  var screens = [];
  int currentIndex = 0;

  _PageContainerState(this.pages, this.screens);

  String getCurrentPageName() {
    return pages[currentIndex].getPageName.toString();
  }

  List<BottomNavigationBarItem> getListOfNavigationBarItems() {
    List<BottomNavigationBarItem> items = [];
    for (int i = 0; i < pages.length; i++) {
      items.add(BottomNavigationBarItem(
          icon: pages[i].getPageIcon, label: pages[i].getPageName));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45.0),
        child: AppBarContent(),
      ),
      /*AppBar(
        title: Text("he"),
        //https://api.flutter.dev/flutter/widgets/PreferredSize-class.html#:~:text=A%20widget%20with%20a%20preferred,their%20children%20implement%20that%20interface.
      )*/
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
              iconSize: 40,
              type: BottomNavigationBarType.fixed,
              items: getListOfNavigationBarItems().toList(),
              selectedItemColor: const Color(0xffDFDDDD),
              unselectedItemColor: const Color(0xffDFDDDD),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: const Color(0xFF010205),
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() => currentIndex = index);
              }),
        ),
      ),
    );
  }
}

class AppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: const <Widget>[
              ImageIcon(
                AssetImage("assets/icons/vitu.png"),
                color: Color(0xFFFF0000),
                size: 40,
              ),
              Text(
                ' ViTu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
