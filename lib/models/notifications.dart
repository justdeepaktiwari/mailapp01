class NotificationList {
  final String title;
  final String message;
  final String date;

  NotificationList({
    required this.title,
    required this.message,
    required this.date,
  });

  factory NotificationList.fromMap(Map<String, dynamic> apiData) {
    return NotificationList(
      title: apiData["title"],
      message: apiData["message"],
      date: apiData["created_at"],
    );
  }
}
