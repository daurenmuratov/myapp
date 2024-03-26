import 'package:flutter/material.dart';
import 'package:myapp/models/recipe.dart';
import 'package:myapp/pages/recipe_page.dart';
import 'package:myapp/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? mealTypeFilter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recip Book'),
      ),
      body: SafeArea(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _recipeTypeButtons(),
          _recipeList(),
        ],
      ),
    );
  }

  Widget _recipeTypeButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  mealTypeFilter = 'snack';
                });
              },
              child: const Text('🥕 Snack'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  mealTypeFilter = 'breakfast';
                });
              },
              child: const Text('🥕 Breakfast'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  mealTypeFilter = 'lunch';
                });
              },
              child: const Text('🥕 Lunch'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  mealTypeFilter = 'dinner';
                });
              },
              child: const Text('🥕 Dinner'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipeList() {
    return Expanded(
      child: FutureBuilder(
        future: DataService().getRecipes(mealTypeFilter!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Recipe recipe = snapshot.data![index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RecipePage(
                          recipe: recipe,
                        );
                      },
                    ),
                  );
                },
                contentPadding: const EdgeInsets.only(
                    left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
                isThreeLine: true,
                subtitle: Text(
                  '${recipe.cuisine}\nDifficulity: ${recipe.difficulty}',
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Image.network(
                    recipe.image,
                  ),
                ),
                title: Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  '${recipe.rating.toString()} ⭐',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
