import '../../../data/repositories/player_repository.dart';
import '../../../models/song_model.dart';

class ResolveEventIndexUseCase {
  const ResolveEventIndexUseCase(this._repository);

  final PlayerRepository _repository;

  int call(SongModel song, Duration position, int currentEventIndex) {
    return _repository.resolveEventIndex(song, position, currentEventIndex);
  }
}
