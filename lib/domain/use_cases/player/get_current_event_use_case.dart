import '../../../data/repositories/player_repository.dart';
import '../../../models/chord_event.dart';
import '../../../models/song_model.dart';

class GetCurrentEventUseCase {
  const GetCurrentEventUseCase(this._repository);

  final PlayerRepository _repository;

  ChordEvent call(SongModel song, int eventIndex) =>
      _repository.getCurrentEvent(song, eventIndex);
}
