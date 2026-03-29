import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_data.dart';
import 'package:provider/provider.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({super.key});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final nameController = TextEditingController();
  final durationController = TextEditingController();
  final seatController = TextEditingController();

  /// 🔥 SKILL LIST
  final List<String> allSkills = [
    "Python",
    "Java",
    "SQL",
    "Flutter",
    "React",
    "Machine Learning",
    "Data Science",
    "AI",
  ];

  List<String> selectedSkills = [];
  List<String> filteredSkills = [];

  String district = "Bhagalpur";

  bool isFormValid = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    filteredSkills = allSkills;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFF2F4F8),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    nameController.addListener(checkForm);
    durationController.addListener(checkForm);
    seatController.addListener(checkForm);
  }

  void checkForm() {
    final valid =
        nameController.text.trim().isNotEmpty &&
            selectedSkills.isNotEmpty &&
            durationController.text.trim().isNotEmpty &&
            seatController.text.trim().isNotEmpty &&
            int.tryParse(durationController.text) != null &&
            int.tryParse(seatController.text) != null;

    setState(() {
      isFormValid = valid;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    durationController.dispose();
    seatController.dispose();
    super.dispose();
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),

      appBar: AppBar(
        title: const Text("Add Course"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Course Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              _input("Course Name", nameController, Icons.book, false),
              const SizedBox(height: 15),

              _skillSelector(),
              const SizedBox(height: 15),

              _input("Duration (hrs)", durationController, Icons.timer, true),
              const SizedBox(height: 15),

              _input("Seats", seatController, Icons.event_seat, true),
              const SizedBox(height: 15),

              _dropdown(),
              const SizedBox(height: 30),

              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= INPUT =================
  Widget _input(
      String label,
      TextEditingController controller,
      IconData icon,
      bool isNumber,
      ) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      onChanged: (_) => checkForm(),

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF2F5D9F)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF2F5D9F), width: 2),
        ),
      ),
    );
  }

  /// ================= SKILL SEARCH + SELECT =================
  Widget _skillSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// SEARCH FIELD
        TextField(
          onChanged: (value) {
            setState(() {
              filteredSkills = allSkills
                  .where((skill) =>
                  skill.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            });
          },
          decoration: InputDecoration(
            hintText: "Search Skills",
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// SKILL OPTIONS
        Wrap(
          spacing: 8,
          children: filteredSkills.map((skill) {
            final selected = selectedSkills.contains(skill);

            return ChoiceChip(
              label: Text(skill),
              selected: selected,
              onSelected: (_) {
                setState(() {
                  if (selected) {
                    selectedSkills.remove(skill);
                  } else {
                    selectedSkills.add(skill);
                  }
                });
                checkForm();
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 10),

        /// SELECTED SKILLS
        Wrap(
          spacing: 8,
          children: selectedSkills.map((skill) {
            return Chip(
              label: Text(skill),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () {
                setState(() {
                  selectedSkills.remove(skill);
                });
                checkForm();
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  /// ================= DROPDOWN =================
  Widget _dropdown() {
    return DropdownButtonFormField<String>(
      value: context.watch<AppState>().district,
      items: const [
        DropdownMenuItem(value: "Bhagalpur", child: Text("Bhagalpur")),
        DropdownMenuItem(value: "Patna", child: Text("Patna")),
      ],
      onChanged: (value) {
        setState(() {
          district = value!;
        });
      },
      decoration: InputDecoration(
        labelText: "District",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// ================= SUBMIT =================
  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (!isFormValid || isLoading)
            ? null
            : () async {
          setState(() => isLoading = true);

          await Future.delayed(const Duration(seconds: 1));

          setState(() => isLoading = false);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Course Added Successfully")),
          );

          Navigator.pop(context);
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F5D9F),
          disabledBackgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("Submit"),
      ),
    );
  }
}