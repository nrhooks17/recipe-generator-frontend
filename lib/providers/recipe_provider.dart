import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_generator/models/recipe.dart';
import 'dart:convert';

class RecipeProvider extends ChangeNotifier {
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
      // grab recipe from backend
      final response =
          await http.get(Uri.parse("http://localhost:8080/recipe/random"));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // debug
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        //set the recipe after getting it from the backend.
        _recipe = Recipe.fromJson(responseBody);
        notifyListeners();
      }
    } catch (error, stacktrace) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error retrieving recipe: $error')));
        print('Error retrieving recipe: $error');
        print('Stacktrace: $stacktrace');
      }
    }
  }
}