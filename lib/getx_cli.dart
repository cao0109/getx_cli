import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:prompts/prompts.dart' as prompts;

class GetxCli {
  static String prompt(String message) {
    return prompts.get(message);
  }

  void createDirectory(Directory parentDir, String dirName) {
    final dir = Directory('${parentDir.path}/$dirName');
    dir.createSync();
  }

  void createFile(String path, String content) {
    final file = File(path);
    file.writeAsStringSync(content);
  }

  String convertToSnakeCase(String text) {
    return text.replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'), (match) {
      return '_${match.group(0)!.toLowerCase()}';
    }).toLowerCase();
  }

  String capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  bool confirm(String message) {
    stdout.write(message);
    final input = stdin.readLineSync()!.toLowerCase();
    return input == 'y';
  }

  bool isFileExists(String filePath) {
    return File(filePath).existsSync();
  }

  /// 计算两个文件之间的相对路径
  static String calculateRelativePath(String fromPath, String toPath) {
    // 获取 fromPath 和 toPath 的目录路径
    final fromDir = path.dirname(fromPath);
    final toDir = path.dirname(toPath);

    // 判断两个目录是否相同
    if (fromDir == toDir) {
      // 如果目录相同，直接返回文件名
      return path.basename(toPath);
    } else {
      // 如果目录不同，计算相对路径
      final relativePath = path.relative(toPath, from: fromDir);

      // 处理 Windows 路径分隔符
      return relativePath.replaceAll('\\', '/');
    }
  }

  bool isFolderExists(String folderPath) {
    return Directory(folderPath).existsSync();
  }

  void createFolder(String folderPath) {
    Directory(folderPath).createSync();
  }
}
