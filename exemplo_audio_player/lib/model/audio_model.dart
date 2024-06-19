class AudioModel {
  final String title;
  final String artist;
  final String url;
  final String imageUrl;

  AudioModel({
    required this.title,
    required this.artist,
    required this.url,
    required this.imageUrl,
  });

  factory AudioModel.fromMap(Map<String, dynamic> json) {
    return AudioModel(
      title: json['title'],
      artist: json['artist'],
      url: json['url'],
      imageUrl: json['imageUrl'],
    );
  }
}
