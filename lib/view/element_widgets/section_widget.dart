import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder/constants/constant.dart';
import 'package:form_builder/modal/elements/section_modal.dart';
import 'package:form_builder/modal/elements/single_select_modal.dart';
import 'package:form_builder/view-model/providers/form.dart';
import 'package:form_builder/view/element_widgets/single_select_widget.dart';
import 'package:provider/provider.dart';

class SectionWidget extends StatefulWidget {
  final SectionModal modal;
  const SectionWidget(this.modal, {super.key});

  @override
  State<SectionWidget> createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        Text(
          widget.modal.label,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: widget.modal.fields.length,
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Question ${index + 1}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: theme),
              ),
              const SizedBox(height: 10),
              _getTypeOfSectionElement(
                widget.modal.fields[index],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getTypeOfSectionElement(SectionElementModal modal) {
    if (modal.type == "SingleSelect") {
      return SingleSelectWidget(
        SingleSelectModal.fromJson(modal.schema),
        label: widget.modal.label,
      );
    }
    return _SectionTextFieldElement(
      SectionElementModal(type: modal.type, schema: modal.schema),
      label: widget.modal.label,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SectionTextFieldElement extends StatelessWidget {
  final String? label;
  final SectionElementModal element;
  const _SectionTextFieldElement(this.element, {this.label});

  static Map<String, dynamic> map = {};

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        inputFormatters: [
          if (element.type == "Numeric") FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: element.type == "Numeric"
            ? const TextInputType.numberWithOptions()
            : TextInputType.name,
        decoration: InputDecoration(
          label: Text(
            " ${element.schema["label"]} ",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          border: _border(trans),
          focusedBorder: _border(theme),
          enabledBorder: _border(grey),
        ),
        onChanged: (value) {
          if (label == null) {
            Provider.of<FormProvider>(
              context,
              listen: false,
            ).updateResponses(element.schema["name"], value);
          } else {
            Provider.of<FormProvider>(
              context,
              listen: false,
            ).updateResponses(
              label!,
              _updatedMap(element.schema["name"], value),
            );
          }
        },
      ),
    );
  }

  Map<String, dynamic> _updatedMap(String key, dynamic value) {
    map.update(key, (v) => value, ifAbsent: () => value);
    return map;
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.5),
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
    );
  }
}
