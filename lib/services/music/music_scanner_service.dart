import 'dart:io';

import '../../core/constants/app_paths.dart';
import '../../models/song_item.dart';

class MusicScannerService {
  final List<String> allowedExtensions = [
    '.mp3',
    '.m4a',
    '.wav',
    '.flac',
    '.aac',
    '.ogg',
  ];

  Future<bool> ensureMusicFolder() async {
    try {
      final dir = Directory(AppPaths.musicFolder);

      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      return await dir.exists();
    } catch (_) {
      return false;
    }
  }

  Future<List<SongItem>> scanMyMusic() async {
    final created = await ensureMusicFolder();

    if (!created) return [];

    final dir = Directory(AppPaths.musicFolder);
    final List<SongItem> songs = [];

    try {
      await for (final entity in dir.list(
        recursive: true,
        followLinks: false,
      )) {
        if (entity is File) {
          final path = entity.path;
          final extension = _getExtension(path).toLowerCase();

          if (allowedExtensions.contains(extension)) {
            final stat = await entity.stat();

            songs.add(
              SongItem(
                title: _cleanTitle(path),
                path: path,
                extension: extension,
                size: stat.size,
              ),
            );
          }
        }
      }
    } catch (_) {
      return [];
    }

    songs.sort(
      (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
    );

    return songs;
  }

  String _getExtension(String path) {
    final index = path.lastIndexOf('.');
    if (index == -1) return '';
    return path.substring(index);
  }

  String _cleanTitle(String path) {
    final fileName = path.split('/').last;
    return fileName.replaceAll(RegExp(r'\.[^.]+$'), '');
  }
}
