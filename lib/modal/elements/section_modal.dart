class SectionModal {
  final String name, label;
  final List<SectionElementModal> fields;

  factory SectionModal.fromJson(Map<String, dynamic> res) {
    return SectionModal(
      name: res["name"],
      label: res["label"],
      fields: _getAllSectionAttributes(res["fields"]),
    );
  }

  SectionModal({
    required this.name,
    required this.label,
    required this.fields,
  });
}

class SectionElementModal {
  final String type;
  final Map<String, dynamic> schema;
  SectionElementModal({required this.type, required this.schema});
}

List<SectionElementModal> _getAllSectionAttributes(
  List<dynamic> fields,
) {
  List<SectionElementModal> result = [];
  for (int i = 0; i < fields.length; i++) {
    result.add(
      SectionElementModal(
        type: fields[i]["type"],
        schema: fields[i]["schema"],
      ),
    );
  }
  return result;
}
