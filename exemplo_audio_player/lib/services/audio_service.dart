import 'package:http/http.dart' as http;
import '../model/audio_model.dart';
import 'dart:convert';

class AudioService {
  List<AudioModel> _list = [];
  List<AudioModel> get list => _list;

  final String url = 'http://10.109.204.48:3000/audios';

  Future<void> fetchAudio() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      _list = data.map((e) => AudioModel.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load audio');
    }
  }
}
