import 'package:flutter/material.dart';
import 'package:videotube/model/api_handler.dart';
import 'package:videotube/screen/video_detail.dart';

import '../model/video.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  APIHandler apiHandler = APIHandler();
  static List videos = <Video>[];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    updateVideoListView();
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
        return InkWell(
          onTap: () {
            navigateSecondPage(index);
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
                getListTileHeadWidget(index),
                getListTileBottomWidget(index),
              ],
            ),
          ),
        );
      },
    );
  }

  void handleLike(int index) {
    apiHandler.update(index);
    updateVideoListView();
  }

  void updateVideoListView() {
    setState(() {
      videos = apiHandler.getVideos;
      count = apiHandler.getVideos.length;
    });
  }

  Color getColor(bool isLiked) {
    if (isLiked) {
      return const Color(0xff11ad11);
    }
    return const Color(0xffDFDDDD);
  }

  void navigateSecondPage(int index) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return VideoDetail(id: index);
    }));
  }

  Widget getListTileHeadWidget(int index) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/img/thumbnail.png',
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: getAuthorDescriptionWidget(index),
    );
  }

  Widget getListTileBottomWidget(int index) {
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
          getDescriptionWidget(index),
          getLikesWidget(1000),
          getLikeWidget(index),
        ],
      ),
    );
  }

  Widget getAuthorDescriptionWidget(int index) {
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
              Image.asset(
                'assets/img/profilepic.png',
                height: 50,
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  videos.elementAt(index).author,
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

  Widget getDescriptionWidget(int index) {
    return Expanded(
      flex: 8,
      child: Text(
        videos[index].description,
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

  Widget getLikeWidget(int index) {
    return Expanded(
      flex: 1,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ImageIcon(
            const AssetImage("assets/icons/like.png"),
            color: getColor(videos[index].isLiked),
          ),
        ),
        onTap: () {
          handleLike(index);
        },
      ),
    );
  }
}
