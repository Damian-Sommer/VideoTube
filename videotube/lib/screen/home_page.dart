import 'package:flutter/cupertino.dart';

import '../util/video_list.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);


  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return const VideoList();
  }
}