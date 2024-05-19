import 'package:getx_cli/getx_cli.dart';

class CreateComponentCommand {
  final _getxCli = GetxCli();

  Future<void> run(String componentName, {String? path}) async {
    if (componentName.isEmpty) {
      print('请输入组件名称: ');
      return;
    }

    // 创建组件文件
    _createComponentFile(componentName, path: path);

    print('组件已创建: $componentName');
  }

  void _createComponentFile(String componentName, {String? path}) {
    final snakeCaseName = _getxCli.convertToSnakeCase(componentName);
    final filePath = path != null
        ? '$path/${snakeCaseName}_widget.dart'
        : 'lib/ui/widgets/${snakeCaseName}_widget.dart';

    // 判断文件是否存在，如果存在则提示是否覆盖
    if (_getxCli.isFileExists(filePath)) {
      final overwrite = _getxCli.confirm('组件文件已存在，是否覆盖? (y/n): ');
      if (!overwrite) {
        print('操作已取消.');
        return;
      }
    }

    _getxCli.createFile(filePath, '''
import 'package:flutter/material.dart';

class ${_getxCli.capitalizeFirstLetter(componentName)}Widget extends StatelessWidget {
  const ${_getxCli.capitalizeFirstLetter(componentName)}Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
''');
  }
}
