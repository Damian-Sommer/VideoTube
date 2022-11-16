import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videotube/model/api_handler.dart';

import '../model/channel.dart';

class HomePage extends StatefulWidget {

   HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Channel channel;
  late Future _getChannel;
  _HomePageState(){
    _getChannel = _initChannels();
  }

  _initChannels() async{
    APIHandler apiHandler = APIHandler.instance;
    return await apiHandler
        .fetchChannel(channelId: "UCykDwCvT2mj6R6w8Y5uPd5Q")
        .then((value) => channel = value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getChannel,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return const Text("hello", style: TextStyle(color: Color(0xffffffff)));
        }else{
          return const Text("hello");
        }
      },
    );
  }
}
