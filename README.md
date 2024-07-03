# GetX CLI

A command-line interface (CLI) tool for simplifying GetX project development. It helps you quickly generate project structures, screens, components, services, models, and repositories, accelerating your Flutter development workflow with GetX.

## ✨ Features

- **Initialize GetX Project:** Quickly set up a complete GetX project structure.
- **Create Multiple Files:** Easily create Screen, Component, Service, Model, and Repository files.
- **Customizable Paths:** Choose the file creation path freely and organize your code by modules.
- **Modular Creation:** Use the `module:name` format to specify the module and file name, e.g., `screen:my_screen`.

## 🚀 Installation

```bash
dart pub global activate getx_cli
```

## 💻 Usage

### Initialize GetX Project

```bash
getx init
```

This will create a new GetX project in the current directory with the following directory structure:

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
│   │   └── ... (service files)
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
│   │   └── ... (model files)
│   └── repositories
│       └── ... (repository files)
├── routes
│   ├── app_pages.dart
│   ├── app_routes.dart
│   ├── bindings
│   │   └── app_binding.dart
│   └── ... (other module route files, e.g., auth_routes.dart, home_routes.dart)
└── ui
    ├── controllers
    │   └── ... (controller files)
    ├── screens
    │   └── ... (screen files)
    └── widgets
        └── ... (component files)
```

### Create Files

You can use the following command to create different GetX files:

```bash
getx create <module>:<name>
```

Where:

- `<module>` is the module name, optional values include:
  - `screen`: Create a Screen file, the default path is `lib/ui/screens`.
  - `component`: Create a Component file, the default path is `lib/ui/widgets`.
  - `service`: Create a Service file, the default path is `lib/core/services`.
  - `model`: Create a Model file, the default path is `lib/data/models`.
  - `repository`: Create a Repository file, the default path is `lib/data/repositories`.
- `<name>` is the file name, e.g., `my_screen`, `my_button`.

**Examples:**

```bash
getx create screen:my
```

```bash
getx create component:my_button
```

```bash
getx create screen:auth:login
```

## 📃 License

MIT License

我已经将所有中文字符替换成了英文，并对格式进行了微调。 现在这个 `README.md` 文件应该能够满足 pub.dev 的发布要求了。
# anicom_privacy_policy
