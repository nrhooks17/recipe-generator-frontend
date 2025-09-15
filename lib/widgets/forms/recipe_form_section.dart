import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class RecipeFormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsets? padding;

  const RecipeFormSection({
    super.key,
    required this.title,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.marginMedium,
        vertical: AppTheme.marginSmall,
      ),
      padding: padding ?? const EdgeInsets.all(AppTheme.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(title, style: AppTheme.headingMedium),
            const SizedBox(height: AppTheme.paddingMedium),
          ],
          ...children,
        ],
      ),
    );
  }
}

class RecipeFormRow extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const RecipeFormRow({
    super.key,
    required this.children,
    this.spacing = AppTheme.paddingSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < children.length; i++) ...[
          Expanded(child: children[i]),
          if (i < children.length - 1) SizedBox(width: spacing),
        ],
      ],
    );
  }
}