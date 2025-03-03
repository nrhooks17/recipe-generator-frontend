import 'package:flutter/material.dart';

abstract class RecipeListWidget extends StatelessWidget {
  final List<TextEditingController> controllers;
  final String labelText;
  final void Function() addField;
  final void Function(int index) removeField;
  final String recipeListType;
  String? recipeListLabel;

   RecipeListWidget(
      {required this.controllers,
        required this.labelText,
        required this.addField,
        required this.removeField,
        required this.recipeListType,
        super.key}){

     recipeListLabel = getRecipeLabelType();
   }

 // This method is for creating the widgets that will stay inside
  List<Widget> getListWidgets(int index);

  String getRecipeLabelType() {
    String recipeListLabel = "";
    switch (recipeListType.toLowerCase()) {
      case 'ingredient':
        recipeListLabel = "Ingredient";
        break;
      case 'procedure':
        recipeListLabel = "Procedure Step";
        break;
    }

    return recipeListLabel;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child:
            Wrap(alignment: WrapAlignment.start, spacing: 15.0, children: [
              Text('Enter ${recipeListLabel}s',
                  style: const TextStyle(fontSize: 30)),
            ]),
          ),
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: getListWidgets(index), // children
                    ), //row
                  ); //padding
                },
              ), // listview.builder
            ], // children
          ),
          ElevatedButton(
              onPressed: () => addField(), child: Text('Add $recipeListLabel')),
        ],
      ),
    );
  }
}
