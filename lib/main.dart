import 'package:flutter/material.dart';
import 'utils/alert.dart';
import 'pages/new_recipe.dart';
import 'pages/view_recipe.dart';
import 'config/app_theme.dart';
import 'config/app_constants.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appTitle,
      theme: AppTheme.lightTheme,
      home: const MyHomePage(title: AppConstants.appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             ElevatedButton(
              onPressed: () {
                AlertUtil.showAlert(context, "Generate Random Recipe", AppConstants.generateRandomRecipeMessage);
              },
              child: const Text(AppConstants.generateFromAIButton),
            ),
            const SizedBox(height: AppTheme.paddingMedium),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewRecipe()),
                );
              },
              child: const Text(AppConstants.storeNewRecipeButton)
            ),
            const SizedBox(height: AppTheme.paddingMedium),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewRecipe()),
                );
              },
              child: const Text(AppConstants.selectStoredRecipeButton)
            )
          ],
        ),
      ),
    );
  }
}

