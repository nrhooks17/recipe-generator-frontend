import 'package:flutter/material.dart';
import 'package:recipe_generator/providers/recipe_provider.dart';

class ViewRecipe extends StatefulWidget {
  const ViewRecipe({super.key}); // TODO: implement

  @override
  State<ViewRecipe> createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  late RecipeProvider _recipeProvider;

  @override
  void initState() {
    super.initState();
    _recipeProvider = RecipeProvider();
    _recipeProvider.addListener(() {
      setState(() {});
    });
    _recipeProvider.getRandomRecipe(context);
  }

  @override
  void dispose() {
    _recipeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Recipe')),
      body: SingleChildScrollView(
        child: Transform.scale(
          scale: 0.9,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            _recipeProvider.recipe.recipeName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _recipeProvider.getRandomRecipe(context);
                        },
                        child: const Text('Generate Recipe'),
                      ),
                    ],
                  ),
                ),

                // Recipe info row
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text('Servings', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${_recipeProvider.recipe.servings}'),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Prep Time', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${_recipeProvider.recipe.prepTimeMinutes} min'),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Cook Time', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${_recipeProvider.recipe.cookTimeMinutes} min'),
                        ],
                      ),
                    ],
                  ),
                ),

                // Row 2: Ingredients container
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ..._recipeProvider.recipe.ingredients.map((ingredient) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ',
                                    style: TextStyle(fontSize: 16)),
                                Text((ingredient.amount.toString()),
                                    style: const TextStyle(fontSize: 16)),
                                SizedBox(width: 5),
                                Text(ingredient.unitOfMeasurement,
                                    style: const TextStyle(fontSize: 16)),
                                SizedBox(width: 5),
                                Text(ingredient.ingredientName,
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),

                // Row 3: Procedure steps
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Procedure',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(
                          _recipeProvider.recipe.procedure.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: Text(_recipeProvider.recipe.procedure[index])),
                                  ],
                                ),
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
