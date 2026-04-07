import 'package:flutter/foundation.dart';
import '../../../data/repositories/mock_song_repository.dart';
import '../../../data/repositories/song_repository.dart';
import '../../../domain/use_cases/songs/get_songs_use_case.dart';
import '../../../models/song_model.dart';

class SongsController extends ChangeNotifier {
  SongsController({SongRepository? repository})
      : _repository = repository ?? MockSongRepository() {
    songs = _getSongs();
  }

  final SongRepository _repository;
  late final GetSongsUseCase _getSongs = GetSongsUseCase(_repository);
  List<SongModel> songs = [];
}
