import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InstituteDashboard extends StatelessWidget {
  const InstituteDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),

      appBar: AppBar(
        title: const Text("Institute Dashboard"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(),
        actions: const [
          Icon(Icons.more_vert),
          SizedBox(width: 10)
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              _header(),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(child: _actionCard("Add Course", "Add Course")),
                  const SizedBox(width: 10),
                  Expanded(child: _actionCard("View Skill Demand", "View Now")),
                ],
              ),

              const SizedBox(height: 20),

              _insightCard(),

              const SizedBox(height: 20),

              _dropdownCard(),

              const SizedBox(height: 20),

              const Text("Suggested Courses",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              const Text("Course ideas based on demand",
                  style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(child: _courseCard("Power BI", "10 hrs", Icons.bar_chart, Colors.yellow)),
                  const SizedBox(width: 10),
                  Expanded(child: _courseCard("Tableau", "12 hrs", Icons.dashboard, Colors.blue)),
                ],
              ),

              const SizedBox(height: 20),

              const Text("Student Management",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              ...List.generate(3, (i) => _studentCard()),

              const SizedBox(height: 20),

              _logoutCard(),
            ],
          ),
        ),
      ),
    );
  }

  /// HEADER
  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2F5D9F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.school, color: Colors.blue),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome", style: TextStyle(color: Colors.white70)),
              Text("Institute Admin!",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          Spacer(),
          Icon(Icons.notifications, color: Colors.white)
        ],
      ),
    );
  }

  /// ACTION CARD
  Widget _actionCard(String title, String btn) {
    return _card(
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F5D9F),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
            ),
            child: Text(btn),
          )
        ],
      ),
    );
  }

  /// CHART SECTION (FINAL POLISH)
  Widget _insightCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text("Market Insight",
              style: TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 15),

          Row(
            children: [

              /// BAR CHART
              Expanded(
                child: SizedBox(
                  height: 140,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 200,
                        groupsSpace: 20,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),

                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return _label("Py");
                                  case 1:
                                    return _label("SQL");
                                  case 2:
                                    return _label("ML");
                                  case 3:
                                    return _label("DA");
                                  default:
                                    return const SizedBox();
                                }
                              },
                            ),
                          ),
                        ),

                        barGroups: [
                          _barData(0, 180),
                          _barData(1, 140),
                          _barData(2, 100),
                          _barData(3, 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// LINE CHART
              Expanded(
                child: SizedBox(
                  height: 140,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),

                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return _label("Jan");
                                  case 1:
                                    return _label("Feb");
                                  case 2:
                                    return _label("Mar");
                                  case 3:
                                    return _label("Apr");
                                  case 4:
                                    return _label("May");
                                  default:
                                    return const SizedBox();
                                }
                              },
                            ),
                          ),
                        ),

                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            spots: const [
                              FlSpot(0, 10),
                              FlSpot(1, 50),
                              FlSpot(2, 50),
                              FlSpot(3, 30),
                              FlSpot(4, 80),
                            ],
                            color: const Color(0xFF2F5D9F),
                            dotData: FlDotData(show: false),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(text, style: const TextStyle(fontSize: 10)),
    );
  }

  BarChartGroupData _barData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 8,
          color: const Color(0xFF2F5D9F),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  /// COURSE CARD
  Widget _courseCard(String title, String duration, IconData icon, Color color) {
    return _card(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Duration: $duration",
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const Text("Seats available",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  /// STUDENT CARD
  Widget _studentCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: _card(
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Amarjeet Kumar",
                      style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 0.5)),
                  Text("Advanced Data Analytics",
                      style: TextStyle(color: Colors.grey)),
                  Text("Bhagalpur",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text("90%",
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  /// DROPDOWN
  Widget _dropdownCard() {
    return _card(
      child: DropdownButtonFormField(
        items: const [
          DropdownMenuItem(value: "Bhagalpur", child: Text("Bhagalpur")),
        ],
        onChanged: (v) {},
        decoration: const InputDecoration(labelText: "District"),
      ),
    );
  }

  /// LOGOUT
  Widget _logoutCard() {
    return _card(
      child: Row(
        children: const [
          Icon(Icons.logout, color: Colors.red),
          SizedBox(width: 10),
          Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  /// COMMON CARD (IMPROVED SHADOW)
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }
}