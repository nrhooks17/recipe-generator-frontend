import 'package:flutter/material.dart';
import 'utils/alert.dart';
import 'pages/new_recipe.dart';
import 'pages/view_recipe.dart';


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
      title: 'Recipe Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Recipe Generator'),
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
                AlertUtil.showAlert(context, "Generate Random Recipe", "Generating a random recipe...");
              },
              child: const Text('Generate Recipe from AI'),
            ),
            const SizedBox(height: 13),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewRecipe()),
                );
              },
              child: const Text('Store New Recipe')
            ),
            const SizedBox(height: 13),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewRecipe()),
                );
              },
              child: const Text('Select Stored Recipe')
            )
          ],
        ),
      ),
    );
  }
}

