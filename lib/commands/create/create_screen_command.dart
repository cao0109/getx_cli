import 'dart:io';

import 'package:getx_cli/getx_cli.dart';

class CreateScreenCommand {
  final _getxCli = GetxCli();

  Future<void> run(String screenName, {String? path}) async {
    if (screenName.isEmpty) {
      print('Please enter screen name: ');
      return;
    }

    // 创建页面文件
    _createScreenFile(screenName, path: path);

    // 创建控制器文件
    _createControllerFile(screenName);

    // 添加路由信息
    _addRoute(screenName, path: path);

    print('Screen created: $screenName');
  }

  void _createScreenFile(String screenName, {String? path}) {
    final snakeCaseName = _getxCli.convertToSnakeCase(screenName);
    final filePath = path != null
        ? '$path/${snakeCaseName}_screen.dart'
        : 'lib/ui/screens/${snakeCaseName}_screen.dart';
    // 判断文件是否存在，如果存在则提示是否覆盖
    if (_getxCli.isFileExists(filePath)) {
      final overwrite = _getxCli.confirm('Screen文件已存在，是否覆盖? (y/n): ');
      if (!overwrite) {
        print('操作已取消.');
        return;
      }
    }

    //判断文件夹是否存在，如果不存在则创建
    final folderPath = filePath.substring(0, filePath.lastIndexOf('/'));
    if (!_getxCli.isFolderExists(folderPath)) {
      _getxCli.createFolder(folderPath);
    }

    //计算controller的相对路径 考虑path
    final controllerRelativePath = GetxCli.calculateRelativePath(
        '$path/${snakeCaseName}_screen.dart',
        'lib/ui/controllers/${snakeCaseName}_controller.dart');

    _getxCli.createFile(filePath, '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '$controllerRelativePath';

class ${_getxCli.capitalizeFirstLetter(screenName)}Screen extends GetView<${_getxCli.capitalizeFirstLetter(screenName)}Controller> {
  const ${_getxCli.capitalizeFirstLetter(screenName)}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${_getxCli.capitalizeFirstLetter(screenName)} Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Count: \${controller.count}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.increment();
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
''');
  }

  void _createControllerFile(String screenName) {
    final snakeCaseName = _getxCli.convertToSnakeCase(screenName);
    final filePath = 'lib/ui/controllers/${snakeCaseName}_controller.dart';
    // 判断文件是否存在，如果存在则提示是否覆盖
    if (_getxCli.isFileExists(filePath)) {
      final overwrite = _getxCli.confirm('控制器文件已存在，是否覆盖? (y/n): ');
      if (!overwrite) {
        print('操作已取消.');
        return;
      }
    }
    print('create controller file: $filePath');
    _getxCli.createFile(filePath, '''
import 'package:get/get.dart';

class ${_getxCli.capitalizeFirstLetter(screenName)}Controller extends GetxController {
  RxInt count = 0.obs;

  void increment() {
    count++;
  }
}
''');
  }

  void _addRoute(String screenName, {String? path}) {
    final snakeCaseName = _getxCli.convertToSnakeCase(screenName);
    final routeName = '/$snakeCaseName';

    final routesFile = File('lib/routes/app_routes.dart');
    final routesContent = routesFile.readAsStringSync();
    final updatedRoutesContent =
        routesContent.replaceFirst('/// ROUTES ///', '''
  static const ${snakeCaseName.toUpperCase()} = '$routeName';
  /// ROUTES ///''');
    routesFile.writeAsStringSync(updatedRoutesContent);

    final pagesFile = File('lib/routes/app_pages.dart');
    final pagesContent = pagesFile.readAsStringSync();

    // 计算 Controller 和 Binding 的相对路径
    final bindingRelativePath = GetxCli.calculateRelativePath(
        'lib/routes/app_pages.dart',
        'lib/routes/bindings/${snakeCaseName}_binding.dart');
    final screenRelativePath = GetxCli.calculateRelativePath(
        'lib/routes/app_pages.dart', '$path/${snakeCaseName}_screen.dart');

    // 生成导入语句
    final importStatements = '''
import '$screenRelativePath';
import '$bindingRelativePath';
''';

    // 使用正则表达式查找最后一个 import 语句的结束位置
    final importRegExp = RegExp(r"import\s+'[^']+';");
    final importMatches = importRegExp.allMatches(pagesContent);
    final lastImportEndIndex =
        importMatches.isNotEmpty ? importMatches.last.end : -1;

    // 在最后一个 import 语句之后插入新的导入语句
    final updatedPagesContentWithImport = lastImportEndIndex != -1
        ? '${pagesContent.substring(0, lastImportEndIndex)}'
            '\n$importStatements'
            '${pagesContent.substring(lastImportEndIndex)}'
        : '$importStatements\n$pagesContent';

    // 查找 routes 列表的开始位置
    final routesStartIndex =
        updatedPagesContentWithImport.indexOf('static final routes = [');

    // 查找 routes 列表的结束位置
    final routesEndIndex =
        updatedPagesContentWithImport.indexOf('];', routesStartIndex);

    // 在 routes 列表的结束位置之前插入新的 GetPage
    final updatedPagesContent = routesStartIndex != -1 && routesEndIndex != -1
        ? '${updatedPagesContentWithImport.substring(0, routesEndIndex)}'
            '''
    GetPage(
      name: Routes.${snakeCaseName.toUpperCase()},
      page: () => const ${_getxCli.capitalizeFirstLetter(screenName)}Screen(),
      binding: ${_getxCli.capitalizeFirstLetter(screenName)}Binding(),
    ),
'''
            '${updatedPagesContentWithImport.substring(routesEndIndex)}'
        : '$importStatements\n$updatedPagesContentWithImport';

    pagesFile.writeAsStringSync(updatedPagesContent);

    // 创建 binding 文件
    final filePath = 'lib/routes/bindings/${snakeCaseName}_binding.dart';
    // 判断文件是否存在，如果存在则提示是否覆盖
    if (_getxCli.isFileExists(filePath)) {
      final overwrite = _getxCli.confirm('Binding 文件已存在，是否覆盖? (y/n): ');
      if (!overwrite) {
        print('操作已取消.');
        return;
      }
    }

    // 计算相对路径
    final relativePath = GetxCli.calculateRelativePath(
        filePath, 'lib/ui/controllers/${snakeCaseName}_controller.dart');

    _getxCli.createFile(filePath, '''
import 'package:get/get.dart';
import '$relativePath';

class ${_getxCli.capitalizeFirstLetter(screenName)}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${_getxCli.capitalizeFirstLetter(screenName)}Controller>(
      () => ${_getxCli.capitalizeFirstLetter(screenName)}Controller(),
    );
  }
}
''');
  }
}
