import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recipe_generator/widgets/new-recipe/ingredient_list_widget.dart';
import 'package:recipe_generator/widgets/new-recipe/procedure_list_widget.dart';
import '../utils/alert.dart';
import '../models/ingredient.dart';


class NewRecipe extends StatefulWidget {
  const NewRecipe({super.key});

  @override
  State<NewRecipe> createState() => _NewRecipeState();
}


class _NewRecipeState extends State<NewRecipe> {
  // List of TextEditingController for recipe ingredients
  final List<TextEditingController> _recipeIngredientTextControllers =
      <TextEditingController>[TextEditingController()];
  final List<Ingredient> _ingredients = [Ingredient(amount: 0, unitOfMeasurement: "", ingredientName: "")];

  // List of TextEditingController for recipe procedure
  final List<TextEditingController> _recipeProcedureTextControllers =
      <TextEditingController>[TextEditingController()];
  final List<String> _procedure = [""];
  String _recipeName = "";

  // loading state
  bool isLoading = false;

  //function that sends the data to the backend.

  Future<void> submitRecipe() async{
    try {

      final response = await http.post(
        Uri.parse("http://localhost:3000"),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'recipeName': _recipeName,
          'ingredients': _ingredients,
          'procedure': _procedure,
        }),
      );
    } catch (error) {

      // 10, 25, 35, 35, 60
    } finally {

    }
  }


  // lots of state management here. but app isn't that complex. Next app i'll use something more complex
  // Add a new recipe ingredient field
  void addRecipeIngredientField() {
    setState(() {
      _recipeIngredientTextControllers.add(TextEditingController());
      _ingredients.add(Ingredient(amount: 0, unitOfMeasurement:  "", ingredientName: ""));
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
  void changeAmount(String value, int index){
    Ingredient ingredient = _ingredients.elementAt(index);
    ingredient.amount = double.parse(value);
    _ingredients[index] = ingredient;
  }
  // onChange for unitOfmeasurement textfield
  void changeUnitOfMeasurement(String value, int index){
    Ingredient ingredient = _ingredients.elementAt(index);
    ingredient.unitOfMeasurement = value;
    _ingredients[index] = ingredient;
  }

  // onChange for IngredientName textfield
  void changeIngredientName(String value, int index){
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
                  AlertUtil.showAlert(context);
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
                  child: Column(
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
                          onChanged: (value) => changeRecipeName(value),
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
                            controllers: _recipeIngredientTextControllers,
                            ingredients: _ingredients,
                            labelText: "Ingredient",
                            addField: addRecipeIngredientField,
                            removeField: removeRecipeIngredientField,
                            changeAmount: changeAmount,
                            changeUnitOfMeasurement: changeUnitOfMeasurement,
                            changeIngredientName: changeIngredientName,
                            recipeListType: 'ingredient')
                      ],
                    ),
                  ),
                  Padding(
                    padding: getNewRecipePadding(),
                    child: Column(
                      children: <Widget>[
                        ProcedureListWidget(
                          controllers: _recipeProcedureTextControllers,
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
                    onPressed: () => AlertUtil.showAlert(context),
                    child: const Text('Save Recipe'),
                  ),
                ],
              ))),
        ));
  }

  EdgeInsets getNewRecipePadding() {
    return const EdgeInsets.only(top: 1, left: 10, right: 10);
  }
}
