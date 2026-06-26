import '../library/library_screen.dart';
import 'package:flutter/material.dart';
import '../../widgets/home_action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              const Icon(
                Icons.music_note_rounded,
                size: 78,
                color: Color(0xFF00E676),
              ),

              const SizedBox(height: 18),

              const Text(
                'AutoPlayer AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Tu música. Tu auto. Sin anuncios.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              HomeActionButton(
                icon: Icons.library_music_rounded,
                title: 'Música',
                subtitle: 'Reproducir canciones locales',
                onTap: () {},
              ),

              const SizedBox(height: 16),

              HomeActionButton(
                icon: Icons.video_library_rounded,
                title: 'Videos',
                subtitle: 'Reproducir archivos MP4',
                onTap: () {},
              ),

              const SizedBox(height: 16),
              HomeActionButton(
                icon: Icons.library_music_rounded,
                title: 'Música',
                subtitle: 'Reproducir canciones locales',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LibraryScreen(),
                    ),
                  );
                },
              ),


              const Spacer(),

              const Text(
                'v0.1 Base inicial',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}