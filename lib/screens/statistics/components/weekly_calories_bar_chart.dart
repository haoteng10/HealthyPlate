import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:nutrition/models/food.dart";

class WeeklyCaloriesBarChart extends StatefulWidget {
  List<FoodData> filteredFoods;

  WeeklyCaloriesBarChart({this.filteredFoods});

  @override
  State<StatefulWidget> createState() => WeeklyCaloriesBarChartState();
}

class WeeklyCaloriesBarChartState extends State<WeeklyCaloriesBarChart> {
  //List of daily calories in reversing order e.g. [today, yesterday, 2 days ago, 3 days ago...]
  List<int> populateWeeklyCalories(List<FoodData> filteredFoods) {
    print(filteredFoods);

    List<int> _weeklyCalories = [];
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime loopDay = today.subtract(new Duration(days: i));
      int loopDayCalories = 0;
      filteredFoods.forEach((FoodData food) {
        DateTime foodDateTime = DateTime.parse(food.dateTime);
        if (foodDateTime.year == loopDay.year &&
            foodDateTime.month == loopDay.month &&
            foodDateTime.day == loopDay.day) {
          loopDayCalories += int.parse(food.serving.calories);
        }
      });
      _weeklyCalories.add(loopDayCalories);
    }
    return _weeklyCalories;
  }

  @override
  Widget build(BuildContext context) {
    List<int> _weeklyCalories = populateWeeklyCalories(widget.filteredFoods);

    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.blueAccent[400],
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "Weekly Calories",
                    style: TextStyle(
                        color: const Color(0xff0f4a3c),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "A weekly view of your calories consumption",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(_weeklyCalories),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartData mainBarData(List<int> _weeklyCalories) {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 1000,
      barTouchData: BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipBottomMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: Colors.blue[900],
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 50,
          getTitles: (double value) {
            DateTime today = DateTime.now();
            DateTime xDate = today.subtract(new Duration(days: value.toInt()));
            switch (xDate.weekday) {
              case 1:
                return "Mon";
                break;
              case 2:
                return "Tue";
                break;
              case 3:
                return "Wed";
                break;
              case 4:
                return "Thu";
                break;
              case 5:
                return "Fri";
                break;
              case 6:
                return "Sat";
                break;
              case 7:
                return "Sun";
                break;
              default:
                return "";
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: [
        BarChartGroupData(x: 6, barRods: [
          BarChartRodData(
              y: _weeklyCalories[6].toDouble(), color: Colors.lightBlueAccent)
        ], showingTooltipIndicators: [
          0
        ]),
        BarChartGroupData(x: 5, barRods: [
          BarChartRodData(
              y: _weeklyCalories[5].toDouble(), color: Colors.lightBlueAccent)
        ], showingTooltipIndicators: [
          0
        ]),
        BarChartGroupData(x: 4, barRods: [
          BarChartRodData(
              y: _weeklyCalories[4].toDouble(), color: Colors.lightBlueAccent)
        ], showingTooltipIndicators: [
          0
        ]),
        BarChartGroupData(x: 3, barRods: [
          BarChartRodData(
              y: _weeklyCalories[3].toDouble(), color: Colors.lightBlueAccent)
        ], showingTooltipIndicators: [
          0
        ]),
        BarChartGroupData(x: 2, barRods: [
          BarChartRodData(
              y: _weeklyCalories[2].toDouble(), color: Colors.lightBlueAccent)
        ], showingTooltipIndicators: [
          0
        ]),
        BarChartGroupData(x: 1, barRods: [
          BarChartRodData(
              y: _weeklyCalories[1].toDouble(), color: Colors.lightBlueAccent)
        ], showingTooltipIndicators: [
          0
        ]),
        BarChartGroupData(x: 0, barRods: [
          BarChartRodData(
              y: _weeklyCalories[0].toDouble(), color: Colors.lightBlueAccent)
        ], showingTooltipIndicators: [
          0
        ]),
      ],
    );
  }
}
