import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('创建 Flutter GetX 项目', () async {
    // 项目名称
    final projectName = 'test_project';

    // 运行 getx_cli 脚本
    final processResult = await Process.run(
        'dart', ['run', 'bin/getx_cli.dart', projectName],
        runInShell: true);
    expect(processResult.exitCode, 0);

    // 检查项目目录是否存在
    final projectDir = Directory(projectName);
    expect(projectDir.existsSync(), true);

    // 检查 lib 目录是否存在
    final libDir = Directory('$projectName/lib');
    expect(libDir.existsSync(), true);

    // 检查 GetX 目录结构是否存在
    final expectedDirs = [
      'app',
      'core/services',
      'data/models',
      'data/repositories',
      'data/services',
      'ui/screens',
      'ui/widgets',
      'ui/controllers',
      'routes/bindings',
    ];

    for (final dir in expectedDirs) {
      final fullPath = '$projectName/lib/$dir';
      expect(Directory(fullPath).existsSync(), true, reason: '$fullPath 目录不存在');
    }

    // 删除测试项目
    projectDir.deleteSync(recursive: true);
  });
}
