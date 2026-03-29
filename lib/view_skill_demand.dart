import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ViewSkillDemandPage extends StatefulWidget {
  const ViewSkillDemandPage({super.key});

  @override
  State<ViewSkillDemandPage> createState() => _ViewSkillDemandPageState();
}

class _ViewSkillDemandPageState extends State<ViewSkillDemandPage> {
  String district = "Bhagalpur";
  String salary = "4-6 LPA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: AppBar(
        title: const Text("Skill Demand"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _demandShortageChart(),
            const SizedBox(height: 20),
            _mostDemandedSkills(),
            const SizedBox(height: 20),
            _skillTrend(),
            const SizedBox(height: 20),
            _suggestedCourses(),
            const SizedBox(height: 20),
            _filterCard(),
          ],
        ),
      ),
    );
  }

  /// ================= DEMAND VS SHORTAGE =================
  Widget _demandShortageChart() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Demand vs Shortage",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),

          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                maxY: 120,

                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.black87,
                    getTooltipItem: (g, _, rod, __) {
                      return BarTooltipItem(
                        "${rod.toY.toInt()}",
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),

                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 40,
                      interval: 20,
                      showTitles: true,
                      getTitlesWidget: (value, _) =>
                          Text(value.toInt().toString(),
                              style: const TextStyle(fontSize: 10)),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        switch (v.toInt()) {
                          case 0:
                            return const Text("Req");
                          case 1:
                            return const Text("Skills");
                          case 2:
                            return const Text("Short");
                          case 3:
                            return const Text("Data");
                        }
                        return const Text("");
                      },
                    ),
                  ),
                  rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),

                gridData: FlGridData(horizontalInterval: 20),
                borderData: FlBorderData(show: false),

                barGroups: [
                  _bar(0, 80, 30),
                  _bar(1, 110, 60),
                  _bar(2, 85, 35),
                  _bar(3, 70, 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= MOST DEMANDED =================
  Widget _mostDemandedSkills() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Most Demanded Skills",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),

          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                maxY: 200,

                /// 🔥 TOOLTIP FIX
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.black87,
                    getTooltipItem: (group, _, rod, __) {
                      String label;
                      switch (group.x) {
                        case 0:
                          label = "Python";
                          break;
                        case 1:
                          label = "SQL";
                          break;
                        case 2:
                          label = "ML";
                          break;
                        case 3:
                          label = "Data";
                          break;
                        default:
                          label = "";
                      }

                      return BarTooltipItem(
                        "$label\n${rod.toY.toInt()}",
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),

                barGroups: [
                  _singleBar(0, 180),
                  _singleBar(1, 140),
                  _singleBar(2, 100),
                  _singleBar(3, 70),
                ],

                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        switch (v.toInt()) {
                          case 0:
                            return const Text("Py");
                          case 1:
                            return const Text("SQL");
                          case 2:
                            return const Text("ML");
                          case 3:
                            return const Text("DA");
                        }
                        return const Text("");
                      },
                    ),
                  ),
                  leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),

                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= SKILL TREND =================
  Widget _skillTrend() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Skill Gap Trend",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),

          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                maxY: 100,

                /// 🔥 TOOLTIP FIX
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.black87,
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        return LineTooltipItem(
                          "${spot.y.toInt()}",
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),

                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        switch (v.toInt()) {
                          case 0:
                            return const Text("Jan");
                          case 1:
                            return const Text("Feb");
                          case 2:
                            return const Text("Mar");
                          case 3:
                            return const Text("Apr");
                          case 4:
                            return const Text("May");
                        }
                        return const Text("");
                      },
                    ),
                  ),
                  leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),

                borderData: FlBorderData(show: false),

                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: const Color(0xFF2F5D9F),
                    barWidth: 3,
                    spots: const [
                      FlSpot(0, 20),
                      FlSpot(1, 60),
                      FlSpot(2, 55),
                      FlSpot(3, 30),
                      FlSpot(4, 90),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= SUGGESTED =================
  Widget _suggestedCourses() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Suggested Courses",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(child: _course("Power BI", "10 hrs")),
              const SizedBox(width: 10),
              Expanded(child: _course("Tableau", "12 hrs")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _course(String name, String dur) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("Duration: $dur"),
        ],
      ),
    );
  }

  /// ================= FILTER =================
  Widget _filterCard() {
    return _card(
      Column(
        children: [
          DropdownButtonFormField(
            value: district,
            items: const [
              DropdownMenuItem(value: "Bhagalpur", child: Text("Bhagalpur")),
              DropdownMenuItem(value: "Patna", child: Text("Patna")),
            ],
            onChanged: (v) => setState(() => district = v!),
            decoration: const InputDecoration(labelText: "District"),
          ),
          const SizedBox(height: 15),
          DropdownButtonFormField(
            value: salary,
            items: const [
              DropdownMenuItem(value: "4-6 LPA", child: Text("4-6 LPA")),
              DropdownMenuItem(value: "6-10 LPA", child: Text("6-10 LPA")),
            ],
            onChanged: (v) => setState(() => salary = v!),
            decoration: const InputDecoration(labelText: "Salary"),
          ),
        ],
      ),
    );
  }

  /// ================= COMMON =================
  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  BarChartGroupData _bar(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barsSpace: 6,
      barRods: [
        BarChartRodData(toY: y1, width: 10, color: const Color(0xFF2F5D9F)),
        BarChartRodData(toY: y2, width: 10, color: Colors.grey),
      ],
    );
  }

  BarChartGroupData _singleBar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: y, width: 12, color: const Color(0xFF2F5D9F)),
      ],
    );
  }
}