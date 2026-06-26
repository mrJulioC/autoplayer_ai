import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../logic/library/library_provider.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsAsync = ref.watch(songLibraryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca musical'),
      ),
      body: songsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
        data: (songs) {
          if (songs.isEmpty) {
            return const Center(
              child: Text(
                'No se encontraron canciones.\nVerifica los permisos.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.separated(
            itemCount: songs.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final song = songs[index];

              return ListTile(
                leading: const Icon(Icons.music_note_rounded),
                title: Text(
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  song.artist ?? 'Artista desconocido',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.play_arrow_rounded),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}