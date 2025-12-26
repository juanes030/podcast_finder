import 'package:json_annotation/json_annotation.dart';

part 'podcast_model.g.dart';

@JsonSerializable()
class PodcastModel {
  final String id;
  final String title;
  final String publisher;
  
  @JsonKey(name: 'thumbnail')
  final String? imageUrl;
  
  @JsonKey(name: 'description_original')
  final String? description;

  const PodcastModel({
    required this.id,
    required this.title,
    required this.publisher,
    this.imageUrl,
    this.description,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) => _$PodcastModelFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastModelToJson(this);

  PodcastModel copyWith({
    String? id,
    String? title,
    String? publisher,
    String? imageUrl,
    String? description,
  }) {
    return PodcastModel(
      id: id ?? this.id,
      title: title ?? this.title,
      publisher: publisher ?? this.publisher,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }
}