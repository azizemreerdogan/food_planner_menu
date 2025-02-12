import 'package:flutter/material.dart';
import 'package:food_planner_menu/models/food.dart';
import 'package:food_planner_menu/services/foods_api.dart';

class AllFoodsProvider extends ChangeNotifier{
  List<Food> _allFoods = [];
  List<Food> selectedFood = [];

  List<Food> get allFoods => _allFoods;

  Future<void> fetchFoods(String foodName) async{
    List<Food> foods = await FoodsApi.fetchFoods(foodName);
    _allFoods = foods.map((e) => e).toList();
    notifyListeners();
  }
  
  Future<void> addFood(Food food){
    selectedFood.add(food);
    notifyListeners();
    return Future.value();
  }
  
}