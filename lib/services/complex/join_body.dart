class JoinComplexBody {
  final String complexCode;
  final String userId;

  JoinComplexBody({
    required this.complexCode,
    required this.userId,
  });

  Map<String, dynamic> bodyData() {
    return {
      "complex": complexCode,
      "user": userId,
    };
  }
}
