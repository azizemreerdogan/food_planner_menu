class Food {
  int? id;
  String? name;
  String? area;
  String? instructions;
  String? imageUrl;
  List<String>? ingredients;
  
  Food({
    this.id,
    this.name,
    this.area,
    this.instructions,
    this.imageUrl,
    this.ingredients,
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