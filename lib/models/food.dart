class Food {
  int? id;
  String? name;
  String? area;
  String? instructions;
  String? imageUrl;
  List<String>? ingredients;
  String? dayName;
  String? mealTime;
  
  
  Food({
    this.id,
    this.name,
    this.area,
    this.instructions,
    this.imageUrl,
    this.ingredients,
  });
  
  Food.withMealTime({
    this.id,
    this.name,
    this.area,
    this.instructions,
    this.imageUrl,
    this.ingredients,
    this.dayName,
    this.mealTime,
  });
  
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: int.parse(json['idMeal']) ?? 0,
      name: json['strMeal'] ?? 'Unknown Name',
      area: json['strArea'] ?? 'Unknown',
      instructions: json['strInstructions'] ?? 'No instructions available',
      imageUrl: json['strMealThumb'] ?? 'no image',
      ingredients: List<String?>.generate(20, (index) {
        final ingredient = json['strIngredient${index + 1}'] ?? '';
        return ingredient.isNotEmpty ? ingredient : null;
      }).whereType<String>().toList(),
    );
  }
  
  factory Food.fromJsonForSpring(Map<String, dynamic> json) {
    return Food.withMealTime(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown Name',
      area: json['area'] ?? 'Unknown',
      instructions: json['instructions'] ?? 'No instructions available',
      imageUrl: json['imageUrl'] ?? 'no image',
      dayName: json['dayName'] ?? 'Unknown',
      mealTime: json['foodTypeName'] ?? 'Unknown',
    );
  }
  
 
  
  
  /*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'area': area,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
    };
  }*/
  
}