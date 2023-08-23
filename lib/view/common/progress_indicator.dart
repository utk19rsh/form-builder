import 'package:flutter/material.dart';
import 'package:form_builder/constants/constant.dart';

class ProgressComponent extends StatefulWidget {
  const ProgressComponent(this.enable, this.count, {Key? key})
      : super(key: key);

  final bool enable;
  final int count;

  @override
  State<ProgressComponent> createState() => _ProgressComponentState();
}

class _ProgressComponentState extends State<ProgressComponent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color fillColor = green;
    Color emptyColor = green.shade100;
    double width =
        (size.width - (20 + 20 + (10 * widget.count - 1))) / widget.count;
    return Container(
      height: 5,
      width: width,
      decoration: BoxDecoration(
        color: emptyColor,
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.centerLeft,
      child: AnimatedContainer(
        margin: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
        curve: Curves.bounceOut,
        duration: const Duration(milliseconds: 1000),
        width: !widget.enable ? 0 : width,
        height: 5,
        decoration: BoxDecoration(
          color: widget.enable ? fillColor : fillColor.withAlpha(100),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
