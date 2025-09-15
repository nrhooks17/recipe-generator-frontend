import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recipe_generator/widgets/new-recipe/ingredient_list_widget.dart';
import 'package:recipe_generator/widgets/new-recipe/procedure_list_widget.dart';
import '../models/ingredient.dart';
import '../main.dart';
import '../pages/view_recipe.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({super.key});

  @override
  State<NewRecipe> createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
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

  //function that sends the data to the backend.

  Future<void> submitRecipe() async {
    try {
      // Set loading state to true
      setState(() {
        _isLoading = true;
      });

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

      if (response.statusCode == 200) {
        if (mounted) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);

          // show snackbar success message.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  '${responseBody['recipeName']} has been submitted successfully.')));

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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error submitting recipe data: $error')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // lots of state management here. but app isn't that complex. Next app i'll use something more complex
  // Add a new recipe ingredient field
  void addRecipeIngredientField() {
    setState(() {
      _recipeIngredientTextControllers.add(TextEditingController());
      _ingredients.add(
          Ingredient(amount: 0, unitOfMeasurement: "", ingredientName: ""));
    });
  }

  void addRecipeProcedureField() {
    setState(() {
      _recipeProcedureTextControllers.add(TextEditingController());
      _procedure.add("");
    });
  }

  // Remove a recipe ingredient field
  void removeRecipeIngredientField(int index) {
    setState(() {
      _recipeIngredientTextControllers.removeAt(index);
      _ingredients.removeAt(index);
    });
  }

  // Remove a recipe procedure field on field removal.
  void removeRecipeProcedureField(int index) {
    setState(() {
      _recipeProcedureTextControllers.removeAt(index);
      _procedure.removeAt(index);
    });
  }

  // onChange for amount textfield
  void changeAmount(String value, int index) {
    Ingredient ingredient = _ingredients.elementAt(index);

    // if the value is empty, then a
    if (value == "") {
      ingredient.amount = 0;
    } else {
      ingredient.amount = double.parse(value);
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
    _prepTimeMinutes = int.parse(value);
  }

  void changeCookTimeMinutes(String value) {
    _cookTimeMinutes = int.parse(value);
  }

  void changeServings(String value) {
    _servings = int.parse(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Recipe'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewRecipe()),
                  );
                },
                child: const Text('Select Random Recipe'),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Transform.scale(
              scale: 0.9,
              child: Center(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: getNewRecipePadding(),
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter recipe name',
                                      labelText: 'Recipe Name',
                                    ),
                                    onChanged: (value) =>
                                        changeRecipeName(value),
                                  ),
                                ], //children
                              ),
                            ),
                            Padding(
                              padding: getNewRecipePadding(),
                              child: Column(
                                children: [
                                  TextField(
                                      maxLines: null,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter recipe description',
                                          labelText: 'Description'),
                                      onChanged: (value) =>
                                          changeDescription(value)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getNewRecipePadding(),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter prep time',
                                            labelText: 'Prep Time(min)'),
                                        onChanged: (value) =>
                                            changePrepTimeMinutes(value)),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter cook time',
                                          labelText: 'Cook Time(min)'),
                                      onChanged: (value) =>
                                          changeCookTimeMinutes(value),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter servings',
                                          labelText: 'Servings'),
                                      onChanged: (value) =>
                                          changeServings(value),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getNewRecipePadding(),
                              child: Column(
                                children: <Widget>[
                                  //change this list so that it has 3 textboxes instead of 1.
                                  IngredientListWidget(
                                      controllers:
                                          _recipeIngredientTextControllers,
                                      ingredients: _ingredients,
                                      labelText: "Ingredient",
                                      addField: addRecipeIngredientField,
                                      removeField: removeRecipeIngredientField,
                                      changeAmount: changeAmount,
                                      changeUnitOfMeasurement:
                                          changeUnitOfMeasurement,
                                      changeIngredientName:
                                          changeIngredientName,
                                      recipeListType: 'ingredient')
                                ],
                              ),
                            ),
                            Padding(
                              padding: getNewRecipePadding(),
                              child: Column(
                                children: <Widget>[
                                  ProcedureListWidget(
                                    controllers:
                                        _recipeProcedureTextControllers,
                                    labelText: "Procedure",
                                    addField: addRecipeProcedureField,
                                    removeField: removeRecipeProcedureField,
                                    recipeListType: 'procedure',
                                    changeProcedureStep: changeProcedureStep,
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: submitRecipe,
                              child: const Text('Save Recipe'),
                            ),
                          ],
                        ))),
        ));
  }

  EdgeInsets getNewRecipePadding() {
    return const EdgeInsets.only(top: 10, left: 10, right: 10);
  }
}
