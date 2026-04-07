import '../../../data/repositories/song_repository.dart';
import '../../../models/song_model.dart';

class GetSongsUseCase {
  const GetSongsUseCase(this._repository);

  final SongRepository _repository;

  List<SongModel> call() => _repository.getSongs();
}
