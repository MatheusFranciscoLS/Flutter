import 'package:flutter/material.dart';
import 'package:exemplo_audio_player/services/audio_service.dart';
import 'audio_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService _service = AudioService();

  Future<void> _getAudioList() async {
    try {
      await _service.fetchAudio();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getAudioList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getAudioList,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<void>(
          future: _getAudioList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (_service.list.isEmpty) {
              return const Center(
                child: Text('Não há músicas'),
              );
            } else {
              return ListView.builder(
                itemCount: _service.list.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          _service.list[index].imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image, size: 50);
                          },
                        ),
                      ),
                      title: Text(_service.list[index].title),
                      subtitle: Text(_service.list[index].artist),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioPlayerScreen(
                              audioList: _service.list,
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}