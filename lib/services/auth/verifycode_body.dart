class VerifyCodeBody {
  final String phoneNumber;

  VerifyCodeBody(
    this.phoneNumber,
  );

  Map<String, dynamic> bodyData() {
    return {
      "phone_number": phoneNumber,
    };
  }
}
