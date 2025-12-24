import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'podcast_providers.dart'; // Donde está tu podcastsProvider
import '../../data/models/podcast_model.dart';

// Este provider recibe un ID y busca el podcast correspondiente
final podcastDetailProvider = Provider.family<AsyncValue<PodcastModel>, String>((ref, id) {
  // Obtenemos el listado completo del otro provider
  final allPodcastsAsync = ref.watch(podcastsProvider);

  // Transformamos el resultado para encontrar solo el que coincide con el ID
  return allPodcastsAsync.whenData((list) => 
    list.firstWhere((p) => p.id == id)
  );
});