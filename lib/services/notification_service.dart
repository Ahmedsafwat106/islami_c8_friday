class NotificationService {
  // Dummy init
  static Future<void> init() async {
    // Initialization placeholder
    print('NotificationService initialized (dummy)');
  }

  /// Show an immediate notification (testing)
  static Future<void> showNow(int id, String title, String body) async {
    // فقط لطباعة الاختبار، لن يظهر إشعار حقيقي
    print('showNow called: id=$id, title=$title, body=$body');
  }

  /// Schedule daily notification at specific hour/minute
  static Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    // Dummy schedule
    print('scheduleDaily called: id=$id, title=$title, body=$body, hour=$hour, minute=$minute');
  }

  /// Cancel all notifications
  static Future<void> cancelAll() async {
    // Dummy cancel
    print('cancelAll called');
  }
}
