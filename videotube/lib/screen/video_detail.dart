import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoDetail extends StatefulWidget {
  final int id;
  VideoDetail({Key? key, required this.id}) : super(key: key);

  @override
  _VideoDetailState createState() => _VideoDetailState(id: id);
}

class _VideoDetailState extends State<VideoDetail> {
  final int id;

  _VideoDetailState({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video"),
      ),
      body: getVideoDetails(),
    );
  }

  Widget getVideoDetails() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            "hello ${id}",
            style: const TextStyle(color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Icon(
                IconData(
                    0xf571,
                    fontFamily: 'MaterialIcons',
                    matchTextDirection: true),
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
