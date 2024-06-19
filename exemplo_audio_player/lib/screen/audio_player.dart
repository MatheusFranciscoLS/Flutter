import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../model/audio_model.dart';

class AudioPlayerScreen extends StatefulWidget {
  final List<AudioModel> audioList;
  final int initialIndex;

  const AudioPlayerScreen({
    Key? key,
    required this.audioList,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  int _currentIndex = 0;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _currentIndex = widget.initialIndex;
    _playCurrentAudio();

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration position) {
      print('Current Position: $position');
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      print('Total Duration: $duration');
      setState(() {
        _totalDuration = duration;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playCurrentAudio() {
    _audioPlayer.setSource(UrlSource(widget.audioList[_currentIndex].url));
    _audioPlayer.play(UrlSource(widget.audioList[_currentIndex].url));
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(widget.audioList[_currentIndex].url));
    }
  }

  void _playNext() {
    if (_currentIndex < widget.audioList.length - 1) {
      _currentIndex++;
      _playCurrentAudio();
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _playCurrentAudio();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audioList[_currentIndex].title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                widget.audioList[_currentIndex].imageUrl,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            Text(
              widget.audioList[_currentIndex].title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.audioList[_currentIndex].artist,
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Slider(
              value: _currentPosition.inSeconds.toDouble(),
              max: _totalDuration.inSeconds.toDouble(),
              onChanged: (value) {
                final position = Duration(seconds: value.toInt());
                _audioPlayer.seek(position);
                setState(() {
                  _currentPosition = position;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(_currentPosition)),
                  Text(_formatDuration(_totalDuration)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 64.0,
                  onPressed: _playPrevious,
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 64.0,
                  onPressed: _playPause,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 64.0,
                  onPressed: _playNext,
                ),
              ],
            ),
            Text(
              _isPlaying ? 'Reproduzindo' : 'Pausado',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
