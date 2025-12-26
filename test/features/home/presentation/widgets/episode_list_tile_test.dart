import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_finder/features/home/data/models/episode_model.dart';
import 'package:podcast_finder/features/home/presentation/widgets/episode_list_tile.dart';

void main() {
  testWidgets('EpisodeListTile displays episode info',
      (WidgetTester tester) async {
    // Arrange
    final episode = EpisodeModel(
      id: 'ep-1',
      title: 'Test Episode',
      description: 'Test description',
      publishDateMs: DateTime(2023, 12, 16).millisecondsSinceEpoch,
      audioLengthSec: 3600,
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EpisodeListTile(episode: episode),
        ),
      ),
    );

    // Assert
    expect(find.text('Test Episode'), findsOneWidget);
    expect(find.textContaining('2023'), findsOneWidget);
    expect(find.textContaining('1h'), findsOneWidget);
    expect(find.text('Test description'), findsOneWidget);
  });
}