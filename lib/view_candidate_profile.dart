import 'package:flutter/material.dart';

class CandidateProfilePage extends StatelessWidget {
  const CandidateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text("Candidate Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// 🔥 HEADER (FIXED - NO DOUBLE LAYER)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3a6073), Color(0xff2c5364),Color(0xFF16222a)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [

                    /// Avatar
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.person,
                          color: Color(0xFF2F5D9F), size: 28),
                    ),

                    const SizedBox(width: 12),

                    /// Name + Location
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amarjeet Kumar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Bhagalpur",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    /// Match %
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        "85%",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// 🔹 SKILLS
              _card(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Skills",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: [
                        _chip("Python", true),
                        _chip("SQL", true),
                        _chip("Flutter", true),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// 🔹 MISSING SKILLS
              _card(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Missing Skills",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: [
                        _chip("React", false),
                        _chip("NodeJS", false),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// 🔹 EDUCATION
              _card(
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Education",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 8),
                    Text("B.Tech - Computer Science"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// 🔹 EXPERIENCE
              _card(
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Experience",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 8),
                    Text("Fresher / Internship Experience"),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// 🔥 BUTTONS
              _buttons(context),

              const SizedBox(height: 50), // 🔥 bottom safe space
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 CARD
  Widget _card(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
          )
        ],
      ),
      child: child,
    );
  }

  /// 🔹 CHIP (UPGRADED)
  Widget _chip(String text, bool isSkill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color:
        isSkill ? const Color(0xFFE8F0FE) : const Color(0xFFFFE0B2),
        borderRadius: BorderRadius.circular(12),
        border: isSkill
            ? Border.all(color: const Color(0xFF2F5D9F).withOpacity(0.2))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color:
          isSkill ? const Color(0xFF2F5D9F) : const Color(0xFFE65100),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 🔹 BUTTONS
  Widget _buttons(BuildContext context) {
    return Column(
      children: [

        /// 🔥 HIRE
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Candidate Hired")),
              );
            },
            icon: const Icon(Icons.check_circle, color: Colors.white),
            label: const Text(
              "Hire Candidate",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22C55E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 5,
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// 🔥 CHAT
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text("Chat with Candidate"),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2F5D9F),
              side: const BorderSide(color: Color(0xFF2F5D9F), width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// 🔥 RESUME
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF2F5D9F),
              side: const BorderSide(color: Color(0xFF2F5D9F)),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              "View Resume",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}