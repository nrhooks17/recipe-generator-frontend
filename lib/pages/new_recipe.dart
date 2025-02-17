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
      String recipeListType
      ) {

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
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 15.0,
                children: [
                  Text('Enter ${recipeListLabel}s',
                      style: const TextStyle(fontSize: 30)
                  ),
                ]),
          ),
          Column(
              children:  [
                   ListView.builder(
                    shrinkWrap: true,
                    itemCount: controllers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                  controller: controllers[index],
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: 'Enter $recipeListLabel',
                                    suffixIcon: IconButton(
                                      onPressed: controllers[index].clear,
                                      icon: const Icon(Icons.clear)
                                    ),
                                    prefixIcon: IconButton(
                                      onPressed: () => removeField(index),
                                      icon: const Icon(Icons.remove_circle)
                                    )
                                  )),
                            ),
                          ], // children
                        ), //row
                      ); //padding
                    },
                  ),// listview.builder
            ], // children
          ),
          ElevatedButton(
              onPressed: () => addField(),
              child: Text('Add $recipeListLabel')
          ),
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
      body: SingleChildScrollView(
        child: Transform.scale(
            scale: 0.9,
            child: Center(
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: getNewRecipePadding(),
                      child: const Column(
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
                    Padding(
                      padding: getNewRecipePadding(),
                      child: Column(
                        children: <Widget>[
                          //change this list so that it has 3 textboxes instead of 1.
                          buildRecipeListWidget(_recipeIngredientTextControllers, "Ingredient", addRecipeIngredientField, removeRecipeIngredientField, 'ingredient')
                        ],
                      ),
                    ),
                    Padding(
                      padding: getNewRecipePadding(),
                      child: Column(
                        children: <Widget>[
                          buildRecipeListWidget(_recipeProcedureTextControllers, "Procedure", addRecipeProcedureField, removeRecipeProcedureField, 'procedure')
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => AlertUtil.showAlert(context),
                      child: const Text('Save Recipe'),
                    ),
                  ],
                )
            )
        ),
      )
    );
  }

  EdgeInsets getNewRecipePadding() {
    return const EdgeInsets.only(top: 1, left: 10, right: 10);
  }
}
