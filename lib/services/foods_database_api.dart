import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_planner_menu/config/config.dart';
import 'package:food_planner_menu/models/food.dart';
import 'package:http/http.dart' as http;

class FoodsDatabaseApi {
  static Future<List<Food>> fetchFoods() async {
    try{
      const String url = "${Config.apiUrl}/foods";
      final response = await http.get(Uri.parse(url)); 
      
      if(response.statusCode == 200){
        debugPrint("Response: ${response.body}");
        List<dynamic> data = json.decode(response.body);
        final List<Food> foodList = data.map((e) => Food.fromJsonForSpring(e as Map<String, dynamic>)).toList();
        debugPrint("FoodList: ${foodList.map((e) => e.name).toList()}");
        return foodList;
      }else{
        throw Exception('Failed to load foods${response.statusCode}');
      }
    } catch(e){
      debugPrint(e.toString());
      return [];
    }
  }
  
  static Future<void> addFood(Food food) async {
  try {
    const String url = "${Config.apiUrl}/foods";
    
    //TODO: bu diger apidan cekilen food bizim ekledigim food icin dayName ve 
    //foodTypeName icermiyor add food pagede fooda tiklandiginda o ozelliklerin de eklenmesi lazim 
    
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": food.name,
        "area": food.area ?? "",
        "instructions": food.instructions!.substring(1,20) ?? "",
        "imageUrl": food.imageUrl ?? "",
        "dayName": food.dayName ?? "",
        "foodTypeName": food.mealTime ?? ""
      }),
    );

    debugPrint("Response Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode != 201) { // Usually, POST requests return 201 for successful creation
      throw Exception("Failed to add food: ${response.body}");
    }
  } catch (e) {
    debugPrint("Error adding food: $e");
  }
}

}