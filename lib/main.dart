import 'dart:async' show Future;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'app.dart';
import 'base_injection.dart' as injection;
import 'bloc.dart';
BuildContext? appContext;

void main() async {
  //       
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
  });
  // for the responsive service to work (I don't know the reason until now)
  await Future.delayed(const Duration(milliseconds: 300));
  await EasyLocalization.ensureInitialized();
  await injection.init();

  return runApp(
const GenerateMultiBloc( child: MyApp(),)
      
  );
}

final supportedLocales = <Locale>[
  const Locale('ar'),
  const Locale('en'),
];
