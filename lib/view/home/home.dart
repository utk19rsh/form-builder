import 'package:flutter/material.dart';
import 'package:form_builder/view-model/providers/form.dart';
import 'package:form_builder/view/common/app_bar.dart';
import 'package:form_builder/view/common/buttons.dart';
import 'package:form_builder/view/common/progress_indicator.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<FormProvider>(
        builder: (context, value, _) {
          int questionCount =
              value.response["Type of loan"] == "Balance transfer & Top-up"
                  ? value.fields.length
                  : value.fields.length - 1;
          return Scaffold(
            appBar: const ZeroAppBar(),
            body: value.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.title,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: List.generate(
                            questionCount,
                            (index) => Padding(
                              padding: EdgeInsets.only(
                                right: index < questionCount - 1 ? 10 : 0,
                              ),
                              child: ProgressComponent(
                                value.currentIndex >= index &&
                                    index < questionCount,
                                questionCount,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: PageView(
                            controller: value.pc,
                            physics: const NeverScrollableScrollPhysics(),
                            children: value.widgets,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const GoBackButton(),
                            GoForwardButton(value),
                          ],
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
