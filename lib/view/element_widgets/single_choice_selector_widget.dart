import 'package:flutter/material.dart';
import 'package:form_builder/modal/elements/single_choice_selector_modal.dart';
import 'package:form_builder/view/common/radio_list_tile.dart';

class SingleChoiceSelectorWidget extends StatelessWidget {
  final SingleChoiceSelectorModal modal;
  final String? label;
  const SingleChoiceSelectorWidget(this.modal, {this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        Text(modal.label, style: Theme.of(context).textTheme.titleLarge),
        RadioList(modal, label: label),
      ],
    );
  }
}
