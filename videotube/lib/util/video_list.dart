import 'package:flutter/material.dart';
import 'package:videotube/model/api_handler.dart';

import '../model/channel.dart';
import '../model/video.dart';

class VideoList extends StatefulWidget {
  final Channel channel;
  const VideoList({Key? key, required this.channel}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<VideoList> {
  bool _isLoading = false;
  APIHandler apiHandler = APIHandler.instance;
  static List videos = <Video>[];
  int count = 0;
@override
  void setState(VoidCallback fn) {
    super.setState(fn);
    videos = widget.channel.videos;
    count = int.parse(widget.channel.videoCount);
  }
  @override
  Widget build(BuildContext context) {
    //updateVideoListView();
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
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        Video video = widget.channel.videos[index];
        return _buildVideo(video);
      },
    );
  }

  _buildVideo(Video video) {
    return InkWell(
      onTap: () {
        //navigateSecondPage(video.id);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF11141C),
        ),
        child: Column(
          children: <Widget>[
            getListTileHeadWidget(video.channelTitle, video.thumbnailUrl),
            getListTileBottomWidget(video.title,true, 1000),
          ],
        ),
      ),
    );
  }

  Widget getListTileHeadWidget(String channelTitle, String videoThumbnail) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.pink,
        image: DecorationImage(
          image: NetworkImage(videoThumbnail),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: getAuthorDescriptionWidget(channelTitle),
    );
  }

  Widget getListTileBottomWidget(String description, bool isLiked, int rating) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Color(0xFF11141C),
      ),
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      child: Row(
        children: <Widget>[
          getDescriptionWidget(description),
          getLikesWidget(rating),
          getLikeWidget(isliked: true),
        ],
      ),
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


/*
  void handleLike(String index) {
    apiHandler.update(index);
    updateVideoListView();
  }
*//*
  void updateVideoListView() {
    setState(() {
      videos = apiHandler.getVideos;
      count = apiHandler.getVideos.length;
    });
  }*/

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

  Widget getAuthorDescriptionWidget(String channelTitle) {
    Channel channel = APIHandler.instance.fetchChannelByUsername(channelTitle: channelTitle) as Channel;
    return Align(
      alignment: Alignment.topLeft,
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xB3333333),
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(4),
          constraints: const BoxConstraints(maxWidth: 200),
          child: Row(
            children: [
              Image(
                height: 50,
                width: 50,
                image: NetworkImage(channel.profilePictureUrl),
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
      ),
    );
  }

  Widget getDescriptionWidget(String description) {
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
            color: Color(0xFFFFFFFF),//getColor(isLiked),
          ),
        ),
        onTap: () {
          //handleLike(index);
        },
      ),
    );
  }
}
