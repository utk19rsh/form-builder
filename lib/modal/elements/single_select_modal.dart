class SingleSelectModal {
  final String name, label;
  final bool readOnly;
  final dynamic hidden;
  final List<String> options;

  factory SingleSelectModal.fromJson(Map<String, dynamic> res) {
    return SingleSelectModal(
      name: res["name"],
      label: res["label"],
      hidden: res["hidden"],
      readOnly: res["readonly"],
      options: _getAllSingleSelectAttributes(res["options"]),
    );
  }

  SingleSelectModal({
    required this.hidden,
    required this.readOnly,
    required this.name,
    required this.label,
    required this.options,
  });
}

List<String> _getAllSingleSelectAttributes(
  List<dynamic> options,
) {
  List<String> result = [];
  for (int i = 0; i < options.length; i++) {
    result.add(options[i]["value"]);
  }
  return result;
}
