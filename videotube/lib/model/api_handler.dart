import 'package:videotube/model/video.dart';

class APIHandler {

  static final APIHandler _singleton = APIHandler._internal();

  factory APIHandler() {
    return _singleton;
  }

  APIHandler._internal();

  static List videos = <Video>[];

  List get getVideos{
    if(videos.isEmpty){
      addVideo();
    }
    return videos;
  }

  void addVideo(){
    videos.add(Video("hello","he", false));
    videos.add(Video("hello","hello", false));
    videos.add(Video("hello","hello", false));
    videos.add(Video("hello","hello", false));
    videos.add(Video("hello","hello", false));
    videos.add(Video("hello","hello", false));
  }
  void update(int index){
    videos[index].isLiked = !videos[index].isLiked;
  }

}
