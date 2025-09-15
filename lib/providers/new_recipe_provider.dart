import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/ingredient.dart';
import '../main.dart';

class NewRecipeProvider extends ChangeNotifier {
  // List of TextEditingController for recipe ingredients
  final List<TextEditingController> _recipeIngredientTextControllers =
      <TextEditingController>[TextEditingController()];
  final List<Ingredient> _ingredients = [
    Ingredient(amount: 0, unitOfMeasurement: "", ingredientName: "")
  ];

  // List of TextEditingController for recipe procedure
  final List<TextEditingController> _recipeProcedureTextControllers =
      <TextEditingController>[TextEditingController()];
  final List<String> _procedure = [""];
  String _recipeName = "";
  String _description = "";
  int _prepTimeMinutes = 0;
  int _cookTimeMinutes = 0;
  int _servings = 0;

  // loading state
  bool _isLoading = false;

  // Getters
  List<TextEditingController> get recipeIngredientTextControllers => _recipeIngredientTextControllers;
  List<Ingredient> get ingredients => _ingredients;
  List<TextEditingController> get recipeProcedureTextControllers => _recipeProcedureTextControllers;
  List<String> get procedure => _procedure;
  String get recipeName => _recipeName;
  String get description => _description;
  int get prepTimeMinutes => _prepTimeMinutes;
  int get cookTimeMinutes => _cookTimeMinutes;
  int get servings => _servings;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    for (var controller in _recipeIngredientTextControllers) {
      controller.dispose();
    }
    for (var controller in _recipeProcedureTextControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  //function that sends the data to the backend.
  Future<void> submitRecipe(BuildContext context) async {
    try {
      // Set loading state to true
      _isLoading = true;
      notifyListeners();

      final response = await http.post(
        Uri.parse("http://localhost:8080/recipe/submit"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'recipeName': _recipeName,
          'description': _description,
          'prepTimeMinutes': _prepTimeMinutes,
          'cookTimeMinutes': _cookTimeMinutes,
          'servings': _servings,
          'ingredients': _ingredients,
          'procedure': _procedure,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (context.mounted) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);

          // show snackbar success message.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  '$_recipeName has been submitted successfully.')));

          // Navigate back to the home page after recipe submission.
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const MyHomePage(title: 'Recipe Generator')),
          );
        }
      } else {
        throw Exception("Failed to submit recipe data: ${response.statusCode}");
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error submitting recipe data: $error')));
      }
    } finally {
      if (context.mounted) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // lots of state management here. but app isn't that complex. Next app i'll use something more complex
  // Add a new recipe ingredient field
  void addRecipeIngredientField() {
    _recipeIngredientTextControllers.add(TextEditingController());
    _ingredients.add(
        Ingredient(amount: 0, unitOfMeasurement: "", ingredientName: ""));
    notifyListeners();
  }

  void addRecipeProcedureField() {
    _recipeProcedureTextControllers.add(TextEditingController());
    _procedure.add("");
    notifyListeners();
  }

  // Remove a recipe ingredient field
  void removeRecipeIngredientField(int index) {
    _recipeIngredientTextControllers.removeAt(index);
    _ingredients.removeAt(index);
    notifyListeners();
  }

  // Remove a recipe procedure field on field removal.
  void removeRecipeProcedureField(int index) {
    _recipeProcedureTextControllers.removeAt(index);
    _procedure.removeAt(index);
    notifyListeners();
  }

  // onChange for amount textfield
  void changeAmount(String value, int index) {
    Ingredient ingredient = _ingredients.elementAt(index);

    // if the value is empty, then a
    if (value == "") {
      ingredient.amount = 0;
    } else {
      ingredient.amount = double.tryParse(value) ?? 0.0;
    }
    _ingredients[index] = ingredient;
  }

  // onChange for unitOfmeasurement textfield
  void changeUnitOfMeasurement(String value, int index) {
    Ingredient ingredient = _ingredients.elementAt(index);
    ingredient.unitOfMeasurement = value;
    _ingredients[index] = ingredient;
  }

  // onChange for IngredientName textfield
  void changeIngredientName(String value, int index) {
    Ingredient ingredient = _ingredients.elementAt(index);
    ingredient.ingredientName = value;
    _ingredients[index] = ingredient;
  }

  // onChange for changing a procedure step.
  void changeProcedureStep(String value, int index) {
    _procedure[index] = value;
  }

  // onchange for recipeName
  void changeRecipeName(String value) {
    _recipeName = value;
  }

  void changeDescription(String value) {
    _description = value;
  }

  void changePrepTimeMinutes(String value) {
    if (value.isEmpty) return;
    _prepTimeMinutes = int.tryParse(value) ?? 0;
  }

  void changeCookTimeMinutes(String value) {
    if (value.isEmpty) return;
    _cookTimeMinutes = int.tryParse(value) ?? 0;
  }

  void changeServings(String value) {
    if (value.isEmpty) return;
    _servings = int.tryParse(value) ?? 0;
  }
}