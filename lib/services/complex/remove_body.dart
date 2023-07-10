class RemoveComplexBody {
  final String complexCode;
  final String userId;

  RemoveComplexBody({
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
