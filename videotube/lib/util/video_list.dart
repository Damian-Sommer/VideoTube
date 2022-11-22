import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:videotube/model/api_handler.dart';

import '../model/channel.dart';
import '../model/video.dart';

class VideoList extends StatefulWidget {
  final Channel channel;

  VideoList({Key? key, required this.channel}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<VideoList> {
  bool _isLoading = false;
  APIHandler apiHandler = APIHandler.instance;
  static List videos = <Video>[];

  @override
  Widget build(BuildContext context) {
    return videoList();
  }

  Widget videoList() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          getVideoList(),
        ],
      ),
    );
  }

  ListView getVideoList() {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.channel.videos.length,
      itemBuilder: (BuildContext context, int index) {
        Video video = widget.channel.videos[index];
        return _buildVideo(video);
      },
    );
  }

  _buildVideo(Video video) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () {
            //navigateSecondPage(video.id);
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFFFFFFF),
            ),
            child: Column(
              children: <Widget>[
                getListTileHeadWidget(video.channelTitle, video.thumbnailUrl),
                getVideoFooter(video.title, true, 1000, video.thumbnailUrl),
              ],
            ),
          ),
        ));
  }

  Widget getListTileHeadWidget(String channelTitle, String videoThumbnail) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          height: 300,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.pink,
            image: DecorationImage(
              image: NetworkImage(videoThumbnail),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: getAuthorPill(channelTitle),
        ));
  }

  Widget getVideoFooter(
      String description, bool isLiked, int rating, String thumbnailUrl) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                child: Image.network(
                  thumbnailUrl,
                  fit: BoxFit.fill,
                ),
              )),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Color(0xB3000000),
          ),
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: Row(
            children: <Widget>[
              getVideoTitleWidget(description),
              getLikesWidget(rating),
              getLikeWidget(isliked: true),
            ],
          ),
        )
      ],
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIHandler.instance
        .fetchVideosFromPlaylist(playlistId: widget.channel.uploadPlaylistId);
    List<Video> allVideos = widget.channel.videos..addAll(moreVideos);
    setState(() {
      widget.channel.videos = allVideos;
    });
    _isLoading = false;
  }

  Color getColor(bool isLiked) {
    if (isLiked) {
      return const Color(0xff11ad11);
    }
    return const Color(0xffDFDDDD);
  }

/*
  void navigateSecondPage(String videoId) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return VideoDetail(id: videoId);
    }));
  }*/

  Widget getAuthorPill(String channelTitle) {
    return Align(
      alignment: Alignment.topLeft,
      child: IntrinsicWidth(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: BackdropFilter(
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color(0xB3333333),
                  ),
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        child: Image(
                          height: 50,
                          width: 50,
                          image: NetworkImage(widget.channel.profilePictureUrl),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          channelTitle,
                          style: const TextStyle(
                            color: Color(0xffDFDDDD),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getVideoTitleWidget(String description) {
    return Expanded(
      flex: 8,
      child: Text(
        description,
        style: const TextStyle(
          color: Color(0xffDFDDDD),
          fontSize: 20,
        ),
      ),
    );
  }

  Widget getLikesWidget(int likes) {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          likes.toString(),
          style: const TextStyle(
            color: Color(0xffDFDDDD),
          ),
        ),
      ),
    );
  }

  Widget getLikeWidget({required bool isliked}) {
    return Expanded(
      flex: 1,
      child: InkWell(
        child: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: ImageIcon(
            AssetImage("assets/icons/like.png"),
            color: Color(0xFFFFFFFF), //getColor(isLiked),
          ),
        ),
        onTap: () {
          //handleLike(index);
        },
      ),
    );
  }
}
