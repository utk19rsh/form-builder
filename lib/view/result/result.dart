import 'package:flutter/material.dart';
import 'package:form_builder/constants/constant.dart';
import 'package:form_builder/view-model/providers/form.dart';
import 'package:form_builder/view/home/home.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Result extends StatelessWidget {
  final Map<String, dynamic> result;
  const Result(this.result, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Result"),
          actions: [
            TextButton(
              style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(white),
              ),
              onPressed: () {
                Provider.of<FormProvider>(context, listen: false).reset();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const Home(),
                  ),
                  (route) => false,
                );
              },
              child: Row(
                children: [
                  const Text("Try Again"),
                  Icon(MdiIcons.refresh),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: result.length,
            itemBuilder: (context, index) {
              return _ResultElements(
                result.entries.elementAt(index).key,
                result.entries.elementAt(index).value,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ResultElements extends StatelessWidget {
  final String question;
  final dynamic answer;
  final double? scale;
  const _ResultElements(this.question, this.answer, {this.scale, super.key});

  @override
  Widget build(BuildContext context) {
    return answer.runtimeType == String
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuestionElement(scale: scale, question: question),
                const SizedBox(height: 5),
                AnswerElement(scale: scale, answer: answer),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "- $question",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 22 * (scale ?? 1),
                    ),
              ),
              ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shrinkWrap: true,
                itemCount: answer.length,
                itemBuilder: (context, index) {
                  return _ResultElements(
                    answer.entries.elementAt(index).key,
                    answer.entries.elementAt(index).value,
                    scale: (scale ?? 1) * 0.75,
                  );
                },
              ),
            ],
          );
  }
}

class AnswerElement extends StatelessWidget {
  const AnswerElement({
    super.key,
    required this.scale,
    required this.answer,
  });

  final double? scale;
  final dynamic answer;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "A. ",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 22 * (scale ?? 1), color: green),
          ),
          TextSpan(
            text: answer,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 18 * (scale ?? 1)),
          ),
        ],
      ),
    );
  }
}

class QuestionElement extends StatelessWidget {
  const QuestionElement({
    super.key,
    required this.scale,
    required this.question,
  });

  final double? scale;
  final String question;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Q. ",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 22 * (scale ?? 1), color: theme),
          ),
          TextSpan(
            text: question,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 22 * (scale ?? 1),
                ),
          ),
        ],
      ),
    );
  }
}
