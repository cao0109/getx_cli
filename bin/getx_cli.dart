import 'package:args/args.dart';
import 'package:getx_cli/commands/create/create_component_command.dart';
import 'package:getx_cli/commands/create/create_model_command.dart';
import 'package:getx_cli/commands/create/create_repository_command.dart';
import 'package:getx_cli/commands/create/create_screen_command.dart';
import 'package:getx_cli/commands/create/create_service_command.dart';
import 'package:getx_cli/commands/init_command.dart';

// 模块名到目录的映射关系
const Map<String, String> modulePaths = {
  'screen': 'lib/ui/screens',
  'component': 'lib/ui/widgets',
  'service': 'lib/core/services',
  'model': 'lib/data/models',
  'repository': 'lib/data/repositories',
};

void main(List<String> arguments) async {
  final parser = ArgParser()..addCommand('init');

  final createParser = ArgParser();
  parser.addCommand('create', createParser);

  final results = parser.parse(arguments);
  final command = results.command;

  if (command == null) {
    _printUsage(parser);
    return;
  }

  switch (command.name) {
    case 'init':
      await InitCommand().run();
      break;
    case 'create':
      _handleCreateCommand(command);
      break;
    default:
      _printUsage(parser);
  }
}

void _printUsage(ArgParser parser) {
  print('此命令不可用。\n${parser.usage}');
}

void _handleCreateCommand(ArgResults command) {
  // 获取位置参数
  final rest = command.rest;

  // 检查参数数量
  if (rest.length != 2) {
    print('Invalid arguments. Usage: getx create <module> <name>');
    return;
  }

  final module = rest[0];
  String name = rest[1];

  String? path = modulePaths[module];

  if (path == null) {
    print('Invalid module: $module');
    return;
  }

  //判断name是否包含/或: 等分割符号
  if (name.contains('/') || name.contains(':')) {
    List<String> parts = [];
    if (name.contains('/')) {
      parts = name.split('/');
    } else if (name.contains(':')) {
      parts = name.split(':');
    }
    //name 等于/或: 之后的内容
    name = parts[parts.length - 1];

    if (name.isEmpty) {
      print('Invalid filename: $name');
      return;
    }

    path = '$path/${parts.sublist(0, parts.length - 1).join('/')}';
  }

  print('create $module $name in $path');

  switch (module) {
    case 'screen':
      CreateScreenCommand().run(name, path: path);
      break;
    case 'component':
      CreateComponentCommand().run(name, path: path);
      break;
    case 'service':
      CreateServiceCommand().run(name, path: path);
      break;
    case 'model':
      CreateModelCommand().run(name, path: path);
      break;
    case 'repository':
      CreateRepositoryCommand().run(name, path: path);
      break;
  }

  //格式化
  // Process.runSync('flutter', ['format', path]);
}
