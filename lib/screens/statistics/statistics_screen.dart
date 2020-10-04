import "package:flutter/material.dart";
import 'package:nutrition/models/food.dart';
import 'package:nutrition/services/database.dart';
import "components/daily_intake_bar_chart.dart";
import "components/weekly_calories_bar_chart.dart";
import "package:provider/provider.dart";
import "package:nutrition/models/user.dart";

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: StreamBuilder<List<FoodData>>(
          stream: DatabaseService(uid: user.uid).foodData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<FoodData> filteredFoods = snapshot.data
                  .where((FoodData food) => food == null ? false : true)
                  .toList();
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DailyIntakeBarChart(
                      filteredFoods: filteredFoods,
                    ),
                    SizedBox(height: 18),
                    WeeklyCaloriesBarChart(
                      filteredFoods: filteredFoods,
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
