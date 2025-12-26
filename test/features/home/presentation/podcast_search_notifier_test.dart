import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';
import 'package:podcast_finder/features/home/presentation/providers/podcast_search_notifier.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository.dart';

class FakePodcastRepository implements PodcastRepository {
  @override
  Future<List<PodcastModel>> searchPodcasts({required String query}) async {
    return [
      const PodcastModel(
        id: '1',
        title: 'Test Podcast',
        publisher: 'Test Publisher',
      ),
    ];
  }
}

void main() {
  test('PodcastSearchNotifier emits loading and data states', () async {
    // Arrange
    final repository = FakePodcastRepository();
    final notifier = PodcastSearchNotifier(repository);

    final states = <AsyncValue<List<PodcastModel>>>[];
    notifier.addListener((state) {
      states.add(state);
    });

    // Act
    await notifier.search('test');

    // Assert
    expect(
      states.any((state) => state is AsyncLoading),
      true,
    );

    expect(
      states.last,
      isA<AsyncData<List<PodcastModel>>>(),
    );

    expect(states.last.value!.length, 1);
    expect(states.last.value!.first.title, 'Test Podcast');
  });
}