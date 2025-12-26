import 'package:flutter/material.dart';
import 'package:podcast_finder/core/utils/date_formatter.dart';
import 'package:podcast_finder/core/utils/duration_formatter.dart';
import 'package:podcast_finder/features/home/data/models/episode_model.dart';

class EpisodeListTile extends StatelessWidget {
  final EpisodeModel episode;

  const EpisodeListTile({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(episode.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              DateFormatter.formatFromMilliseconds(
                episode.publishDateMs,
              ),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 2),
            Text(
              DurationFormatter.formatFromSeconds(
                episode.audioLengthSec,
              ),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              episode.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
