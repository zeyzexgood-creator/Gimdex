import 'package:flutter/material.dart';
import '../models/song.dart';

class SongList extends StatelessWidget {
  final List<Song> songs;
  final Function(Song) onSongTap;
  final Song? currentSong;

  const SongList({
    super.key,
    required this.songs,
    required this.onSongTap,
    this.currentSong,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        final isCurrent = currentSong == song;

        return Card(
          elevation: isCurrent ? 8 : 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                song.coverArt,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[300],
                    child: const Icon(Icons.music_note),
                  );
                },
              ),
            ),
            title: Text(
              song.title,
              style: TextStyle(
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isCurrent ? Colors.deepPurple : null,
              ),
            ),
            subtitle: Text(song.artist),
            trailing: isCurrent
                ? const Icon(Icons.play_arrow, color: Colors.deepPurple)
                : null,
            onTap: () => onSongTap(song),
          ),
        );
      },
    );
  }
}