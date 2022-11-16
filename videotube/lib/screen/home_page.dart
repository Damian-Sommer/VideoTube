import 'package:flutter/cupertino.dart';
import 'package:videotube/model/api_handler.dart';
import 'package:videotube/util/video_list.dart';

import '../model/channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Channel channel;/*
  _HomePageState(){
    _initChannel();
  }*/
  @override
  void initState(){
    super.initState();
    _initChannel();
  }
  _initChannel() async{
    APIHandler apiHandler = APIHandler.instance;
    Channel channel = await apiHandler.fetchChannel(channelId: "UCykDwCvT2mj6R6w8Y5uPd5Q");
    setState(() {
      this.channel = channel;
    });
  }/*
  void setChannel()async{
    channel = await _initChannel();
  }*/
  @override
  Widget build(BuildContext context) {
    return VideoList(channel: channel);
  }

}