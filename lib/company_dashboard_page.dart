import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CompanyDashboard extends StatelessWidget {
  const CompanyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),

      appBar: AppBar(
        title: const Text("Company Dashboard"),
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            children: [

              _header(),
              const SizedBox(height: 15),

              _postSkill(),
              const SizedBox(height: 15),

              _candidateSection(),
              const SizedBox(height: 15),

              _chartCard(),
              const SizedBox(height: 15),

              _filterCard(),
              const SizedBox(height: 15),

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
            child: Icon(Icons.business, color: Colors.blue),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome", style: TextStyle(color: Colors.white70)),
              Text("ABC Tech!",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          Spacer(),
          Icon(Icons.notifications, color: Colors.white)
        ],
      ),
    );
  }

  /// POST
  Widget _postSkill() {
    return _card(
      child: Column(
        children: [
          const Text("Job Requirement",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F5D9F),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Post New"),
          )
        ],
      ),
    );
  }

  /// CANDIDATES
  Widget _candidateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("View Available Candidates",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        const SizedBox(height: 10),
        ...List.generate(3, (i) => _candidateCard()),
      ],
    );
  }

  Widget _candidateCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: _card(
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rahul Singh",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Bhagalpur",
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  Text("Missing Skills",
                      style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("85%",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F5D9F),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(110, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("View Profile"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  /// ✅ FINAL CHART FIXED
  Widget _chartCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Demand vs Shortage",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          SizedBox(
            height: 220,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 120,
                  groupsSpace: 25,

                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                  ),

                  borderData: FlBorderData(show: false),

                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    /// 🔥 FIXED LEFT AXIS
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 20,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text("Req");
                            case 1:
                              return const Text("Skills");
                            case 2:
                              return const Text("Short");
                            case 3:
                              return const Text("Data");
                            default:
                              return const Text("");
                          }
                        },
                      ),
                    ),
                  ),

                  barGroups: [
                    _bar(0, 80, 30),
                    _bar(1, 110, 60),
                    _bar(2, 85, 35),
                    _bar(3, 70, 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _bar(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          width: 8,
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFF2F5D9F),
        ),
        BarChartRodData(
          toY: y2,
          width: 8,
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey,
        ),
      ],
    );
  }

  /// FILTER
  Widget _filterCard() {
    return _card(
      child: Column(
        children: [
          DropdownButtonFormField(
            items: const [
              DropdownMenuItem(value: "Bhagalpur", child: Text("Bhagalpur")),
            ],
            onChanged: (v) {},
            decoration: const InputDecoration(labelText: "District"),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField(
            items: const [
              DropdownMenuItem(value: "4-6 LPA", child: Text("4-6 LPA")),
            ],
            onChanged: (v) {},
            decoration: const InputDecoration(labelText: "Salary"),
          ),
        ],
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

  /// COMMON CARD
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: child,
    );
  }
}