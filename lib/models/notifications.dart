class NotificationList {
  final String complexName;
  final String title;
  final String message;
  final DateTime date;

  NotificationList({
    required this.complexName,
    required this.title,
    required this.message,
    required this.date,
  });

  factory NotificationList.fromMap(Map<String, dynamic> apiData) {
    final date = DateTime.parse(apiData["created_at"]);
    return NotificationList(
      complexName: apiData["complex_name"],
      title: apiData["title"],
      message: apiData["message"],
      date: date,
    );
  }
}
