import 'package:getx_cli/getx_cli.dart';

class CreateModelCommand {
  final _getxCli = GetxCli();

  Future<void> run(String modelName, {String? path}) async {
    if (modelName.isEmpty) {
      print('请输入模型名称: ');
      return;
    }

    _createModelFile(modelName, path: path);

    print('模型已创建: $modelName');
  }

  void _createModelFile(String modelName, {String? path}) {
    final snakeCaseName = _getxCli.convertToSnakeCase(modelName);
    final filePath = path != null
        ? '$path/$snakeCaseName.dart'
        : 'lib/data/models/$snakeCaseName.dart';

    if (_getxCli.isFileExists(filePath)) {
      final overwrite = _getxCli.confirm('模型文件已存在，是否覆盖? (y/n): ');
      if (!overwrite) {
        print('操作已取消.');
        return;
      }
    }

    _getxCli.createFile(filePath, '''
class ${_getxCli.capitalizeFirstLetter(modelName)} {

}
''');
  }
}
