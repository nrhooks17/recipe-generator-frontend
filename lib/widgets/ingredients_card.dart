import 'package:flutter/material.dart';
import '../models/ingredient.dart';
import '../config/app_theme.dart';
import '../config/app_constants.dart';

class IngredientsCard extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientsCard({
    super.key,
    required this.ingredients,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.ingredientsHeader,
            style: AppTheme.headingMedium,
          ),
          const SizedBox(height: AppTheme.paddingSmall),
          ...ingredients.map((ingredient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: AppTheme.bodyLarge),
                    Text(
                      ingredient.amount.toString(),
                      style: AppTheme.bodyLarge,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      ingredient.unitOfMeasurement,
                      style: AppTheme.bodyLarge,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        ingredient.ingredientName,
                        style: AppTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}