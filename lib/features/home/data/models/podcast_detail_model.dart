import 'package:json_annotation/json_annotation.dart';
import 'episode_model.dart';

part 'podcast_detail_model.g.dart';

@JsonSerializable()
class PodcastDetailModel {
  final String id;
  final String title;
  final String publisher;
  final String image;
  final String description;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  final List<EpisodeModel> episodes;

  const PodcastDetailModel({
    required this.id,
    required this.title,
    required this.publisher,
    required this.image,
    required this.description,
    required this.genreIds,
    required this.episodes,
  });

  factory PodcastDetailModel.fromJson(Map<String, dynamic> json) => _$PodcastDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastDetailModelToJson(this);
}
