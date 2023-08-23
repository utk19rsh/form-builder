import 'dart:convert';

import 'package:flutter/widgets.dart';

class Util {
  Future<Map<String, dynamic>> extractJson(
    BuildContext context,
    String path,
  ) async {
    String json = await DefaultAssetBundle.of(context).loadString(path);
    return jsonDecode(json);
  }
}
