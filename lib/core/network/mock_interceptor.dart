import 'package:dio/dio.dart';

/// Interceptor that simulates API responses for testing
/// In a real scenario, you would remove this and use actual API calls
class MockInterceptor extends Interceptor {
  /// Base list of podcasts used for both search and detail
  final List<Map<String, dynamic>> _allPodcasts = [
    {
      'id': 'podcast-1',
      'title': 'Tech Talk Daily',
      'publisher': 'Tech Media Inc',
      'thumbnail': 'https://picsum.photos/seed/podcast1/200',
      'description_original':
          'Your daily dose of technology news and insights. We cover everything from startups to AI.',
    },
    {
      'id': 'podcast-2',
      'title': 'The Science Show',
      'publisher': 'Science Network',
      'thumbnail': 'https://picsum.photos/seed/podcast2/200',
      'description_original':
          'Exploring the wonders of science, from quantum physics to biology.',
    },
    {
      'id': 'podcast-3',
      'title': 'Business Builders',
      'publisher': 'Entrepreneur Media',
      'thumbnail': 'https://picsum.photos/seed/podcast3/200',
      'description_original':
          'Stories and strategies from successful entrepreneurs around the world.',
    },
    {
      'id': 'podcast-4',
      'title': 'Flutter Explained',
      'publisher': 'Mobile Devs',
      'thumbnail': 'https://picsum.photos/seed/podcast4/200',
      'description_original':
          'Everything about Flutter, Dart and mobile development.',
    },
    {
      'id': 'podcast-5',
      'title': 'AI Today',
      'publisher': 'Future Labs',
      'thumbnail': 'https://picsum.photos/seed/podcast5/200',
      'description_original':
          'Artificial Intelligence, machine learning and the future.',
    },
    {
      'id': 'podcast-6',
      'title': 'Design Matters',
      'publisher': 'Creative Studio',
      'thumbnail': 'https://picsum.photos/seed/podcast6/200',
      'description_original':
          'Deep conversations about design, creativity and user experience.',
    },
    {
      'id': 'podcast-7',
      'title': 'Startup Stories',
      'publisher': 'Founders Hub',
      'thumbnail': 'https://picsum.photos/seed/podcast7/200',
      'description_original':
          'Real stories from startup founders: wins, failures and lessons learned.',
    },
    {
      'id': 'podcast-8',
      'title': 'Mobile Dev Weekly',
      'publisher': 'Dev Weekly',
      'thumbnail': 'https://picsum.photos/seed/podcast8/200',
      'description_original':
          'Weekly updates on mobile development, frameworks and best practices.',
    },
    {
      'id': 'podcast-9',
      'title': 'Cloud & Infra',
      'publisher': 'Cloud Experts',
      'thumbnail': 'https://picsum.photos/seed/podcast9/200',
      'description_original':
          'Everything about cloud infrastructure, DevOps and scalability.',
    },
    {
      'id': 'podcast-10',
      'title': 'Product Thinking',
      'publisher': 'Product School',
      'thumbnail': 'https://picsum.photos/seed/podcast10/200',
      'description_original':
          'Building products users love through strategy and research.',
    },
    {
      'id': 'podcast-11',
      'title': 'Data Driven',
      'publisher': 'Analytics Lab',
      'thumbnail': 'https://picsum.photos/seed/podcast11/200',
      'description_original':
          'Data science, analytics and decision making explained simply.',
    },
    {
      'id': 'podcast-12',
      'title': 'Cyber Security Now',
      'publisher': 'SecureNet',
      'thumbnail': 'https://picsum.photos/seed/podcast12/200',
      'description_original':
          'Security news, hacking stories and how to protect your systems.',
    },
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //Search request
    if (options.path.contains('/search')) {
      final query = options.queryParameters['q'] ?? '';
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: _getMockSearchResponse(query),
        ),
      );
      return;
    }

    //Podcast detail request
    if (options.path.contains('/podcasts/')) {
      final id = options.path.split('/').last;
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: _getMockPodcastDetailResponse(id),
        ),
      );
      return;
    }

    // Pass through if no mock is found
    handler.next(options);
  }

  /// Mock search response
  Map<String, dynamic> _getMockSearchResponse(String query) {
    final lowerQuery = query.toLowerCase();

    //Query vacío → devolver todos
    if (lowerQuery.isEmpty) {
      return {
        'count': _allPodcasts.length,
        'results': _allPodcasts,
      };
    }

    //Filtrar por título
    final results = _allPodcasts.where((podcast) {
      final title = podcast['title'].toString().toLowerCase();
      return title.contains(lowerQuery);
    }).toList();

    return {
      'count': results.length,
      'results': results,
    };
  }

  /// Mock podcast detail response
  Map<String, dynamic> _getMockPodcastDetailResponse(String id) {
    final podcast = _allPodcasts.firstWhere(
      (p) => p['id'] == id,
      orElse: () => _allPodcasts.first,
    );

    return {
      'id': id,
      'title': podcast['title'],
      'publisher': podcast['publisher'],
      'image': 'https://picsum.photos/seed/$id/400',
      'description':
          'Detailed description for ${podcast['title']}. This podcast dives deep into its topic.',
      'genre_ids': [127, 93],
      'episodes': List.generate(8, (index) {
        return {
          'id': '$id-episode-$index',
          'title': 'Episode ${index + 1}',
          'description':
              'Description for episode ${index + 1} of ${podcast['title']}.',
          'pub_date_ms': DateTime.now()
              .subtract(Duration(days: index))
              .millisecondsSinceEpoch,
          'audio_length_sec': 1800 + (index * 120),
        };
      }),
    };
  }
}
