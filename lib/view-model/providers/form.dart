import 'package:flutter/material.dart';
import 'package:form_builder/constants/constant.dart';
import 'package:form_builder/modal/elements/section_modal.dart';
import 'package:form_builder/modal/elements/single_choice_selector_modal.dart';
import 'package:form_builder/modal/elements/single_select_modal.dart';
import 'package:form_builder/modal/functions/functions.dart';
import 'package:form_builder/view/common/snack_bar.dart';
import 'package:form_builder/view/element_widgets/section_widget.dart';
import 'package:form_builder/view/element_widgets/single_choice_selector_widget.dart';
import 'package:form_builder/view/element_widgets/single_select_widget.dart';

class FormProvider extends ChangeNotifier {
  String title = "", description = "";
  List<dynamic> fields = [];
  int totalFields = 0;
  List<Widget> widgets = [];
  Map<String, dynamic> response = {};
  Util util = Util();
  Map<String, dynamic> questions = {};
  bool isLoading = true;
  int currentIndex = -1;

  PageController pc = PageController(
    initialPage: 0,
    keepPage: true,
  );

  updateResponses(String key, dynamic value) {
    if (key == "Type of loan" && response.containsKey(key)) reset();
    response.update(key, (v) => value, ifAbsent: () => value);
    notifyListeners();
  }

  _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  _stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  bool _isIndexWithRange() => currentIndex < totalFields;

  bool canMoveFurther() => currentIndex == response.length;

  bool _canBuildFurther() =>
      response.length == widgets.length && currentIndex == response.length - 1;

  goToNextElement(BuildContext context) {
    if (_isIndexWithRange()) {
      if (canMoveFurther()) {
        CustomSnackBar(context).build("Please enter the required details");
      } else {
        if (_canBuildFurther()) {
          if (_checkForSpecificConditions(2)) {
            ++currentIndex;
          }
          _fetchNextElement(++currentIndex);
          _updatePageController(currentIndex);
        } else {
          _updatePageController(++currentIndex);
        }
      }
    }
    notifyListeners();
  }

  reset() {
    currentIndex = 0;
    widgets = [widgets.first];
    response = {};
    totalFields = fields.length;
    notifyListeners();
  }

  bool _checkForSpecificConditions(int index) {
    if (response["Type of loan"] != "Balance transfer & Top-up" &&
        (currentIndex == index)) {
      return true;
    }
    return false;
  }

  goToPreviousElement() {
    if (currentIndex > 0) {
      if (_checkForSpecificConditions(4)) {
        --currentIndex;
      }
      _updatePageController(--currentIndex);
    }
    notifyListeners();
  }

  _updatePageController(int index) => pc.jumpToPage(index);

  inception(BuildContext context) async {
    _startLoading();
    questions = await util.extractJson(context, formJsonPath);
    title = questions["title"];
    description = questions["description"];
    fields = questions["schema"]["fields"];
    totalFields = fields.length;
    _fetchNextElement(++currentIndex);
    _stopLoading();
    notifyListeners();
  }

  _fetchNextElement(int index) {
    _startLoading();
    Widget next = _analyzeTypeOfElement(fields[index]);
    if (next != const SizedBox.shrink()) widgets.add(next);
    _stopLoading();
  }

  Widget _analyzeTypeOfElement(Map<String, dynamic> element) {
    FocusManager.instance.primaryFocus?.unfocus();
    switch (element["type"]) {
      case "SingleChoiceSelector":
        SingleChoiceSelectorModal modal =
            SingleChoiceSelectorModal.fromJson(element["schema"]);
        if (modal.hidden) return const SizedBox.shrink();
        return SingleChoiceSelectorWidget(modal);
      case "Section":
        SectionModal modal = SectionModal.fromJson(element["schema"]);
        return SectionWidget(modal);
      case "SingleSelect":
        SingleSelectModal modal = SingleSelectModal.fromJson(element["schema"]);
        if (modal.hidden.runtimeType != bool &&
            modal.label == "Existing bank where loan existse" &&
            response["Type of loan"] == "Balance transfer & Top-up") {
          // totalFields--;
          return SingleSelectWidget(modal);
        }
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}
