# ⏳ Flutter Loading Kit

A comprehensive Flutter package for loading states, progress indicators, and overlay components with cross-platform support.

[![pub package](https://img.shields.io/pub/v/flutter_loading_kit.svg)](https://pub.dev/packages/flutter_loading_kit)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

- **📱 Cross-platform**: Native iOS/macOS and Material Design loading indicators
- **🎨 Customizable**: Extensive styling options for all components
- **🔄 Multiple Types**: Progress HUD, Loading Overlay, and custom indicators
- **♿ Accessible**: Proper focus handling and accessibility support
- **🌍 Localizable**: Full localization support for messages
- **⚡ Performance**: Optimized for smooth animations and interactions
- **🎯 Flexible**: Easy to integrate with existing loading states

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_loading_kit: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

```dart
import 'package:flutter_loading_kit/flutter_loading_kit.dart';

// Basic loading overlay
LoadingOverlay(
  isLoading: isProcessing,
  message: 'Loading...',
  child: YourContent(),
)

// Progress HUD
CustomProgressHud(
  isLoading: isProcessing,
  child: YourContent(),
)

// Extension method
YourContent().withLoadingOverlay(
  isLoading: isProcessing,
  message: 'Please wait...',
)
```

## 📖 Components

### LoadingOverlay

A reusable loading overlay widget that shows a centered loading indicator with a semi-transparent background.

```dart
LoadingOverlay(
  isLoading: isProcessing,
  message: 'Processing your request...',
  child: YourContent(),
  // Customization options
  color: Colors.black.withOpacity(0.7),
  backgroundColor: Colors.white,
  borderRadius: 16.0,
  padding: EdgeInsets.all(32),
  dismissible: false,
)
```

### CustomProgressHud

A cross-platform progress HUD that shows platform-appropriate loading indicators.

```dart
CustomProgressHud(
  isLoading: isProcessing,
  child: YourContent(),
  // Customization options
  backgroundColor: Colors.black,
  opacity: 0.8,
  color: Colors.black,
  dismissible: true,
  onDismiss: () => cancelOperation(),
)
```

### LoadingOverlayExtension

An extension method to easily wrap any widget with loading overlay functionality.

```dart
// Using the extension
YourContent().withLoadingOverlay(
  isLoading: isProcessing,
  message: 'Loading data...',
  color: Colors.blue.withOpacity(0.5),
  backgroundColor: Colors.white,
  borderRadius: 20.0,
  dismissible: true,
  onDismiss: () => handleDismiss(),
)
```

## 🎛️ Configuration Options

### LoadingOverlay Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isLoading` | `bool` | Required | Whether to show loading overlay |
| `child` | `Widget` | Required | Content to overlay |
| `message` | `String?` | `null` | Loading message text |
| `color` | `Color?` | `Colors.black` | Overlay background color |
| `backgroundColor` | `Color?` | `Theme.scaffoldBackgroundColor` | Loading card background |
| `progressIndicator` | `Widget?` | `CircularProgressIndicator` | Custom progress indicator |
| `messageStyle` | `TextStyle?` | `null` | Message text style |
| `borderRadius` | `double` | `12.0` | Loading card border radius |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(24)` | Loading card padding |
| `dismissible` | `bool` | `false` | Whether overlay can be dismissed |
| `onDismiss` | `VoidCallback?` | `null` | Dismiss callback |

### CustomProgressHud Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isLoading` | `bool` | Required | Whether to show progress HUD |
| `child` | `Widget` | Required | Content to overlay |
| `progressIndicator` | `Widget?` | Platform-specific | Custom progress indicator |
| `backgroundColor` | `Color?` | `Colors.black` | Overlay background color |
| `opacity` | `double` | `0.6` | Overlay opacity |
| `color` | `Color` | `Colors.black` | Overlay color |
| `dismissible` | `bool` | `false` | Whether HUD can be dismissed |
| `onDismiss` | `VoidCallback?` | `null` | Dismiss callback |

## 🎨 Customization Examples

### Custom Loading Theme

```dart
class MyLoadingTheme {
  static const primaryColor = Color(0xFF6366F1);
  static const overlayColor = Color(0x80000000);
  
  static LoadingOverlay customLoadingOverlay({
    required bool isLoading,
    required Widget child,
    String? message,
  }) {
    return LoadingOverlay(
      isLoading: isLoading,
      message: message,
      child: child,
      color: overlayColor,
      backgroundColor: Colors.white,
      borderRadius: 20.0,
      padding: EdgeInsets.all(32),
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        strokeWidth: 3,
      ),
    );
  }
  
  static CustomProgressHud customProgressHud({
    required bool isLoading,
    required Widget child,
  }) {
    return CustomProgressHud(
      isLoading: isLoading,
      child: child,
      backgroundColor: overlayColor,
      opacity: 0.8,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        strokeWidth: 4,
      ),
    );
  }
}
```

### Custom Progress Indicators

```dart
// Custom animated indicator
Widget customProgressIndicator() {
  return TweenAnimationBuilder<double>(
    duration: Duration(seconds: 2),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return CircularProgressIndicator(
        value: value,
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      );
    },
  );
}

// Custom loading animation
Widget customLoadingAnimation() {
  return SizedBox(
    width: 50,
    height: 50,
    child: Stack(
      children: [
        Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ),
        Center(
          child: Icon(
            Icons.cloud_upload,
            color: Colors.blue,
            size: 20,
          ),
        ),
      ],
    ),
  );
}
```

### State Management Integration

```dart
// With Bloc/Cubit
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state is DataLoading,
          message: state is DataLoading ? state.message : null,
          child: YourContent(),
        );
      },
    );
  }
}

// With Provider
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        return provider.isLoading
            ? LoadingOverlay(
                isLoading: true,
                message: provider.loadingMessage,
                child: YourContent(),
              )
            : YourContent();
      },
    );
  }
}
```

### Form Loading States

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isLoading = false;
  
  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    
    try {
      await authService.login(email, password);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      message: 'Signing you in...',
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(/* email field */),
              TextField(/* password field */),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 🌍 Localization

All text properties support localization:

```dart
LoadingOverlay(
  isLoading: isProcessing,
  message: S.of(context).loadingMessage,
  child: YourContent(),
)

CustomProgressHud(
  isLoading: isProcessing,
  child: YourContent(),
)
```

## 📱 Platform Behavior

### iOS/macOS
- Uses `CupertinoActivityIndicator` for native iOS styling
- Automatic platform-specific styling

### Android/Other Platforms
- Uses `CircularProgressIndicator` with Material Design styling
- Consistent with Material Design guidelines

## 🧪 Testing

The package includes comprehensive tests. Run them with:

```bash
flutter test
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Contributors and users who provide feedback

## 📞 Support

If you encounter any problems or have suggestions, please file an issue at the [GitHub repository](https://github.com/yourusername/flutter_loading_kit/issues).

---

Made with ❤️ for the Flutter community
