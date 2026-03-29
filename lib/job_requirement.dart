import 'package:flutter/material.dart';

class JobRequirementPage extends StatefulWidget {
  const JobRequirementPage({super.key});

  @override
  State<JobRequirementPage> createState() => _JobRequirementPageState();
}

class _JobRequirementPageState extends State<JobRequirementPage> {

  final roleController = TextEditingController();
  final skillController = TextEditingController();
  final expController = TextEditingController();
  final vacancyController = TextEditingController();

  String district = "Bhagalpur";
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();

    roleController.addListener(checkForm);
    skillController.addListener(checkForm);
    expController.addListener(checkForm);
    vacancyController.addListener(checkForm);
  }

  void checkForm() {
    final valid =
        roleController.text.isNotEmpty &&
            skillController.text.isNotEmpty &&
            int.tryParse(expController.text) != null &&
            int.tryParse(vacancyController.text) != null;

    setState(() {
      isFormValid = valid;
    });
  }

  @override
  void dispose() {
    roleController.dispose();
    skillController.dispose();
    expController.dispose();
    vacancyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),

      appBar: AppBar(
        title: const Text("Post Job"),
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
                "Job Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              _input("Job Role", roleController, Icons.work, false),
              const SizedBox(height: 15),

              _input("Required Skills", skillController, Icons.psychology, false),
              const SizedBox(height: 15),

              _input("Experience (yrs)", expController, Icons.timeline, true),
              const SizedBox(height: 15),

              _input("Vacancies", vacancyController, Icons.groups, true),
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

  /// 🔹 INPUT FIELD
  Widget _input(String label, TextEditingController controller,
      IconData icon, bool isNumber) {
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
          borderSide: const BorderSide(
            color: Color(0xFF2F5D9F),
            width: 2,
          ),
        ),
      ),
    );
  }

  /// 🔹 DROPDOWN
  Widget _dropdown() {
    return DropdownButtonFormField(
      value: district,
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

  /// 🔹 SUBMIT BUTTON
  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isFormValid
            ? () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Job Posted Successfully")),
          );

          Navigator.pop(context);
        }
            : null,

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F5D9F),
          disabledBackgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        child: const Text(
            "Post Job",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}