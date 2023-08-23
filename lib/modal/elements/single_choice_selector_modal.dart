class SingleChoiceSelectorModal {
  final String name, label;
  final bool hidden, readOnly;
  final List<String> options;

  factory SingleChoiceSelectorModal.fromJson(Map<String, dynamic> res) {
    return SingleChoiceSelectorModal(
      name: res["name"],
      label: res["label"],
      hidden: res["hidden"],
      readOnly: res["readonly"],
      options: _getAllSingleChoiceAttributes(res["options"]),
    );
  }

  SingleChoiceSelectorModal({
    required this.hidden,
    required this.readOnly,
    required this.name,
    required this.label,
    required this.options,
  });
}

List<String> _getAllSingleChoiceAttributes(
  List<dynamic> options,
) {
  List<String> result = [];
  for (int i = 0; i < options.length; i++) {
    result.add(options[i]["value"]);
  }
  return result;
}
