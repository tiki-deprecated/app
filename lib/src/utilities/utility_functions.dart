import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Route<T> platformPageRoute<T>(Widget destination) {
  if (Platform.isIOS)
    return CupertinoPageRoute(builder: (context) => destination);
  else
    return MaterialPageRoute(builder: (context) => destination);
}
