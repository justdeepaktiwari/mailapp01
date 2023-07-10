class SettingBody {
  int? sms;
  int? push;

  SettingBody({
    this.sms,
    this.push,
  });

  Map<String, dynamic> bodyData() {
    if (sms != null) {
      return {
        "sms_notification": sms,
      };
    }
    return {
      "push_notification": push,
    };
  }
}
