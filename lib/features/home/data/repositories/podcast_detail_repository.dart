import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';

import '../../../../core/network/dio_client.dart';
import '../models/podcast_detail_model.dart';

final podcastDetailRepositoryProvider =
    Provider<PodcastDetailRepository>((ref) {
  final dio = ref.read(dioProvider);
  return PodcastDetailRepository(dio);
});

class PodcastDetailRepository {
  final Dio _dio;

  PodcastDetailRepository(this._dio);

  Future<PodcastDetailModel> getPodcastDetail(String id) async {
    try {
      final response = await _dio.get('/podcasts/$id');
      return PodcastDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}