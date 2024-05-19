import 'package:getx_cli/getx_cli.dart';

class CreateRepositoryCommand {
  final _getxCli = GetxCli();

  Future<void> run(String repositoryName, {String? path}) async {
    if (repositoryName.isEmpty) {
      print('请输入数据仓库名称: ');
      return;
    }

    _createRepositoryFile(repositoryName, path: path);

    print('数据仓库已创建: $repositoryName');
  }

  void _createRepositoryFile(String repositoryName, {String? path}) {
    final snakeCaseName = _getxCli.convertToSnakeCase(repositoryName);
    final filePath = path != null
        ? '$path/${snakeCaseName}_repository.dart'
        : 'lib/data/repositories/${snakeCaseName}_repository.dart';

    if (_getxCli.isFileExists(filePath)) {
      final overwrite = _getxCli.confirm('数据仓库文件已存在，是否覆盖? (y/n): ');
      if (!overwrite) {
        print('操作已取消.');
        return;
      }
    }

    // 不继承 GetxService
    _getxCli.createFile(filePath, '''
class ${_getxCli.capitalizeFirstLetter(repositoryName)}Repository {

}
''');
  }
}
