import 'dart:io';

import 'package:getx_cli/commands/create/create_screen_command.dart';
import 'package:getx_cli/getx_cli.dart';

class InitCommand {
  final _getxCli = GetxCli();

  Future<void> run() async {
    // 检查是否安装了 GetX
    if (!await _isGetxInstalled()) {
      // 安装 GetX
      await _installGetx();
    }

    // 生成 GetX 项目结构
    _createGetXStructure('.');
    print('GetX 项目已初始化!');
  }

  void _createGetXStructure(String projectPath) {
    // 创建 lib 目录
    final libDir = Directory('$projectPath/lib');
    libDir.createSync();

    // 创建其他目录
    _getxCli.createDirectory(libDir, 'app');
    _getxCli.createDirectory(libDir, 'core');
    _getxCli.createDirectory(libDir, 'data');
    _getxCli.createDirectory(libDir, 'ui');
    _getxCli.createDirectory(libDir, 'routes');

    // 创建 core/services 目录
    _getxCli.createDirectory(Directory('$projectPath/lib/core'), 'services');

    // 创建 data/models, data/repositories 目录
    final dataDir = Directory('$projectPath/lib/data');
    List<String> dataDirs = [
      'models',
      'repositories',
    ];
    for (final dir in dataDirs) {
      _getxCli.createDirectory(dataDir, dir);
    }

    // 创建 ui/screens, ui/widgets, ui/controllers 目录
    final uiDir = Directory('$projectPath/lib/ui');
    List<String> uiDirs = [
      'screens',
      'widgets',
      'controllers',
    ];
    for (final dir in uiDirs) {
      _getxCli.createDirectory(uiDir, dir);
    }

    // 创建 routes/bindings 目录
    List<String> routesDirs = [
      'bindings',
      'middlewares',
    ];
    for (final dir in routesDirs) {
      _getxCli.createDirectory(Directory('$projectPath/lib/routes'), dir);
    }

    // 创建 core/utils, core/extensions, core/helpers 目录
    final coreDir = Directory('$projectPath/lib/core');
    List<String> coreDirs = [
      'utils',
      'extensions',
      'helpers',
    ];
    for (final dir in coreDirs) {
      _getxCli.createDirectory(coreDir, dir);
    }
    // 创建 app/themes 目录
    // _getxCli.createDirectory(Directory('$projectPath/lib/app'), 'themes');

    // 创建基础文件
    _createBaseFiles(projectPath);
  }

  void _createBaseFiles(String projectPath) {
    // main.dart
    _getxCli.createFile(
      '$projectPath/lib/main.dart',
      '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
''',
    );

    // app/app_pages.dart
    _getxCli.createFile(
      '$projectPath/lib/routes/app_pages.dart',
      '''
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.INITIAL;

  static final routes = [
  ];
}
''',
    );

    // app/app_routes.dart
    _getxCli.createFile(
      '$projectPath/lib/routes/app_routes.dart',
      '''
part of 'app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  /// ROUTES ///
}
''',
    );

    // app/themes/app_theme.dart
//     _getxCli.createFile(
//       '$projectPath/lib/app/themes/app_theme.dart',
//       '''
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'light_theme.dart';
// import 'dark_theme.dart';

// class AppTheme {
//   static switchTheme(ThemeMode themeMode) {
//     Get.changeTheme(
//         themeMode == ThemeMode.light ? LightThemeData.themeData : DarkThemeData.themeData);
//   }

//   static ThemeData get currentTheme => Get.theme;
//   static ThemeData get lightTheme => LightThemeData.themeData;
//   static ThemeData get darkTheme => DarkThemeData.themeData;
// }

// class ThemeService extends GetxService {
//   static ThemeService get to => Get.find();

//   late final SharedPreferences _prefs;
//   static const String _key = 'isDarkMode';

//   ThemeMode _loadThemeFromBox() {
//     final darkModeOn = _prefs.getBool(_key);
//     return darkModeOn == true ? ThemeMode.dark : ThemeMode.light;
//   }

//   _saveThemeToBox(bool isDarkMode) => _prefs.setBool(_key, isDarkMode);

//   ThemeMode get theme => _loadThemeFromBox();

//   Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   void switchTheme() {
//     Get.changeThemeMode(theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
//     _saveThemeToBox(!(_prefs.getBool(_key) ?? false));
//   }
// }
// ''',
//     );

    // app/themes/light_theme.dart
//     _getxCli.createFile(
//       '$projectPath/lib/app/themes/light_theme.dart',
//       '''
// import 'package:flutter/material.dart';

// class LightThemeData {
//   static ThemeData get themeData {
//     return ThemeData(
//       brightness: Brightness.light,
//       primaryColor: Colors.blue,
//       // ... 其他主题设置 ...
//     );
//   }
// }
// ''',
//     );
//     // app/themes/dark_theme.dart
//     _getxCli.createFile(
//       '$projectPath/lib/app/themes/dark_theme.dart',
//       '''
// import 'package:flutter/material.dart';

// class DarkThemeData {
//   static ThemeData get themeData {
//     return ThemeData(
//       brightness: Brightness.dark,
//       primaryColor: Colors.deepPurple,
//       // ... 其他主题设置 ...
//     );
//   }
// }
// ''',
//     );
    // 生成 Home Screen
    CreateScreenCommand().run('home');
  }

  // 检查是否安装了 GetX
  Future<bool> _isGetxInstalled() async {
    final processResult = await Process.run('flutter', ['pub', 'list']);
    return processResult.stdout.toString().contains('get:');
  }

  // 安装 GetX
  Future<void> _installGetx() async {
    final processResult = await Process.run('flutter', ['pub', 'add', 'get']);
    if (processResult.exitCode != 0) {
      print(processResult.stderr.toString());
      exit(1);
    }
    print('GetX 已安装!');
  }
}
