import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.icon,
    this.obscureToggle = false,
    this.keyboardType,
    this.onSubmitted,
    this.filled = true,
  });

  final String hint;
  final TextEditingController? controller;
  final IconData? icon;
  final bool obscureToggle;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onSubmitted;

  /// true = fond rempli (écrans clairs), false = pensé pour fond sombre.
  final bool filled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.filled
        ? AppColors.surfaceAlt
        : AppColors.darkSurface;
    final textColor = widget.filled
        ? AppColors.textPrimary
        : AppColors.textOnDark;

    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureToggle && _obscured,
      keyboardType: widget.keyboardType,
      onSubmitted: widget.onSubmitted,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: textColor.withOpacity(0.45)),
        filled: true,
        fillColor: backgroundColor,
        prefixIcon: widget.icon != null
            ? Icon(widget.icon, size: 20, color: textColor.withOpacity(0.6))
            : null,
        suffixIcon: widget.obscureToggle
            ? IconButton(
                icon: Icon(
                  _obscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: textColor.withOpacity(0.6),
                ),
                onPressed: () => setState(() => _obscured = !_obscured),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
