class AppUtils {
  static String formatDateTime(DateTime dateTime) {
    // Implementation for formatting a DateTime object
    // Example: Convert DateTime to a formatted string
    final formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    final formattedTime = '${dateTime.hour}:${dateTime.minute}';

    return '$formattedDate $formattedTime';
  }
}
