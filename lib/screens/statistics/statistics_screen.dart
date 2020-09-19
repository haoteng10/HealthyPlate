import "package:flutter/material.dart";
import "components/daily_intake_bar_chart.dart";
import "components/weekly_calories_bar_chart.dart";

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // DailyIntakeBarChart(),
            SizedBox(height: 18),
            // WeeklyCaloriesBarChart(),
          ],
        ),
      ),
    ));
  }
}
