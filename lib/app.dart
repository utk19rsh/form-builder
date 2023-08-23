import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder/constants/constant.dart';
import 'package:form_builder/view-model/providers/form.dart';
import 'package:form_builder/view/home/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Builder',
        theme: ThemeData(
          appBarTheme: appBarTheme(),
          primaryColor: theme,
          splashColor: theme.withOpacity(0.25),
          highlightColor: theme.withOpacity(0.25),
          scaffoldBackgroundColor: white,
          textTheme: GoogleFonts.mavenProTextTheme(),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: grey),
        ),
        home: const Home(),
      ),
    );
  }

  AppBarTheme appBarTheme() {
    return AppBarTheme(
      foregroundColor: white,
      elevation: 0,
      backgroundColor: theme,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: theme,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(color: white),
      titleTextStyle: GoogleFonts.nunito(
        textStyle: const TextStyle(
          color: white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) {
        FormProvider fp = FormProvider();
        fp.inception(context);
        return fp;
      },
    ),
  ];
}
