import 'package:flutter/material.dart';
import 'package:videotube/util/config.dart';
import 'package:videotube/util/video_list.dart';
import 'package:videotube/util/video_list_util.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetail extends StatefulWidget {
  final String id;
  const VideoDetail({Key? key, required this.id}) : super(key: key);

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {

    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Video"),
      ),
      body: getVideoDetails("hallo"),
    );
  }

  Widget getVideoDetails(String title) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            liveUIColor: const Color(0xffff0000),
          ),
          VideoList(),
        ],
      )
    );
  }
}
