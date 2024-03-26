import 'package:myapp/consts.dart';
import 'package:myapp/models/recipe.dart';
import 'package:myapp/services/http_service.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _instance;
  }

  DataService._internal();

  Future<List<Recipe>?> getRecipes(String filter) async {
    var path = apiRecipes;
    if (filter.isNotEmpty) {
      path += 'meal-type/$filter';
    }
    final response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      final List data = response!.data['recipes'];
      final List<Recipe> recipes =
          data.map((recipe) => Recipe.fromJson(recipe)).toList();
      return recipes;
    }
    return [];
  }
}
