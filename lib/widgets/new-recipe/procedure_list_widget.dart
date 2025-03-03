import 'package:flutter/material.dart';
import 'package:recipe_generator/widgets/new-recipe/recipe_list_widget.dart';

class ProcedureListWidget extends RecipeListWidget {

  final Function(String value, int index) changeProcedureStep;

  ProcedureListWidget(
        {required super.controllers,
        required super.labelText,
        required super.addField,
        required super.removeField,
        required super.recipeListType,
        required this.changeProcedureStep,
        super.key});

  @override
  List<Widget> getListWidgets(index) {
    return [
      Expanded(
        child: TextField(
            controller: controllers[index],
            maxLines: null,
            decoration: InputDecoration(
                hintText: 'Enter $recipeListLabel',
                suffixIcon: IconButton(
                    onPressed: controllers[index].clear,
                    icon: const Icon(Icons.clear)),
                prefixIcon: IconButton(
                    onPressed: () => removeField(index),
                    icon: const Icon(Icons.remove_circle)
                )
            ),
            onChanged: (value) => changeProcedureStep(value, index)
        ),
      ),
    ];
  }
}
