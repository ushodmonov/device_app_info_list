import 'package:flutter/material.dart';
import 'package:device_app_info_list_example/screens/home.dart';

void main() => runApp(ExampleInstalledApps());

class ExampleInstalledApps extends MaterialApp {
  const ExampleInstalledApps({Key? key}) : super(key: key);

  @override
  Widget get home => HomeScreen();

  @override
  ThemeData? get theme => ThemeData(useMaterial3: false);
}
