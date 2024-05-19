import 'package:getx_cli/getx_cli.dart';

class CreateServiceCommand {
  final _getxCli = GetxCli();

  Future<void> run(String serviceName, {String? path}) async {
    if (serviceName.isEmpty) {
      print('请输入服务名称: ');
      return;
    }

    _createServiceFile(serviceName, path: path);

    print('服务已创建: $serviceName');
  }

  void _createServiceFile(String serviceName, {String? path}) {
    final snakeCaseName = _getxCli.convertToSnakeCase(serviceName);
    final filePath = path != null
        ? '$path/${snakeCaseName}_service.dart'
        : 'lib/core/services/${snakeCaseName}_service.dart';

    if (_getxCli.isFileExists(filePath)) {
      final overwrite = _getxCli.confirm('服务文件已存在，是否覆盖? (y/n): ');
      if (!overwrite) {
        print('操作已取消.');
        return;
      }
    }

    _getxCli.createFile(filePath, '''
import 'package:get/get.dart';

class ${_getxCli.capitalizeFirstLetter(serviceName)}Service extends GetxService {

}
''');
  }
}
