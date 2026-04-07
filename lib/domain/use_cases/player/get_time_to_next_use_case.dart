import '../../../data/repositories/player_repository.dart';
import '../../../models/song_model.dart';

class GetTimeToNextUseCase {
  const GetTimeToNextUseCase(this._repository);

  final PlayerRepository _repository;

  Duration call(SongModel song, Duration position, int eventIndex) {
    return _repository.getTimeToNext(song, position, eventIndex);
  }
}
