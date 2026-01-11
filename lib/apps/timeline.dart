// import 'package:flutter/material.dart';

// class TimelineApp extends StatelessWidget {
//   final VoidCallback onClose;

//   TimelineApp({super.key, required this.onClose});

//   final List<TimelineData> timeline = [
//     TimelineData(
//       title: "10th Class",
//       subtitle: "Secondary Education",
//       year: "2016",
//       icon: Icons.school,
//     ),
//     TimelineData(
//       title: "12th Class",
//       subtitle: "Higher Secondary",
//       year: "2018",
//       icon: Icons.school_outlined,
//     ),
//     TimelineData(
//       title: "BCA",
//       subtitle: "Bachelor of Computer Applications",
//       year: "2018 – 2021",
//       icon: Icons.computer,
//     ),
//     TimelineData(
//       title: "1st Internship",
//       subtitle: "Mobile App Development",
//       year: "2021",
//       icon: Icons.work_outline,
//     ),
//     TimelineData(
//       title: "2nd Internship",
//       subtitle: "Flutter Developer",
//       year: "2022",
//       icon: Icons.work,
//     ),
//     TimelineData(
//       title: "1st Job",
//       subtitle: "Flutter Developer",
//       year: "2023",
//       icon: Icons.badge,
//     ),
//     TimelineData(
//       title: "MCA",
//       subtitle: "Master of Computer Applications",
//       year: "2024 – Present",
//       icon: Icons.school_rounded,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,

//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, size: 18),
//           onPressed: onClose,
//         ),
//         title: const Text(
//           "Timeline",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//       ),

//       body: SafeArea(
//         child: ListView.separated(
//           padding: const EdgeInsets.all(16),
//           itemCount: timeline.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 8),
//           itemBuilder: (context, index) {
//             return TimelineItem(timeline[index]); // ✅ FIXED
//           },
//         ),
//       ),
//     );
//   }
// }

// class TimelineItem extends StatelessWidget {
//   final TimelineData data;

//   const TimelineItem(this.data, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // LEFT: Line + Circle
//         Column(
//           children: [
//             Container(width: 2, height: 12, color: Colors.white24),
//             Container(
//               height: 36,
//               width: 36,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.black,
//                 border: Border.all(color: Colors.white70, width: 2),
//               ),
//               child: Icon(data.icon, size: 16, color: Colors.white),
//             ),
//             Container(width: 2, height: 60, color: Colors.white24),
//           ],
//         ),

//         const SizedBox(width: 16),

//         // RIGHT: Content
//         Expanded(
//           child: Container(
//             margin: const EdgeInsets.only(top: 6),
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(color: Colors.white24),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   data.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   data.subtitle,
//                   style: const TextStyle(color: Colors.white70, fontSize: 12),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   data.year,
//                   style: const TextStyle(color: Colors.white38, fontSize: 11),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class TimelineData {
//   final String title;
//   final String subtitle;
//   final String year;
//   final IconData icon;

//   TimelineData({
//     required this.title,
//     required this.subtitle,
//     required this.year,
//     required this.icon,
//   });
// }

import 'package:flutter/material.dart';

class TimelineApp extends StatelessWidget {
  final VoidCallback onClose;

  TimelineApp({Key? key, required this.onClose}) : super(key: key);

  final List<TimelineData> timeline = [
    TimelineData(
      year: "2016",
      title: "10th Class",
      subtitle: "Secondary Education",
      icon: Icons.school,
    ),
    TimelineData(
      year: "2018",
      title: "12th Class",
      subtitle: "Higher Secondary",
      icon: Icons.school_outlined,
    ),
    TimelineData(
      year: "2021",
      title: "BCA",
      subtitle: "Bachelor of Computer Applications",
      icon: Icons.computer,
    ),
    TimelineData(
      year: "2022",
      title: "Internship 1",
      subtitle: "Flutter Developer Intern",
      icon: Icons.work_outline,
    ),
    TimelineData(
      year: "2023",
      title: "Internship 2",
      subtitle: "Mobile App Developer",
      icon: Icons.work,
    ),
    TimelineData(
      year: "2024",
      title: "First Job",
      subtitle: "Flutter Developer",
      icon: Icons.badge,
    ),
    TimelineData(
      year: "2025",
      title: "MCA",
      subtitle: "Master of Computer Applications",
      icon: Icons.school,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white),
          onPressed: onClose,
        ),
        title: const Text(
          "Timeline",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Stack(
          children: [
            // 🔹 CONTINUOUS CENTER LINE
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(width: 2, color: Colors.white24),
              ),
            ),

            // 🔹 TIMELINE ITEMS
            ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 24),
              itemCount: timeline.length,
              itemBuilder: (context, index) {
                return TimelineItem(
                  data: timeline[index],
                  isLeft: index.isEven,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final TimelineData data;
  final bool isLeft;

  const TimelineItem({Key? key, required this.data, required this.isLeft})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT CARD
          Expanded(child: isLeft ? _card() : const SizedBox()),

          // CENTER DOT
          SizedBox(
            width: 40,
            child: Center(
              child: Container(
                height: 14,
                width: 14,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // RIGHT CARD
          Expanded(child: !isLeft ? _card() : const SizedBox()),
        ],
      ),
    );
  }

  Widget _card() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.year,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(data.icon, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            data.subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class TimelineData {
  final String title;
  final String subtitle;
  final String year;
  final IconData icon;

  TimelineData({
    required this.title,
    required this.subtitle,
    required this.year,
    required this.icon,
  });
}
