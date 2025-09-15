import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe.dart';
import '../models/ingredient.dart';
import '../config/app_constants.dart';

class RecipeApiService {
  static final RecipeApiService _instance = RecipeApiService._internal();
  factory RecipeApiService() => _instance;
  RecipeApiService._internal();

  Future<Recipe?> getRandomRecipe() async {
    try {
      final response = await http.get(Uri.parse(AppConstants.randomRecipeEndpoint));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        return Recipe.fromJson(responseBody);
      }
      return null;
    } catch (error, stacktrace) {
      print('Error retrieving recipe: $error');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }

  Future<bool> submitRecipe({
    required String recipeName,
    required String description,
    required int prepTimeMinutes,
    required int cookTimeMinutes,
    required int servings,
    required List<Ingredient> ingredients,
    required List<String> procedure,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(AppConstants.submitRecipeEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'recipeName': recipeName,
          'description': description,
          'prepTimeMinutes': prepTimeMinutes,
          'cookTimeMinutes': cookTimeMinutes,
          'servings': servings,
          'ingredients': ingredients,
          'procedure': procedure,
        }),
      );

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (error, stacktrace) {
      print('Error submitting recipe: $error');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }
}