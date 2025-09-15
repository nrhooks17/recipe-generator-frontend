import 'package:flutter/material.dart';
import 'package:recipe_generator/widgets/new-recipe/ingredient_list_widget.dart';
import 'package:recipe_generator/widgets/new-recipe/procedure_list_widget.dart';
import 'package:recipe_generator/providers/new_recipe_provider.dart';
import '../pages/view_recipe.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({super.key});

  @override
  State<NewRecipe> createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  late NewRecipeProvider _newRecipeProvider;

  @override
  void initState() {
    super.initState();
    _newRecipeProvider = NewRecipeProvider();
    _newRecipeProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _newRecipeProvider.dispose();
    super.dispose();
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
                  child: _newRecipeProvider.isLoading
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
                                        _newRecipeProvider.changeRecipeName(value),
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
                                          _newRecipeProvider.changeDescription(value)),
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
                                            _newRecipeProvider.changePrepTimeMinutes(value)),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter cook time',
                                          labelText: 'Cook Time(min)'),
                                      onChanged: (value) =>
                                          _newRecipeProvider.changeCookTimeMinutes(value),
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
                                          _newRecipeProvider.changeServings(value),
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
                                          _newRecipeProvider.recipeIngredientTextControllers,
                                      ingredients: _newRecipeProvider.ingredients,
                                      labelText: "Ingredient",
                                      addField: _newRecipeProvider.addRecipeIngredientField,
                                      removeField: _newRecipeProvider.removeRecipeIngredientField,
                                      changeAmount: _newRecipeProvider.changeAmount,
                                      changeUnitOfMeasurement:
                                          _newRecipeProvider.changeUnitOfMeasurement,
                                      changeIngredientName:
                                          _newRecipeProvider.changeIngredientName,
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
                                        _newRecipeProvider.recipeProcedureTextControllers,
                                    labelText: "Procedure",
                                    addField: _newRecipeProvider.addRecipeProcedureField,
                                    removeField: _newRecipeProvider.removeRecipeProcedureField,
                                    recipeListType: 'procedure',
                                    changeProcedureStep: _newRecipeProvider.changeProcedureStep,
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _newRecipeProvider.submitRecipe(context),
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
