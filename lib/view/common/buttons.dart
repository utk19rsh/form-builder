import 'package:flutter/material.dart';
import 'package:form_builder/constants/constant.dart';
import 'package:form_builder/view-model/providers/form.dart';
import 'package:form_builder/view/result/result.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(theme.shade200),
        foregroundColor: const MaterialStatePropertyAll(black),
      ),
      onPressed: () => Provider.of<FormProvider>(
        context,
        listen: false,
      ).goToPreviousElement(),
      child: Row(
        children: [
          Icon(MdiIcons.chevronLeft),
          const SizedBox(width: 5),
          Text(
            "Back",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class GoForwardButton extends StatelessWidget {
  final FormProvider fp;
  const GoForwardButton(this.fp, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isLast = fp.currentIndex == fp.totalFields - 1;
    return GestureDetector(
      onTap: () {
        if (isLast) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (builder) => Result(fp.response)),
          );
        } else {
          fp.goToNextElement(context);
        }
      },
      child: Card(
        margin: const EdgeInsets.all(5),
        color: orange,
        elevation: 5,
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            isLast ? MdiIcons.check : MdiIcons.chevronRight,
            color: white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
