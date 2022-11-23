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
  late Channel channel = Channel(
      id: '1',
      title: 'default',
      profilePictureUrl: '',
      subscriberCount: '10',
      videoCount: '10',
      uploadPlaylistId: '100000',
      videos: []);

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    APIHandler apiHandler = APIHandler.instance;
    Channel channel =
        await apiHandler.fetchChannel(channelId: "UCsXVk37bltHxD1rDPwtNM8Q");
    setState(() {
      this.channel = channel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoList(channel: channel);
  }
}
