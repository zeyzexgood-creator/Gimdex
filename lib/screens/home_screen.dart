import 'package:flutter/material.dart';
import '../widgets/song_list.dart';
import '../widgets/player_controls.dart';
import '../models/song.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Song? currentSong;
  bool isPlaying = false;

  final List<Song> songs = [
    Song(
      title: 'Blinding Lights',
      artist: 'The Weeknd',
      url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      coverArt: 'https://picsum.photos/200/200?random=1',
    ),
    Song(
      title: 'Shape of You',
      artist: 'Ed Sheeran',
      url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      coverArt: 'https://picsum.photos/200/200?random=2',
    ),
    Song(
      title: 'Dance Monkey',
      artist: 'Tones and I',
      url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      coverArt: 'https://picsum.photos/200/200?random=3',
    ),
  ];

  void playSong(Song song) {
    setState(() {
      currentSong = song;
      isPlaying = true;
    });
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void nextSong() {
    if (currentSong != null) {
      int currentIndex = songs.indexOf(currentSong!);
      int nextIndex = (currentIndex + 1) % songs.length;
      playSong(songs[nextIndex]);
    }
  }

  void previousSong() {
    if (currentSong != null) {
      int currentIndex = songs.indexOf(currentSong!);
      int prevIndex = (currentIndex - 1 + songs.length) % songs.length;
      playSong(songs[prevIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.purpleAccent],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text('Music Player'),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
              ),
              Expanded(
                child: SongList(
                  songs: songs,
                  onSongTap: playSong,
                  currentSong: currentSong,
                ),
              ),
              if (currentSong != null)
                PlayerControls(
                  currentSong: currentSong!,
                  isPlaying: isPlaying,
                  onPlayPause: togglePlayPause,
                  onNext: nextSong,
                  onPrevious: previousSong,
                ),
            ],
          ),
        ),
      ),
    );
  }
}