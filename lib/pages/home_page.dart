import 'package:flutter/material.dart';
import 'package:food_planner_menu/pages/add_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          _buildDayCard('PAZARTESİ'),
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
                _buildMealRow('KAHVALTI'),
                _buildMealRow('ÖĞLE'),
                _buildMealRow('ATIŞTIRMALIK'),
                _buildMealRow('AKŞAM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealRow(String mealTime) {
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
  }
}

