import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/song_item.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();

  factory AudioPlayerService() => _instance;

  AudioPlayerService._internal() {
    player.playerStateStream.listen((state) {
      isPlayingNotifier.value = state.playing;

      if (state.processingState == ProcessingState.completed) {
        next();
      }
    });
  }

  final AudioPlayer player = AudioPlayer();

  final ValueNotifier<SongItem?> currentSongNotifier = ValueNotifier(null);
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier(false);

  List<SongItem> _playlist = [];
  int _currentIndex = 0;

  Future<void> playSong(SongItem song) async {
    _playlist = [song];
    _currentIndex = 0;
    await _playCurrent();
  }

  Future<void> playList(List<SongItem> songs) async {
    if (songs.isEmpty) return;
    _playlist = List.from(songs);
    _currentIndex = 0;
    await _playCurrent();
  }

  Future<void> playRandom(List<SongItem> songs) async {
    if (songs.isEmpty) return;
    _playlist = List.from(songs)..shuffle(Random());
    _currentIndex = 0;
    await _playCurrent();
  }

  Future<void> playByName(List<SongItem> songs, String query) async {
    final cleanQuery = query.toLowerCase().trim();
    if (cleanQuery.isEmpty) return;

    final matches = songs.where((song) {
      return song.title.toLowerCase().contains(cleanQuery);
    }).toList();

    if (matches.isEmpty) return;

    await playSong(matches.first);
  }

  Future<void> _playCurrent() async {
    if (_playlist.isEmpty) return;

    final song = _playlist[_currentIndex];
    currentSongNotifier.value = song;

    await player.setFilePath(song.path);
    await player.play();
  }

  Future<void> next() async {
    if (_playlist.isEmpty) return;

    _currentIndex++;

    if (_currentIndex >= _playlist.length) {
      _currentIndex = 0;
    }

    await _playCurrent();
  }

  Future<void> previous() async {
    if (_playlist.isEmpty) return;

    _currentIndex--;

    if (_currentIndex < 0) {
      _currentIndex = _playlist.length - 1;
    }

    await _playCurrent();
  }

  Future<void> togglePause() async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  Future<void> stop() async {
    await player.stop();
    currentSongNotifier.value = null;
  }
}
