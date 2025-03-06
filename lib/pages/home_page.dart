import 'package:flutter/material.dart';
import 'package:food_planner_menu/models/food.dart';
import 'package:food_planner_menu/pages/add_food_page.dart';
import 'package:food_planner_menu/providers/all_foods_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
    //init state to fetch data from database when initialization and widgets binding
    //to fetch before the first frame is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AllFoodsProvider>(context, listen: false).fetchFoodsFromDatabase();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F6), // Light pink background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6F6),
        elevation: 0,
        title: const Text(
          'Yemek Planlayıcı',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // Add settings functionality
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDayCard("PAZARTESİ"),
          _buildDayCard('SALI'),
          _buildDayCard('ÇARŞAMBA'),
          _buildDayCard('PERŞEMBE'),
          _buildDayCard('CUMA'),
          _buildDayCard('CUMARTESİ'),
          _buildDayCard('PAZAR'),
        ],
      ),
    );
  }

  Widget _buildDayCard(String day) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: const BoxDecoration(
              color: Color(0xFFFFD6D6), // Light pink for day header
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                day,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildMealRow('KAHVALTI',day),
                _buildMealRow('ÖĞLE',day),
                _buildMealRow('ATIŞTIRMALIK',day),
                _buildMealRow('AKŞAM',day),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealRow(String mealTime,String day) {
    return Consumer<AllFoodsProvider>(
      builder: (context, allFoodsProvider, child) {
        List<Food> allFoods = allFoodsProvider.dbFoods;
        List<Food> selectedFoods = allFoods
        .where((element) => dayMapping[element.dayName] == day
         && mealTimeMapping[element.mealTime] == mealTime)
        .toList();
        //debugPrint("name of the selected food${selectedFoods[0].name}");
        return Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE5F3F3), // Light mint color
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mealTime,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selectedFoods.isNotEmpty ? Text(
                        selectedFoods.map((element) => element.name).join(', '),
                      ) :
                      const Text(
                        'Yemek ekle',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddFoodPage(
                          day: mealTime,
                          mealTime: mealTime,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

const Map<String, String> dayMapping = {
  'Monday': 'PAZARTESİ',
  'Tuesday': 'SALI',
  'Wednesday': 'ÇARŞAMBA',
  'Thursday': 'PERŞEMBE',
  'Friday': 'CUMA',
  'Saturday': 'CUMARTESİ',
  'Sunday': 'PAZAR',
};

const Map<String, String> mealTimeMapping = {
  'Breakfast': 'KAHVALTI',
  'Lunch': 'ÖĞLE',
  'Snack': 'ATIŞTIRMALIK',
  'Dinner': 'AKŞAM',
  };

