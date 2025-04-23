import 'ingredient.dart';

class Recipe {
  String recipeName;
  String description;
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  List<Ingredient> ingredients;
  List<String> procedure;


  Recipe({
    required this.recipeName,
    required this.description,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.ingredients,
    required this.procedure,
  });

  // This method assigns values from the json object to a new recipe object.
  static Recipe fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredients = [];
    List<String> procedure = [];

    // grab ingredients from json object.
    for (var i = 0; i < json['ingredients'].length; i++) {

      ingredients.add(Ingredient.fromJson(json['ingredients'][i]));
    }

    // grab procedure from json object.
    for (var i = 0; i < json['procedure'].length; i++) {
      procedure.add(json['procedure'][i]);
    }

    return Recipe(
      recipeName: json['recipeName'],
      description: json['description'],
      prepTimeMinutes: json['prepTimeMinutes'],
      cookTimeMinutes: json['cookTimeMinutes'],
      servings: json['servings'],
      ingredients: ingredients,
      procedure: procedure,
    );
  }
}


