import 'package:flutter/material.dart';
import 'package:form_builder/constants/constant.dart';
import 'package:form_builder/modal/elements/single_choice_selector_modal.dart';
import 'package:form_builder/modal/elements/single_select_modal.dart';
import 'package:form_builder/view-model/providers/form.dart';
import 'package:provider/provider.dart';

class RadioList extends StatefulWidget {
  final dynamic modal;
  final String? label;
  RadioList(this.modal, {this.label, super.key})
      : assert(
          modal.runtimeType == SingleSelectModal ||
              modal.runtimeType == SingleChoiceSelectorModal,
        );
  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList>
    with AutomaticKeepAliveClientMixin {
  late List<String> elements;
  List<bool> status = [];
  String question = "";
  static Map<String, String> map = {};
  @override
  void initState() {
    inception();
    super.initState();
  }

  inception() {
    elements = widget.modal.options;
    question = widget.modal.label;
    status = List.filled(elements.length, false);
    map = {};
  }

  @override
  void didUpdateWidget(covariant RadioList oldWidget) {
    if (widget.modal != oldWidget.modal) {
      inception();
    }
    super.didUpdateWidget(oldWidget);
  }

  void onTap(int index) {
    if (!widget.modal.readOnly) {
      status = List.filled(elements.length, false);
      status[index] = true;
      setState(() {});
      if (widget.label == null) {
        Provider.of<FormProvider>(
          context,
          listen: false,
        ).updateResponses(question, elements[index]);
      } else {
        Provider.of<FormProvider>(
          context,
          listen: false,
        ).updateResponses(
          widget.label!,
          _updatedMap(question, elements[index]),
        );
      }
    }
  }

  Map<String, dynamic> _updatedMap(String key, dynamic value) {
    map.update(key, (v) => value, ifAbsent: () => value);
    return map;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: elements.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(top: 12.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            border: Border.all(
              color: status[index] ? theme : grey,
              width: 2,
            ),
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: status[index] ? theme : grey,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: AnimatedContainer(
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status[index] ? theme : white,
                      ),
                    ),
                  ),
                  Text(elements[index]),
                ],
              ),
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
