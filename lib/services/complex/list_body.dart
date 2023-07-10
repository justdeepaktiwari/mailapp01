class ListComplexBody {
  final String name;
  final String complexLocation;
  final String notes;

  ListComplexBody({
    required this.name,
    required this.complexLocation,
    this.notes = '',
  });

  Map<String, dynamic> bodyData() {
    if (notes != '') {
      return {
        "name": name,
        "location": complexLocation,
        "notes": notes,
      };
    }
    return {
      "name": name,
      "location": complexLocation,
    };
  }
}