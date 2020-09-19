import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";

class WeeklyCaloriesBarChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeeklyCaloriesBarChartState();
}

class WeeklyCaloriesBarChartState extends State<WeeklyCaloriesBarChart> {
  @override
  Widget build(BuildContext context) {
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
                        mainBarData(),
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

  BarChartData mainBarData() {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 20,
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
              color: const Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return "Mon";
              case 1:
                return "Tue";
              case 2:
                return "Wed";
              case 3:
                return "Thu";
              case 4:
                return "Fri";
              case 5:
                return "Sat";
              case 6:
                return "Sun";
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
        BarChartGroupData(
            x: 0,
            barRods: [BarChartRodData(y: 8, color: Colors.lightBlueAccent)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 1,
            barRods: [BarChartRodData(y: 10, color: Colors.lightBlueAccent)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 2,
            barRods: [BarChartRodData(y: 14, color: Colors.lightBlueAccent)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 3,
            barRods: [BarChartRodData(y: 15, color: Colors.lightBlueAccent)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 4,
            barRods: [BarChartRodData(y: 13, color: Colors.lightBlueAccent)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 5,
            barRods: [BarChartRodData(y: 10, color: Colors.lightBlueAccent)],
            showingTooltipIndicators: [0]),
      ],
    );
  }
}
