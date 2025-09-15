import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_constants.dart';

class RecipeInfoCard extends StatelessWidget {
  final int servings;
  final int prepTimeMinutes;
  final int cookTimeMinutes;

  const RecipeInfoCard({
    super.key,
    required this.servings,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppTheme.marginMedium, vertical: AppTheme.marginSmall),
      padding: const EdgeInsets.all(AppTheme.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _InfoColumn(
            title: AppConstants.servingsHeader,
            value: '$servings',
          ),
          _InfoColumn(
            title: AppConstants.prepTimeHeader,
            value: '$prepTimeMinutes min',
          ),
          _InfoColumn(
            title: AppConstants.cookTimeHeader,
            value: '$cookTimeMinutes min',
          ),
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const _InfoColumn({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppTheme.headingMedium),
        const SizedBox(height: AppTheme.paddingSmall),
        Text(value, style: AppTheme.bodyLarge),
      ],
    );
  }
}