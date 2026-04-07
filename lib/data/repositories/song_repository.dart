import '../../models/song_model.dart';

abstract class SongRepository {
  List<SongModel> getSongs();
}
