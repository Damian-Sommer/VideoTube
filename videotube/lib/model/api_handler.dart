import 'dart:convert';
import 'dart:io';

import 'package:videotube/model/video.dart';
import 'package:http/http.dart' as http;

import '../util/config.dart';
import 'channel.dart';
class APIHandler {



  APIHandler._instantiate();

  static final APIHandler instance = APIHandler._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<Channel> fetchChannel({required String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
  Future<Channel> fetchChannelByUsername({required String channelTitle})async{
    Map<String, String> parameters = {
      'forUsername': channelTitle,
      'key': API_KEY,
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/channels',parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> channelJson = data['items'];

      Channel channel = Channel.fromMap(data);
      return channel;
    }else {
      throw json.decode(response.body)['error']['message'];
    }
  }
  Future<List<Video>> fetchVideosFromPlaylist({required String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
            (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

/*

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
*/
}
