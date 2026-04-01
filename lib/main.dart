import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled_today/app_data.dart';
import 'company_dashboard_page.dart';
import 'institute_dashboard.dart';
import 'add_course.dart';
import 'view_skill_demand.dart';
import 'job_requirement.dart';
import 'view_candidate_profile.dart';


void main() {
  runApp(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CompanyDashboard(),
    );
  }
}