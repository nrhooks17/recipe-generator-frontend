import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_constants.dart';

class RecipeHeader extends StatelessWidget {
  final String recipeName;
  final String description;
  final VoidCallback onGeneratePressed;

  const RecipeHeader({
    super.key,
    required this.recipeName,
    required this.description,
    required this.onGeneratePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  recipeName,
                  style: AppTheme.headingLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.paddingSmall),
                Text(
                  description,
                  style: AppTheme.description,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTheme.paddingMedium),
          ElevatedButton(
            onPressed: onGeneratePressed,
            child: const Text(AppConstants.generateRecipeButton),
          ),
        ],
      ),
    );
  }
}