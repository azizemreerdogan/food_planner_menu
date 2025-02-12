import 'package:flutter/material.dart';
import 'package:food_planner_menu/models/food.dart';
import 'package:food_planner_menu/providers/all_foods_provider.dart';
import 'package:provider/provider.dart';

class AddFoodPage extends StatefulWidget {
  final String day;
  final String mealTime;

  const AddFoodPage({
    super.key,
    required this.day,
    required this.mealTime,
  });

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final TextEditingController _foodController = TextEditingController();

  @override
  void dispose() {
    _foodController.dispose();
    super.dispose();
  }

  List<Food> foodList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F6), // Light pink background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Yemek ekle',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Corgi image at the top
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.asset(
                  'assets/corgi.png',
                  height: 80,
                ),
              ),
              // Search TextField
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Consumer<AllFoodsProvider>(
                  builder: (context, allFoodsProvider, child) {
                    allFoodsProvider = Provider.of<AllFoodsProvider>(context);
                    return Column(
                      children: [
                        TextField(
                          onChanged: (value) async {
                            await allFoodsProvider.fetchFoods(value);
                            foodList = allFoodsProvider.allFoods;
                            debugPrint("Foods: ${foodList.map((element) => element.name).join(', ')}");
                          },
                          controller: _foodController,
                          decoration:  InputDecoration(
                            hintText: 'Bir yemek girin...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            suffixIcon: const Icon(Icons.search , color: Colors.grey,),
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.add , color: Colors.green,size: 36,),
                              onPressed: () {
                              allFoodsProvider.addFood(Food(name: _foodController.text));
                            }, ),
                        ),
                        ),
                        if (foodList.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: foodList.isNotEmpty ? foodList.length : 0,
                            itemBuilder: (context, index) {
                              final food = foodList[index];
                              return ListTile(
                                title: Text(food.name ?? 'No name'),
                                
                                onTap: () {
                                  allFoodsProvider.addFood(food);
                                  debugPrint("Selected foods: ${allFoodsProvider.selectedFood.map((element) => element.name).join(', ')}");
                                  FocusScope.of(context).unfocus();
                                  foodList = [];
                                },
                              );
                            },
                          ),
                          
                            
                          
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Food selection card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'YEMEĞİNİZİ SEÇİN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Image.asset(
                            'assets/noel_baba.png',
                            height: 45,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Consumer<AllFoodsProvider>(builder: (context,allFoodsProvider,child){
                        List<Food> selectedFoods = allFoodsProvider.selectedFood;
                        return selectedFoods.isNotEmpty ?
                        Text(selectedFoods.map((element) => element.name).join(', ')) :
                      const Text(
                        'Henüz hiç yiyecek girmediniz',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        );
                      }
                      )
                      
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
