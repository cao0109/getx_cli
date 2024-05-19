// // DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

// // ignore_for_file: lines_longer_than_80_chars

// import 'package:get/get.dart';

// // 支持的语言
// class LocaleKeys {
//   LocaleKeys._();
//   static final en_US = _EnUs();
//   static final zh_CN = _ZhCn();
// }

// class _EnUs implements Translations {
//   _EnUs();

//   // 通用错误信息
//   String get error_empty_project_name => 'Project name cannot be empty.';
//   String error_project_already_exists(String projectName) =>
//       'Project "$projectName" already exists.';
//   String get error_install_getx => 'Failed to install GetX: ';
//   String get success_getx_installed => 'GetX installed successfully.';
//   String get success_project_initialized =>
//       'GetX project structure initialized.';
//   // 命令行提示信息
//   String get prompt_enter_project_name => 'Enter project name:';
//   String success_project_created(String projectName) =>
//       'Project "$projectName" created successfully.';

//   String error_unavailable_command(String usage) => '''
// Unavailable command. 

// $usage
// ''';

//   @override
//   Map<String, Map<String, String>> get keys => {
//         'en_US': {
//           'error_empty_project_name': error_empty_project_name,
//           'error_project_already_exists':
//               error_project_already_exists.toString(),
//           'error_install_getx': error_install_getx,
//           'success_getx_installed': success_getx_installed,
//           'success_project_initialized': success_project_initialized,
//           'prompt_enter_project_name': prompt_enter_project_name,
//           'success_project_created': success_project_created.toString(),
//           'error_unavailable_command': error_unavailable_command.toString(),
//         }
//       };
// }

// class _ZhCn implements Translations {
//   _ZhCn();

//   // 通用错误信息
//   //error_install_getx
//   String get error_empty_project_name => '项目名称不能为空。';
//   String error_project_already_exists(String projectName) =>
//       '项目"$projectName"已存在。';
//   String get error_install_getx => '安装 GetX 失败: ';
//   String get success_getx_installed => '已安装 GetX';
//   String get success_project_initialized => 'GetX 项目结构已初始化';
//   // 命令行提示信息
//   String get prompt_enter_project_name => '请输入项目名称：';
//   String success_project_created(String projectName) => '项目"$projectName"创建成功。';

//   String error_unavailable_command(String usage) => '''
// 不可用的命令。

// $usage
// ''';

//   @override
//   Map<String, Map<String, String>> get keys => {
//         'zh_CN': {
//           'error_empty_project_name': error_empty_project_name,
//           'error_project_already_exists':
//               error_project_already_exists.toString(),
//           'error_install_getx': error_install_getx,
//           'success_getx_installed': success_getx_installed,
//           'success_project_initialized': success_project_initialized,
//           'prompt_enter_project_name': prompt_enter_project_name,
//           'success_project_created': success_project_created.toString(),
//           'error_unavailable_command': error_unavailable_command.toString(),
//         }
//       };
// }
