class DurationFormatter {
  static String formatFromSeconds(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return minutes > 0
          ? '${hours}h ${minutes}m'
          : '${hours}h';
    }

    return '$minutes min';
  }
}