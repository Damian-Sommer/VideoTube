import 'package:flutter/cupertino.dart';
import 'package:videotube/model/api_handler.dart';
import 'package:videotube/util/video_list.dart';

import '../model/channel.dart';

class HomePage extends StatefulWidget {
   Channel channel;

   HomePage({Key? key, required this.channel}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  @override
  void initState() {
    super.initState();
  }

  /*
  void setChannel()async{
    channel = await _initChannel();
  }*/
  @override
  Widget build(BuildContext context) {
    return VideoList(channel: widget.channel);
  }
}
