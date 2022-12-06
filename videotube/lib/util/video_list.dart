import 'package:flutter/cupertino.dart';
import 'package:videotube/model/api_handler.dart';
import 'package:videotube/util/config.dart';
import 'package:videotube/util/video_list_util.dart';
import '../model/channel.dart';

class VideoList
    extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
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
        await apiHandler.fetchChannel(channelId: channelId);
    setState(() {
      this.channel = channel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoListUtil(channel: channel);
  }
}
