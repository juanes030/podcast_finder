import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/podcast_model.dart';

class PodcastDetailNotifier extends StateNotifier<PodcastModel?> {
  // Inicializamos el estado en null (ningún podcast seleccionado)
  PodcastDetailNotifier() : super(null);

  // Función para seleccionar un podcast
  void selectPodcast(PodcastModel podcast) {
    state = podcast;
  }

  // Función para limpiar la selección (opcional)
  void clearSelection() {
    state = null;
  }
}