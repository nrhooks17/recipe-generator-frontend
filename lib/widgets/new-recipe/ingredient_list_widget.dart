import 'package:flutter/material.dart';
import 'package:recipe_generator/models/ingredient.dart';
import 'package:recipe_generator/widgets/new-recipe/recipe_list_widget.dart';

class IngredientListWidget extends RecipeListWidget {
  List<Ingredient> ingredients;
  final Function(String value, int index) changeAmount;
  final Function(String value, int index) changeUnitOfMeasurement;
  final Function(String value, int index) changeIngredientName;

  IngredientListWidget(
      {required super.controllers,
      required this.ingredients,
      required super.labelText,
      required super.addField,
      required super.removeField,
      required super.recipeListType,
      required this.changeAmount,
      required this.changeUnitOfMeasurement,
      required this.changeIngredientName,
      super.key});

  @override
  List<Widget> getListWidgets(int index) {
    return [
      Expanded(
        flex: 2, // Takes 2 parts of the space
        child: TextField(
          keyboardType:
          TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.right,
          decoration: InputDecoration(
              hintText: 'unit amount',
              labelText: 'Unit amount',
              border: OutlineInputBorder(),
              prefixIcon: IconButton(
                onPressed: () => removeField(index),
                icon: const Icon(Icons.remove_circle),
              )
          ),
          onChanged: (value) => changeAmount(value, index),
        ),
      ),
      SizedBox(width: 10), // Keep small fixed spacing between fields
      Expanded(
        flex: 3, // Takes 3 parts of the space
        child: TextField(
          decoration: InputDecoration(
          hintText: 'Unit of measurement',
          labelText: 'Unit',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => changeUnitOfMeasurement(value, index),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        flex: 7, // Takes 7 parts of the space
        child: TextField(
          decoration: InputDecoration(
            hintText: 'ingredient name',
            labelText: 'Ingredient',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => changeIngredientName(value, index),
        ),
      ),
    ];
  }
}
