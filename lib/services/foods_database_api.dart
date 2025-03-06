import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_planner_menu/models/food.dart';
import 'package:http/http.dart' as http;

class FoodsDatabaseApi {
  static Future<List<Food>> fetchFoods() async {
    try{
      const String url = "http://10.0.2.2:8080/api/foods";
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
      print(e.toString());
      return [];
    }
  }
}