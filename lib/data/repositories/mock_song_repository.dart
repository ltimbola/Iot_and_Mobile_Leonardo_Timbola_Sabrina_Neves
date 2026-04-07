import '../../models/song_model.dart';
import '../mock_songs.dart';
import 'song_repository.dart';

class MockSongRepository implements SongRepository {
  @override
  List<SongModel> getSongs() => List<SongModel>.from(mockSongs);
}
