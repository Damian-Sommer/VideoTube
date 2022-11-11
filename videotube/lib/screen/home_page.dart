import 'package:flutter/material.dart';
import 'package:videotube/screen/video_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLiked = true;
  @override
  Widget build(BuildContext context) {
    return videoList();
  }

  Widget videoList() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          getList(),
        ],
      ),
    );
  }

  ListView getList() {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
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
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/img/thumbnail.png',
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Align(
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
                            const Padding(
                              padding: EdgeInsets.only(left: 3),
                              child: Text(
                                "Lara Watson",
                                style: TextStyle(
                                  color: Color(0xffDFDDDD),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Color(0xFF11141C),
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 50,
                  ),
                  child: Row(
                    children: <Widget>[
                      getDescriptionWidget("hallo das ist ein text hallo das ist ein text hallo das ist ein text hallo das ist ein text hallo das ist ein text hallo das ist ein text hallo das ist ein text"),
                      getLikesWidget(1000),
                      getLikeWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded getDescriptionWidget(String description){
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

  Expanded getLikesWidget(int likes) {
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

  Expanded getLikeWidget() {
    return Expanded(
      flex: 1,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ImageIcon(
            const AssetImage("assets/icons/like.png"),
            color: getColor(),
          ),
        ),
        onTap: () {
          handleLike();
        },
      ),
    );
  }

  bool handleLike() {
    isLiked = isLiked == true ? false : true;
    return isLiked;
  }

  Color getColor() {
    if (isLiked) {
      return const Color(0xff11ad11);
    }
    return const Color(0xffDFDDDD);
  }

  void navigateSecondPage(int index) async {
    final bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return VideoDetail(id: index);
    }));
    /* if(result == true){
      updateListView();
    }*/
  }
}
