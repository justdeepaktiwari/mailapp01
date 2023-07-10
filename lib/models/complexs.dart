class ComplexList {
  final String name;
  final String email;
  final String code;

  ComplexList({
    required this.name,
    required this.email,
    required this.code,
  });

  factory ComplexList.fromMap(Map<String, dynamic> apiData) {
    return ComplexList(
      name: apiData["name"],
      email: apiData["email"],
      code: apiData["code"],
    );
  }
}
