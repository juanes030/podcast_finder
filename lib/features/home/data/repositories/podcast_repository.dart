import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/network/dio_client.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

final podcastRepositoryProvider = Provider<PodcastRepository>((ref) {
  final dio = ref.read(dioProvider);
  return PodcastRepository(dio);
});

class PodcastRepository {
  final Dio _dio;

  PodcastRepository(this._dio);

Future<List<PodcastModel>> searchPodcasts({
  required String query,
}) async {
  try {
    final response = await _dio.get(
      '/search',
      queryParameters: {'q': query},
    );

    final results = response.data['results'] as List;
    return results
        .map((json) => PodcastModel.fromJson(json))
        .toList();
  } on DioException catch (e) {
    throw NetworkException.fromDioError(e);
  }
}
}
