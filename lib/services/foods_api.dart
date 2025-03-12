import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_planner_menu/models/food.dart';
import 'package:http/http.dart' as http;

class FoodsApi {
  static Future<List<Food>> fetchFoods(String foodName) async {
    try {
      final String url = "https://themealdb.com/api/json/v1/1/search.php?s=$foodName";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        //debugPrint("Response: ${response.body}");
        // Process the response
        Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> meals = data['meals'];
        final List<Food> foodList = meals.map((e) =>
          Food.fromJson(e as Map<String, dynamic>)
        ).toList();
        return foodList.take(5).toList();
      } else {
        throw Exception('Failed to load food');
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}