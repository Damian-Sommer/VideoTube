class Video {

  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['maxres']['url'],
      channelTitle: snippet['channelTitle'],
    );
  }
  /*
  String author = "";
  String description = "";
  bool isLiked = false;
  Video(this.author, this.description, this.isLiked);
  */
}