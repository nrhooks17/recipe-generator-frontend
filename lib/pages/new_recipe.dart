import 'package:flutter/material.dart';
import '../utils/alert.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({super.key});

  @override
  State<NewRecipe> createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  // List of TextEditingController for recipe ingredients
  final List<TextEditingController> _recipeIngredientTextControllers =
      <TextEditingController>[TextEditingController()];

  // List of TextEditingController for recipe procedure
  final List<TextEditingController> _recipeProcedureTextControllers =
      <TextEditingController>[TextEditingController()];

  // Add a new recipe ingredient field
  void addRecipeIngredientField() {
    setState(() {
      _recipeIngredientTextControllers.add(TextEditingController());
    });
  }

  void addRecipeProcedureField() {
    setState(() {
      _recipeProcedureTextControllers.add(TextEditingController());
    });
  }

  // Remove a recipe ingredient field
  void removeRecipeIngredientField(int index) {
    setState(() {
      _recipeIngredientTextControllers.removeAt(index);
    });
  }

  // Remove a recipe procedure field
  void removeRecipeProcedureField(int index) {
    setState(() {
      _recipeProcedureTextControllers.removeAt(index);
    });
  }

  // Build a list of recipe ingredient or procedure widgets
  Widget buildRecipeListWidget(

      List<TextEditingController> controllers,
      String labelText,
      void Function() addField,
      void Function(int) removeField,
      String recipeListType) {

    String recipeListLabel = "";
    switch (recipeListType.toLowerCase()) {
      case 'ingredient':
        recipeListLabel = "Ingredient";
        break;
      case 'procedure':
        recipeListLabel = "Procedure Step";
        break;

    }

    return Padding(
      padding:  EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Enter ${recipeListLabel}s',
                      style: TextStyle(fontSize: 30)),
                  ElevatedButton(
                    onPressed: () => addRecipeIngredientField(),
                    child: Text('Add Ingredient'),
                  ),
                ]),
          ),
          SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _recipeIngredientTextControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 800,
                          child: TextField(
                              controller:
                                  _recipeIngredientTextControllers[index],
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Ingredient',
                                labelText: 'Ingredient',
                                suffixIcon: Icon(Icons.remove),
                              )),
                        ),
                        TextButton.icon(
                          label: Text('Remove'),
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => removeRecipeIngredientField(index),
                        )
                      ], // children
                    ),
                  );
                },
              ))
        ],
      ),
    );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter recipe name',
                      labelText: 'Recipe Name',
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Cooking Procedure',
                      labelText: 'Cooking Procedure',
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => AlertUtil.showAlert(context),
              child: const Text('Save Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
