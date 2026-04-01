import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:untitled_today/add_course.dart';
import 'package:untitled_today/view_skill_demand.dart';
import 'app_data.dart';





////// Yaha JSON se data lenge 'BarChart' ke liye //////

final data = {
  "Python": 120,
  "DSA": 100,
  "SQL": 90,
  "ML": 60,
  "DA": 40,
};

////// Ab Data ke value ke anusaar isse decending order me sort kareenge //////
final sorted = data.entries.toList()
  ..sort((a, b) => b.value.compareTo(a.value));

////// Ab top4 value ko alag kar lenge //////
final top4 = sorted.take(4).toList();


final skillTrends = {
  "Python": [10, 50, 50, 30, 120],
  "DSA": [30, 20, 90, 20, 100],
  "SQL": [20, 30, 60, 30, 90],
  "ML": [30, 80, 20, 70, 60],
};

final skills = {
  for (var e in top4)
    e.key: skillTrends[e.key] ?? [0, 0, 0, 0, 0],
};

Color _getColor(int index) {
  switch (index) {
    case 0: return Color(0xff5b6ef5);
    case 1: return Color(0xff50c878);
    case 2: return Color(0xffffa726);
    case 3: return Color(0xff9c27b0);
    default: return Colors.grey;
  }
}

////// Declaring class for '_courseCard()' //////
class SuggestedCourse {
  final IconData iconName;
  final String title;
  final String duration;
  final bool seatsAvailability;
  final Color color;

  SuggestedCourse({required this.iconName, required this.title, required this.duration, required this.color,required this.seatsAvailability});

}





////// Creating a list to store 'class SuggestedCourse()' data //////
////// Issi list me backend ke data ko store karenge //////
List<SuggestedCourse> suggestedCourses = [
  SuggestedCourse(iconName: Icons.bar_chart, title: "Power BI", duration: "12", color: Colors.blue, seatsAvailability: true),
  SuggestedCourse(iconName: Icons.bar_chart, title: "Power BI", duration: "12", color: Colors.blue, seatsAvailability: true),
  SuggestedCourse(iconName: Icons.bar_chart, title: "Power BI", duration: "12", color: Colors.blue, seatsAvailability: true),
  SuggestedCourse(iconName: Icons.bar_chart, title: "Power BI", duration: "12", color: Colors.blue, seatsAvailability: true),
];

////// Declaring class for '_studentCard()' //////
class Student{
  final String name;
  final String qualification;
  final double matchPercent;
  final String districtEntered;
  Student({required this.name, required this.qualification, required this.matchPercent, required this.districtEntered});
}

////// Creating a list to store 'class Student' data //////
////// Yahi pe data ko preference ke hisaab se add kiya jaayega //////
List<Student> students = [
  Student(name:"Amarjeet", qualification: 'Web Developer', matchPercent: 80, districtEntered:"Patna"),
  Student(name:"Rajneesh", qualification: 'App Developer', matchPercent: 85, districtEntered:"Begusarai"),
  Student(name:"Yuvraj", qualification: 'Game Developer', matchPercent: 70, districtEntered:"Begusarai"),
  Student(name:"Yuvraj", qualification: 'Game Developer', matchPercent: 70, districtEntered:"Begusarai"),

];


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
                  Expanded(child: _actionCard(context,"Add Course", "Add Course")),
                  const SizedBox(width: 10),
                  Expanded(child: _actionCard(context,"View Skill Demand", "View Now")),
                ],
              ),

              const SizedBox(height: 20),

              _insightCard(),

              const SizedBox(height: 20),

              _dropdownCard(context),

              const SizedBox(height: 20),

              const Text("Suggested Courses",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              const Text("Course ideas based on demand",
                  style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ...List.generate(suggestedCourses.length,
                          (i) => _courseCard(suggestedCourses[i].title, suggestedCourses[i].duration, suggestedCourses[i].iconName, suggestedCourses[i].color,suggestedCourses[i].seatsAvailability),
                      ),
                  // Expanded(child: _courseCard("Power BI", "10 hrs", Icons.bar_chart, Colors.yellow)),
                  // const SizedBox(width: 10),
                  // Expanded(child: _courseCard("Tableau", "12 hrs", Icons.dashboard, Colors.blue)),
                ],
              ),

              const SizedBox(height: 20),

              const Text("Student Management",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              ...List.generate(students.length, (i) => _studentCard(students[i].name, students[i].qualification, students[i].matchPercent, students[i].districtEntered)),

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
  Widget _actionCard(BuildContext context, String title, String btn) {
    return _card(
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => title == "Add Course" ? AddCoursePage(): ViewSkillDemandPage()),
              );
            },
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
    final max = top4
        .map((e) => e.value).reduce((a, b) => a > b ? a : b);
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
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.black26.withOpacity(0.4),
                            tooltipPadding: EdgeInsets.all(8),
                            tooltipMargin: 8,
                          ),
                        ),

                        maxY: max + 20,
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
                              getTitlesWidget: (value, TitleMeta) {
                                final index =  value.toInt();

                                if (index >= 0 && index < top4.length) {
                                  return _label(top4[index].key);
                                }
                                return const SizedBox();
                              }
                            ),
                          ),
                        ),

                        barGroups: top4.asMap().entries.map((e) {
                          final index = e.key;
                          final entry = e.value;
                          return _barData(
                            index,
                            entry.value.toDouble(),
                          );
                        }).toList(),
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

                        lineBarsData: skills.entries.map((entry) {
                          final index = skills.keys.toList().indexOf(entry.key);
                          return LineChartBarData(
                            isCurved: true,
                            curveSmoothness: 0.3,
                            color: _getColor(index).withOpacity(0.8),
                            barWidth: 2,

                            spots: entry.value.asMap().entries.map((e) {
                              return FlSpot(e.key.toDouble(), e.value.toDouble());
                            }).toList(),

                            dotData: FlDotData(show: false),
                          );
                        }).toList(),
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
          color: _getColor(x),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  /// COURSE CARD
  Widget _courseCard(String title, String duration, IconData icon, Color color, bool isSeatAvailable) {
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
              Text(
                  isSeatAvailable ? "Seats available" : "Seats not available",
                  style: TextStyle(color: Colors.grey, fontSize: 12)
              ),
            ],
          )
        ],
      ),
    );
  }

  /// STUDENT CARD
  Widget _studentCard(String _name, String _qualification, double _matchPercent, String _districtEntered) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: _card(
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$_name",
                      style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 0.5)),
                  Text("$_qualification",
                      style: TextStyle(color: Colors.grey)),
                  Text("$_districtEntered",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (_matchPercent >= 80) ? Colors.green : (_matchPercent >= 60 && _matchPercent < 80 ? Colors.orange : Colors.red),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("$_matchPercent%",
                  style: const TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  /// DROPDOWN
  Widget _dropdownCard(BuildContext context) {
    return _card(
      child: DropdownButtonFormField(
        value: context.watch<AppState>().district,
        items: context.watch<AppState>().districtList.map((d) => DropdownMenuItem(
          value: d,
          child: Text(d),
        )).toList(),
        onChanged: (value) {
          context.read<AppState>().setDistrict(value!);
        },
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