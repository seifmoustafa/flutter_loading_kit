import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Wraps content with a modal "blocking" loading overlay.
/// Shows a platform-appropriate spinner when [isLoading] is true:
///  • iOS/macOS → CupertinoActivityIndicator
///  • Android/others → CircularProgressIndicator
class CustomProgressHud extends StatelessWidget {
  /// Creates a [CustomProgressHud].
  const CustomProgressHud({
    super.key,
    required this.child,
    required this.isLoading,
    this.progressIndicator,
    this.backgroundColor,
    this.opacity = 0.6,
    this.color = Colors.black,
    this.dismissible = false,
    this.onDismiss,
  });

  /// The content over which the loading overlay is shown.
  final Widget child;

  /// Whether to block the UI and show the spinner.
  final bool isLoading;

  /// Custom progress indicator widget.
  /// If null, uses platform-appropriate default.
  final Widget? progressIndicator;

  /// Background color of the overlay.
  final Color? backgroundColor;

  /// Opacity of the overlay background.
  final double opacity;

  /// Color of the overlay background.
  final Color color;

  /// Whether the overlay can be dismissed by tapping.
  final bool dismissible;

  /// Callback when the overlay is dismissed.
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    Widget effectiveProgressIndicator = progressIndicator ??
        (Platform.isIOS || Platform.isMacOS
            ? const CupertinoActivityIndicator(radius: 16)
            : const CircularProgressIndicator());

    return Stack(
      children: [
        child,
        if (isLoading)
          ModalBarrier(
            color: (backgroundColor ?? color).withValues(alpha: opacity),
            dismissible: dismissible,
            onDismiss: dismissible ? onDismiss : null,
          ),
        if (isLoading)
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: effectiveProgressIndicator,
            ),
          ),
      ],
    );
  }
}
