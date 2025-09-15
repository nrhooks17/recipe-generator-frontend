import 'package:flutter/material.dart';
import 'package:recipe_generator/models/recipe.dart';
import '../services/recipe_api_service.dart';
import '../config/app_constants.dart';

class RecipeProvider extends ChangeNotifier {
  final RecipeApiService _apiService = RecipeApiService();
  
  Recipe _recipe = Recipe(
    recipeName: '',
    description: '',
    prepTimeMinutes: 0,
    cookTimeMinutes: 0,
    servings: 0,
    ingredients: [],
    procedure: [],
  );

  Recipe get recipe => _recipe;

  // grab random recipe from backend
  Future<void> getRandomRecipe(BuildContext context) async {
    try {
      final recipe = await _apiService.getRandomRecipe();
      if (recipe != null) {
        _recipe = recipe;
        notifyListeners();
      }
    } catch (error, stacktrace) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${AppConstants.errorRetrievingRecipe}$error')));
        print('${AppConstants.errorRetrievingRecipe}$error');
        print('Stacktrace: $stacktrace');
      }
    }
  }
}