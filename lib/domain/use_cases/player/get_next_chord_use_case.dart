import '../../../data/repositories/player_repository.dart';
import '../../../models/song_model.dart';

class GetNextChordUseCase {
  const GetNextChordUseCase(this._repository);

  final PlayerRepository _repository;

  String call(SongModel song, int eventIndex) =>
      _repository.getNextChord(song, eventIndex);
}
