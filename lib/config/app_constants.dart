class AppConstants {
  // API URLs
  static const String baseUrl = 'http://localhost:8080';
  static const String randomRecipeEndpoint = '$baseUrl/recipe/random';
  static const String submitRecipeEndpoint = '$baseUrl/recipe/submit';

  // App Strings
  static const String appTitle = 'Recipe Generator';
  static const String newRecipeTitle = 'New Recipe';
  static const String viewRecipeTitle = 'Select Recipe';
  
  // Button Labels
  static const String generateRecipeButton = 'Generate Recipe';
  static const String saveRecipeButton = 'Save Recipe';
  static const String selectRandomRecipeButton = 'Select Random Recipe';
  static const String generateFromAIButton = 'Generate Recipe from AI';
  static const String storeNewRecipeButton = 'Store New Recipe';
  static const String selectStoredRecipeButton = 'Select Stored Recipe';

  // Form Labels
  static const String recipeNameLabel = 'Recipe Name';
  static const String descriptionLabel = 'Description';
  static const String prepTimeLabel = 'Prep Time(min)';
  static const String cookTimeLabel = 'Cook Time(min)';
  static const String servingsLabel = 'Servings';
  static const String ingredientLabel = 'Ingredient';
  static const String procedureLabel = 'Procedure';
  static const String unitAmountLabel = 'Unit amount';
  static const String unitLabel = 'Unit';

  // Hints
  static const String recipeNameHint = 'Enter recipe name';
  static const String descriptionHint = 'Enter recipe description';
  static const String numbersOnlyHint = 'Enter numbers only';
  static const String enterNumberHint = 'Enter number';
  static const String unitOfMeasurementHint = 'Unit of measurement';
  static const String ingredientNameHint = 'ingredient name';

  // Section Headers
  static const String servingsHeader = 'Servings';
  static const String prepTimeHeader = 'Prep Time';
  static const String cookTimeHeader = 'Cook Time';
  static const String ingredientsHeader = 'Ingredients';
  static const String procedureHeader = 'Procedure';
  static const String descriptionHeader = 'Description';

  // Messages
  static const String recipeSubmittedSuccess = 'has been submitted successfully.';
  static const String errorRetrievingRecipe = 'Error retrieving recipe: ';
  static const String errorSubmittingRecipe = 'Error submitting recipe data: ';
  static const String generateRandomRecipeMessage = 'Generating a random recipe...';

  // Validation limits
  static const int maxPrepTime = 1440; // 24 hours in minutes
  static const int maxCookTime = 1440;
  static const int maxServings = 100;
  static const double maxAmount = 999.99;

  // UI Configuration
  static const double transformScale = 0.9;
  static const int timeUnits = 1; // minutes
}