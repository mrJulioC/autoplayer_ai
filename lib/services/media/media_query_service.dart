import 'package:on_audio_query/on_audio_query.dart';

class MediaQueryService {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongModel>> getSongs() async {
    return _audioQuery.querySongs(
      sortType: SongSortType.TITLE,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }
}