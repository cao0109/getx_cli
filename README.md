
# GetX CLI

一个用于快速创建 GetX 项目结构和文件的命令行工具。

## ✨ 特性

- **初始化 GetX 项目:**  快速搭建完整的 GetX 项目结构。
- **创建多种文件:**  轻松创建 Screen、Component、Service、Model 和 Repository 等文件。
- **自定义路径:**  自由选择文件创建路径，按模块组织代码。
- **模块化创建:**  使用 `module:name` 形式指定模块和文件，例如 `screen:my`。

## 🚀 安装

```bash
dart pub global activate getx_cli
```

## 💻 使用方法

### 初始化 GetX 项目

```bash
getx init
```

这将在当前目录下创建一个新的 GetX 项目，包含以下目录结构：

```text
lib
├── app
│   ├── themes
│   │   ├── light_theme.dart
│   │   └── dark_theme.dart
│   ├── app_translations.dart
│   ├── app_constants.dart
│   └── app_utils.dart
├── core
│   ├── services
│   │   └── ... (服务文件)
│   ├── utils
│   │   ├── date_utils.dart
│   │   └── string_utils.dart
│   ├── extensions
│   │   ├── string_extensions.dart
│   │   └── datetime_extensions.dart
│   └── helpers
│       └── http_helper.dart
├── data
│   ├── models
│   │   └── ... (模型文件)
│   └── repositories
│       └── ... (数据仓库文件)
├── routes
│   ├── app_pages.dart
│   ├── app_routes.dart
│   ├── bindings
│   │   └── app_binding.dart
│   └── ... (其他功能模块的路由文件，例如：auth_routes.dart, home_routes.dart)
└── ui
    ├── controllers
    │   └── ... (控制器文件)
    ├── screens
    │   └── ... (页面文件)
    └── widgets
        └── ... (组件文件)
```

### 创建文件

你可以使用以下命令创建不同的 GetX 文件：

```bash
getx create <module>:<name>
```

其中：

- `<module>` 是模块名，可选值包括：
  - `screen`:  创建 Screen 文件，默认路径为 `lib/ui/screens`。
  - `component`:  创建 Component 文件，默认路径为 `lib/ui/widgets`。
  - `service`:  创建 Service 文件，默认路径为 `lib/core/services`。
  - `model`:  创建 Model 文件，默认路径为 `lib/data/models`。
  - `repository`:  创建 Repository 文件，默认路径为 `lib/data/repositories`。
- `<name>` 是文件名，例如 `my`、`my_button`。

**示例：**

```bash
# 创建名为 my_screen 的 Screen 文件，使用默认路径
getx create screen:my
```

#### 创建名为 my_button 的 Component 文件，使用默认路径

```bash
getx create component:my_button
```

#### 在 lib/ui/screens/auth 目录下创建名为 login 的 Screen 文件

```bash
getx create screen:auth:login
```

## 📃 许可证

MIT License

**改进说明:**

- 使用更清晰的标题和段落结构。
- 添加了特性列表。
- 详细说明了初始化命令的功能和目录结构。
- 提供了更详细的创建文件命令的说明和示例。

希望这个格式更加清晰易懂！
