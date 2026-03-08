import 'package:flutter/material.dart';
import 'package:device_app_info_list/installed_apps.dart';
import 'package:device_app_info_list_example/screens/app_info.dart';
import 'package:device_app_info_list_example/screens/app_list.dart';
import 'package:device_app_info_list_example/util/common.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text("Installed Apps Example"));
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        _buildListItem(
          context,
          "Installed Apps",
          "Get installed apps on device. With options to exclude system app, get app icon & matching package name prefix.",
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppListScreen()),
          ),
        ),
        _buildListItem(
          context,
          "App Info",
          "Get app info with package name",
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppInfoScreen()),
          ),
        ),
        _buildListItem(
          context,
          "Start App",
          "Start app with package name. Get callback of success or failure.",
          () => InstalledApps.startApp("com.google.android.gm"),
        ),
        _buildListItem(
          context,
          "Go To App Settings Screen",
          "Directly navigate to app settings screen with package name",
          () => InstalledApps.openSettings("com.google.android.gm"),
        ),
        _buildListItem(
          context,
          "Check If System App",
          "Check if app is system app with package name",
          () => CommonUtil.checkIfSystemApp(context, "com.google.android.gm"),
        ),
        _buildListItem(
          context,
          "Uninstall app",
          "Uninstall app with package name",
          () => InstalledApps.uninstallApp(
              "uz.ushodmonov.device_app_info_list_example"),
        ),
        _buildListItem(
          context,
          "Is app installed?",
          "Check if app is installed using package name",
          () => CommonUtil.checkIfAppIsInstalled(
            context,
            "uz.ushodmonov.device_app_info_list_example",
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(
    BuildContext context,
    String title,
    String subtitle,
    Function() onTap,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: onTap,
        ),
      ),
    );
  }
}
