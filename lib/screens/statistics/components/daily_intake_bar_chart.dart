import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
// import "package:nutrition/components/loading.dart";
import "package:nutrition/models/food.dart";
import "package:nutrition/services/database.dart";
import "package:provider/provider.dart";
import "package:nutrition/models/user.dart";

class DailyIntakeBarChart extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => DailyIntakeBarChartState();
}

class DailyIntakeBarChartState extends State<DailyIntakeBarChart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);

  int touchedIndex;

  // Gets foodData from database, filter, and calculate the total daily calories
  Map calculateIntake(List<FoodData> filteredFoods) {
    double _calories = 0;
    double _carbohydrate = 0;
    double _fat = 0;
    double _protein = 0;

    filteredFoods.forEach((FoodData food) {
      if (food != null) {
        _calories = _calories + double.parse(food.serving.calories);
        _carbohydrate = _carbohydrate + double.parse(food.serving.carbohydrate);
        _fat = _fat + double.parse(food.serving.fat);
        _protein = _protein + double.parse(food.serving.protein);
      }
    });

    return {
      "calories": _calories,
      "carbohydrate": _carbohydrate,
      "fat": _fat,
      "protein": _protein,
    };
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<List<FoodData>>(
      stream: DatabaseService(uid: user.uid).foodData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<FoodData> filteredFoods = snapshot.data
              .where((FoodData food) => food == null ? false : true)
              .toList();
          Map _dailyIntake = calculateIntake(filteredFoods);
          return AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: const Color(0xff81e5cd),
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
                          "Daily (Total) Intakes",
                          style: TextStyle(
                              color: const Color(0xff0f4a3c),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "A daily overview of your consumption",
                          style: TextStyle(
                              color: const Color(0xff379982),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              mainBarData(_dailyIntake),
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
        } else {
          return Container();
        }
      },
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 500, //BarChartRod Top Y-value
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(Map _dailyIntake) =>
      List.generate(4, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, _dailyIntake["calories"],
                isTouched: i == touchedIndex); // X, Y, ...and other parameters
          case 1:
            return makeGroupData(1, _dailyIntake["carbohydrate"],
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, _dailyIntake["fat"],
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, _dailyIntake["protein"],
                isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData(Map _dailyIntake) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String intakeType;
              switch (group.x.toInt()) {
                case 0:
                  intakeType = "Calories";
                  break;
                case 1:
                  intakeType = "Carbohydrate";
                  break;
                case 2:
                  intakeType = "Fat";
                  break;
                case 3:
                  intakeType = "Protein";
                  break;
              }
              return BarTooltipItem(intakeType + "\n" + (rod.y - 1).toString(),
                  TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return "Calories";
              case 1:
                return "Carbohydrate";
              case 2:
                return "Fat";
              case 3:
                return "Protein";
              default:
                return "";
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false, // Display Y-axis
        ),
      ),
      borderData: FlBorderData(
        show: false, //Border around the "actual" chart
      ),
      barGroups: showingGroups(_dailyIntake),
    );
  }
}
