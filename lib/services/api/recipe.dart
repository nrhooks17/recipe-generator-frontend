import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:recipe_generator/models/recipe.dart';

class RecipeService {
	
  // grab random recipe from backend
  Future<Recipe> getRandomRecipe() async {
    try{
      // grab recipe from backend
      final response = await http.get(Uri.parse("http://localhost:8080/recipe/random"));

      if (response.statusCode == 200) {
      // debug
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        //set the recipe after getting it from the backend.

	return Recipe.fromJson(responseBody);
      }
    } catch (error, stacktrace) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error retrieving recipe: $error'))
        );
        print('Error retrieving recipe: $error');
        print('Stacktrace: $stacktrace');
      }
    }
  }

}
