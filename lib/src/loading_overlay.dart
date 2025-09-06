import 'package:flutter/material.dart';

/// A reusable loading overlay widget that shows a centered loading indicator
/// with a semi-transparent background to prevent user interaction
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.color,
    this.backgroundColor,
    this.progressIndicator,
    this.messageStyle,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(24),
    this.dismissible = false,
    this.onDismiss,
  });

  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? color;
  final Color? backgroundColor;
  final Widget? progressIndicator;
  final TextStyle? messageStyle;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool dismissible;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          GestureDetector(
            onTap: dismissible ? onDismiss : null,
            child: Container(
              color: (color ?? Colors.black).withValues(alpha: 0.5),
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // Prevent tap from propagating
                  child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                      color: backgroundColor ??
                          Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        progressIndicator ??
                            const SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                        if (message != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            message!,
                            style: messageStyle ??
                                Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Extension to easily wrap any widget with loading overlay
extension LoadingOverlayExtension on Widget {
  Widget withLoadingOverlay({
    required bool isLoading,
    String? message,
    Color? color,
    Color? backgroundColor,
    Widget? progressIndicator,
    TextStyle? messageStyle,
    double borderRadius = 12.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24),
    bool dismissible = false,
    VoidCallback? onDismiss,
  }) {
    return LoadingOverlay(
      isLoading: isLoading,
      message: message,
      color: color,
      backgroundColor: backgroundColor,
      progressIndicator: progressIndicator,
      messageStyle: messageStyle,
      borderRadius: borderRadius,
      padding: padding,
      dismissible: dismissible,
      onDismiss: onDismiss,
      child: this,
    );
  }
}
