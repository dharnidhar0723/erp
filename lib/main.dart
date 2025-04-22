// // Combined Phase 1, 2, & 3: Flutter Setup, Dart Programming, Layout & State Management, Animation & MongoDB Integration

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() => runApp(StudentTrackerApp());

// class StudentTrackerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Student Tracker',
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       home: HomePage(),
//       routes: {
//         '/graph': (context) => GraphScreen(),
//       },
//     );
//   }
// }

// class Attendance {
//   String studentName;
//   DateTime date;
//   bool isPresent;

//   Attendance(this.studentName, this.date, this.isPresent);
// }

// class MarksEntry {
//   String studentName;
//   String subject;
//   int marks;

//   MarksEntry(this.studentName, this.subject, this.marks);
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   final _nameController = TextEditingController();
//   final _subjectController = TextEditingController();
//   final _marksController = TextEditingController();

//   List<Attendance> attendanceList = [];
//   List<MarksEntry> marksList = [];
//   String selectedScreen = 'home';

//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 700),
//     );
//   }

//   Future<void> fetchStudents() async {
//     final url = Uri.parse('https://mongodb+srv://dharnidhar:dharnicse@cluster0.nuajtxj.mongodb.net/student-tracker');  // MongoDB API URL
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         attendanceList = List<Attendance>.from(data.map((item) => Attendance(item['name'], DateTime.now(), true)));
//       });
//     }
//   }

//   Future<void> saveAttendanceToMongoDB(Attendance attendance) async {
//     final url = Uri.parse('https://mongodb+srv://dharnidhar:dharnicse@cluster0.nuajtxj.mongodb.net/student-tracker/attendance');
//     await http.post(url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'studentName': attendance.studentName,
//           'date': attendance.date.toIso8601String(),
//           'isPresent': attendance.isPresent
//         }));
//     fetchStudents();
//   }

//   Future<void> saveMarksToMongoDB(MarksEntry mark) async {
//     final url = Uri.parse('https://mongodb+srv://dharnidhar:dharnicse@cluster0.nuajtxj.mongodb.net/student-tracker/marks');
//     await http.post(url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'studentName': mark.studentName,
//           'subject': mark.subject,
//           'marks': mark.marks
//         }));
//     fetchStudents();
//   }

//   void _addAttendance() {
//     final name = _nameController.text;
//     if (name.isEmpty) return;
//     final attendance = Attendance(name, DateTime.now(), true);
//     setState(() => attendanceList.add(attendance));
//     saveAttendanceToMongoDB(attendance);
//   }

//   void _addMarks() {
//     try {
//       final name = _nameController.text;
//       final subject = _subjectController.text;
//       final marks = int.parse(_marksController.text);
//       final mark = MarksEntry(name, subject, marks);
//       setState(() => marksList.add(mark));
//       saveMarksToMongoDB(mark);
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Tracker'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.show_chart),
//             onPressed: () => Navigator.pushNamed(context, '/graph'),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Student Name')),
//             TextField(controller: _subjectController, decoration: InputDecoration(labelText: 'Subject')),
//             TextField(
//               controller: _marksController,
//               decoration: InputDecoration(labelText: 'Marks'),
//               keyboardType: TextInputType.number,
//             ),
//             Row(
//               children: [
//                 ElevatedButton(onPressed: _addAttendance, child: Text('Log Attendance')),
//                 SizedBox(width: 10),
//                 ElevatedButton(onPressed: _addMarks, child: Text('Add Marks')),
//               ],
//             ),
//             Divider(height: 30),
//             Text("Attendance List", style: TextStyle(fontWeight: FontWeight.bold)),
//             ...attendanceList.map((a) => FadeTransition(
//               opacity: _animationController.drive(CurveTween(curve: Curves.easeInOut)),
//               child: ListTile(
//                 title: Text("${a.studentName} - ${a.date.toLocal()}"),
//                 trailing: Text(a.isPresent ? "Present" : "Absent"),
//               ),
//             )),
//             Divider(height: 30),
//             Text("Marks List", style: TextStyle(fontWeight: FontWeight.bold)),
//             ...marksList.map((m) => ListTile(
//               title: Text("${m.studentName} - ${m.subject}"),
//               trailing: Text("${m.marks}"),
//             )),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedScreen == 'home' ? 0 : 1,
//         onTap: (index) {
//           setState(() {
//             selectedScreen = index == 0 ? 'home' : 'graph';
//             if (selectedScreen == 'graph') {
//               Navigator.pushNamed(context, '/graph');
//             }
//           });
//         },
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Graph'),
//         ],
//       ),
//     );
//   }
// }

// class GraphScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Performance Graph")),
//       body: Center(
//         child: Text("Graph will be shown here using chart library"),
//       ),
//     );
//   }
// }








// // Full App: Student Tracker with Firebase Firestore Integration, Animation & UI

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'dart:async';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(StudentTrackerApp());
// }

// class StudentTrackerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Student Tracker',
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       home: HomePage(),
//       routes: {
//         '/graph': (context) => GraphScreen(),
//       },
//     );
//   }
// }

// class Attendance {
//   String studentName;
//   DateTime date;
//   bool isPresent;

//   Attendance(this.studentName, this.date, this.isPresent);
// }

// class MarksEntry {
//   String studentName;
//   String subject;
//   int marks;

//   MarksEntry(this.studentName, this.subject, this.marks);
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   final _nameController = TextEditingController();
//   final _subjectController = TextEditingController();
//   final _marksController = TextEditingController();

//   List<Attendance> attendanceList = [];
//   List<MarksEntry> marksList = [];
//   String selectedScreen = 'home';

//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 700),
//     );
//     fetchAttendance();
//     fetchMarks();
//   }

//   Future<void> fetchAttendance() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').get();
//     setState(() {
//       attendanceList = snapshot.docs.map((doc) => Attendance(
//         doc['studentName'],
//         DateTime.parse(doc['date']),
//         doc['isPresent'],
//       )).toList();
//     });
//   }

//   Future<void> fetchMarks() async {
//     final snapshot = await FirebaseFirestore.instance.collection('marks').get();
//     setState(() {
//       marksList = snapshot.docs.map((doc) => MarksEntry(
//         doc['studentName'],
//         doc['subject'],
//         doc['marks'],
//       )).toList();
//     });
//   }

//   Future<void> saveAttendanceToFirebase(Attendance attendance) async {
//     await FirebaseFirestore.instance.collection('attendance').add({
//       'studentName': attendance.studentName,
//       'date': attendance.date.toIso8601String(),
//       'isPresent': attendance.isPresent,
//     });
//     fetchAttendance();
//   }

//   Future<void> saveMarksToFirebase(MarksEntry mark) async {
//     await FirebaseFirestore.instance.collection('marks').add({
//       'studentName': mark.studentName,
//       'subject': mark.subject,
//       'marks': mark.marks,
//     });
//     fetchMarks();
//   }

//   void _addAttendance() {
//     final name = _nameController.text;
//     if (name.isEmpty) return;
//     final attendance = Attendance(name, DateTime.now(), true);
//     setState(() => attendanceList.add(attendance));
//     saveAttendanceToFirebase(attendance);
//   }

//   void _addMarks() {
//     try {
//       final name = _nameController.text;
//       final subject = _subjectController.text;
//       final marks = int.parse(_marksController.text);
//       final mark = MarksEntry(name, subject, marks);
//       setState(() => marksList.add(mark));
//       saveMarksToFirebase(mark);
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Tracker'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.show_chart),
//             onPressed: () => Navigator.pushNamed(context, '/graph'),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Student Name')),
//             TextField(controller: _subjectController, decoration: InputDecoration(labelText: 'Subject')),
//             TextField(
//               controller: _marksController,
//               decoration: InputDecoration(labelText: 'Marks'),
//               keyboardType: TextInputType.number,
//             ),
//             Row(
//               children: [
//                 ElevatedButton(onPressed: _addAttendance, child: Text('Log Attendance')),
//                 SizedBox(width: 10),
//                 ElevatedButton(onPressed: _addMarks, child: Text('Add Marks')),
//               ],
//             ),
//             Divider(height: 30),
//             Text("Attendance List", style: TextStyle(fontWeight: FontWeight.bold)),
//             ...attendanceList.map((a) => FadeTransition(
//               opacity: _animationController.drive(CurveTween(curve: Curves.easeInOut)),
//               child: ListTile(
//                 title: Text("${a.studentName} - ${a.date.toLocal()}"),
//                 trailing: Text(a.isPresent ? "Present" : "Absent"),
//               ),
//             )),
//             Divider(height: 30),
//             Text("Marks List", style: TextStyle(fontWeight: FontWeight.bold)),
//             ...marksList.map((m) => ListTile(
//               title: Text("${m.studentName} - ${m.subject}"),
//               trailing: Text("${m.marks}"),
//             )),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedScreen == 'home' ? 0 : 1,
//         onTap: (index) {
//           setState(() {
//             selectedScreen = index == 0 ? 'home' : 'graph';
//             if (selectedScreen == 'graph') {
//               Navigator.pushNamed(context, '/graph');
//             }
//           });
//         },
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Graph'),
//         ],
//       ),
//     );
//   }
// }

// class GraphScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Performance Graph")),
//       body: Center(
//         child: Text("Graph will be shown here using chart library"),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';

// const FirebaseOptions firebaseConfig = FirebaseOptions(
//   apiKey: "AIzaSyCNXUJLb8DFNaaujQgvxLsFgM-vcetWdtk",
//   authDomain: "student-tracker-app-9d44c.firebaseapp.com",
//   projectId: "student-tracker-app-9d44c",
//   storageBucket: "student-tracker-app-9d44c.appspot.com",
//   messagingSenderId: "406752686542",
//   appId: "1:406752686542:web:fc9af9c6fae2154257bb9f",
//   measurementId: "G-22DEER16NW",
// );

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     if (Firebase.apps.isEmpty) {
//       await Firebase.initializeApp(options: firebaseConfig);
//       print("✅ Firebase Initialized Successfully");
//     } else {
//       print("ℹ️ Firebase already initialized.");
//     }
//   } catch (e) {
//     print("❌ Firebase Init Failed: $e");
//   }
//   runApp(StudentTrackerApp());
// }

// class StudentTrackerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Student Tracker',
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       home: HomePage(),
//       routes: {
//         '/graph': (context) => GraphScreen(),
//       },
//     );
//   }
// }

// class Attendance {
//   String studentName;
//   DateTime date;
//   bool isPresent;

//   Attendance(this.studentName, this.date, this.isPresent);
// }

// class MarksEntry {
//   String studentName;
//   String subject;
//   int marks;

//   MarksEntry(this.studentName, this.subject, this.marks);
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final _nameController = TextEditingController();
//   final _subjectController = TextEditingController();
//   final _marksController = TextEditingController();

//   List<Attendance> attendanceList = [];
//   List<MarksEntry> marksList = [];
//   String selectedScreen = 'home';

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       fetchAttendance();
//       fetchMarks();
//     });
//   }

//   Future<void> fetchAttendance() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance.collection('attendance').get();
//       setState(() {
//         attendanceList = snapshot.docs.map((doc) {
//           var dateField = doc['date'];
//           DateTime date;

//           if (dateField is Timestamp) {
//             date = dateField.toDate();
//           } else if (dateField is String) {
//             date = DateTime.parse(dateField);
//           } else {
//             date = DateTime.now();
//           }

//           return Attendance(
//             doc['studentName'],
//             date,
//             doc['isPresent'] ?? true,
//           );
//         }).toList();
//       });
//     } catch (e) {
//       print("❌ Error fetching attendance: $e");
//     }
//   }

//   Future<void> fetchMarks() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance.collection('marks').get();
//       setState(() {
//         marksList = snapshot.docs.map((doc) => MarksEntry(
//               doc['studentName'],
//               doc['subject'],
//               doc['marks'],
//             )).toList();
//       });
//     } catch (e) {
//       print("❌ Error fetching marks: $e");
//     }
//   }

//   Future<void> saveAttendanceToFirebase(Attendance attendance) async {
//     try {
//       await FirebaseFirestore.instance.collection('attendance').add({
//         'studentName': attendance.studentName,
//         'date': attendance.date,
//         'isPresent': attendance.isPresent,
//       });
//       await fetchAttendance();
//     } catch (e) {
//       print("❌ Failed to save attendance: $e");
//     }
//   }

//   Future<void> saveMarksToFirebase(MarksEntry mark) async {
//     try {
//       await FirebaseFirestore.instance.collection('marks').add({
//         'studentName': mark.studentName,
//         'subject': mark.subject,
//         'marks': mark.marks,
//       });
//       await fetchMarks();
//     } catch (e) {
//       print("❌ Failed to save marks: $e");
//     }
//   }

//   void _addAttendance() async {
//     final name = _nameController.text.trim();
//     if (name.isEmpty) return;
//     final attendance = Attendance(name, DateTime.now(), true);
//     await saveAttendanceToFirebase(attendance);
//     _nameController.clear();
//   }

//   void _addMarks() async {
//     final name = _nameController.text.trim();
//     final subject = _subjectController.text.trim();
//     final marks = int.tryParse(_marksController.text.trim()) ?? -1;
//     if (name.isEmpty || subject.isEmpty || marks < 0) return;

//     final mark = MarksEntry(name, subject, marks);
//     await saveMarksToFirebase(mark);
//     _nameController.clear();
//     _subjectController.clear();
//     _marksController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Tracker'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.show_chart),
//             onPressed: () async {
//               await Navigator.pushNamed(context, '/graph');
//               fetchAttendance();
//               fetchMarks();
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Student Name')),
//             TextField(controller: _subjectController, decoration: InputDecoration(labelText: 'Subject')),
//             TextField(
//               controller: _marksController,
//               decoration: InputDecoration(labelText: 'Marks'),
//               keyboardType: TextInputType.number,
//             ),
//             Row(
//               children: [
//                 ElevatedButton(onPressed: _addAttendance, child: Text('Log Attendance')),
//                 SizedBox(width: 10),
//                 ElevatedButton(onPressed: _addMarks, child: Text('Add Marks')),
//               ],
//             ),
//             Divider(height: 30),
//             Text("Attendance List", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//             SizedBox(
//               height: 200,
//               child: ListView.separated(
//                 itemCount: attendanceList.length,
//                 separatorBuilder: (context, index) => Divider(height: 1),
//                 itemBuilder: (context, index) {
//                   final a = attendanceList[index];
//                   return ListTile(
//                     title: Text("${a.studentName} - ${a.date.toLocal().toString().split(' ')[0]}"),
//                     trailing: Text(a.isPresent ? "Present" : "Absent"),
//                   );
//                 },
//               ),
//             ),
//             Divider(height: 30),
//             Text("Marks List", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//             SizedBox(
//               height: 200,
//               child: ListView.separated(
//                 itemCount: marksList.length,
//                 separatorBuilder: (context, index) => Divider(height: 1),
//                 itemBuilder: (context, index) {
//                   final m = marksList[index];
//                   return ListTile(
//                     title: Text("${m.studentName} - ${m.subject}"),
//                     trailing: Text("${m.marks}"),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedScreen == 'home' ? 0 : 1,
//         onTap: (index) {
//           setState(() {
//             selectedScreen = index == 0 ? 'home' : 'graph';
//             if (selectedScreen == 'graph') {
//               Navigator.pushNamed(context, '/graph');
//             }
//           });
//         },
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Graph'),
//         ],
//       ),
//     );
//   }
// }

// class GraphScreen extends StatefulWidget {
//   @override
//   _GraphScreenState createState() => _GraphScreenState();
// }

// class _GraphScreenState extends State<GraphScreen> {
//   late Future<Map<String, Map<String, double>>> _chartData;

//   @override
//   void initState() {
//     super.initState();
//     _chartData = _generateChartData();
//   }

//   Future<Map<String, Map<String, double>>> _generateChartData() async {
//     final marksSnapshot = await FirebaseFirestore.instance.collection('marks').get();
//     final attendanceSnapshot = await FirebaseFirestore.instance.collection('attendance').get();

//     final Map<String, List<int>> marksMap = {};
//     final Map<String, int> attendanceCount = {};

//     for (var doc in marksSnapshot.docs) {
//       final name = doc['studentName'];
//       final marks = doc['marks'];
//       marksMap.putIfAbsent(name, () => []).add(marks);
//     }

//     for (var doc in attendanceSnapshot.docs) {
//       final name = doc['studentName'];
//       final isPresent = doc['isPresent'] ?? true;
//       if (isPresent) attendanceCount[name] = (attendanceCount[name] ?? 0) + 1;
//     }

//     final data = <String, Map<String, double>>{};
//     for (var name in {...marksMap.keys, ...attendanceCount.keys}) {
//       final totalMarks = marksMap[name]?.reduce((a, b) => a + b) ?? 0;
//       final count = marksMap[name]?.length ?? 0;
//       final avgMarks = count > 0 ? totalMarks / count : 0.0;
//       final presentDays = attendanceCount[name]?.toDouble() ?? 0.0;
//       data[name] = {
//         'marks': avgMarks,
//         'attendance': presentDays,
//       };
//     }

//     return data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Performance Graph")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FutureBuilder<Map<String, Map<String, double>>>(
//           future: _chartData,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

//             final students = snapshot.data!.keys.toList();
//             final barGroups = <BarChartGroupData>[];

//             for (int i = 0; i < students.length; i++) {
//               final student = students[i];
//               final values = snapshot.data![student]!;
//               barGroups.add(BarChartGroupData(
//                 x: i,
//                 barRods: [
//                   BarChartRodData(toY: values['marks']!, color: Colors.blue),
//                   BarChartRodData(toY: values['attendance']!, color: Colors.green),
//                 ],
//                 showingTooltipIndicators: [0, 1],
//               ));
//             }

//             return BarChart(
//               BarChartData(
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, _) {
//                         final index = value.toInt();
//                         return Text(students[index]);
//                       },
//                     ),
//                   ),
//                 ),
//                 borderData: FlBorderData(show: false),
//                 barGroups: barGroups,
//                 gridData: FlGridData(show: true),
//                 groupsSpace: 20,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

const FirebaseOptions firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyCNXUJLb8DFNaaujQgvxLsFgM-vcetWdtk",
  authDomain: "student-tracker-app-9d44c.firebaseapp.com",
  projectId: "student-tracker-app-9d44c",
  storageBucket: "student-tracker-app-9d44c.appspot.com",
  messagingSenderId: "406752686542",
  appId: "1:406752686542:web:fc9af9c6fae2154257bb9f",
  measurementId: "G-22DEER16NW",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: firebaseConfig);
      print("✅ Firebase Initialized Successfully");
    } else {
      print("ℹ️ Firebase already initialized.");
    }
  } catch (e) {
    print("❌ Firebase Init Failed: $e");
  }
  runApp(StudentTrackerApp());
}

class StudentTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Tracker',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
      routes: {
        '/graph': (context) => GraphScreen(),
      },
    );
  }
}

class Attendance {
  String studentName;
  DateTime date;
  bool isPresent;

  Attendance(this.studentName, this.date, this.isPresent);
}

class MarksEntry {
  String studentName;
  String subject;
  int marks;

  MarksEntry(this.studentName, this.subject, this.marks);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _marksController = TextEditingController();

  List<Attendance> attendanceList = [];
  List<MarksEntry> marksList = [];
  String selectedScreen = 'home';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAttendance();
      fetchMarks();
    });
  }

  Future<void> fetchAttendance() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('attendance').get();
      setState(() {
        attendanceList = snapshot.docs.map((doc) {
          var dateField = doc['date'];
          DateTime date;
          if (dateField is Timestamp) {
            date = dateField.toDate();
          } else if (dateField is String) {
            date = DateTime.parse(dateField);
          } else {
            date = DateTime.now();
          }
          return Attendance(
            doc['studentName'],
            date,
            doc['isPresent'] ?? true,
          );
        }).toList();
      });
    } catch (e) {
      print("❌ Error fetching attendance: $e");
    }
  }

  Future<void> fetchMarks() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('marks').get();
      setState(() {
        marksList = snapshot.docs.map((doc) => MarksEntry(
              doc['studentName'],
              doc['subject'],
              doc['marks'],
            )).toList();
      });
    } catch (e) {
      print("❌ Error fetching marks: $e");
    }
  }

  Future<void> saveAttendanceToFirebase(Attendance attendance) async {
    try {
      await FirebaseFirestore.instance.collection('attendance').add({
        'studentName': attendance.studentName,
        'date': attendance.date,
        'isPresent': attendance.isPresent,
      });
      await fetchAttendance();
    } catch (e) {
      print("❌ Failed to save attendance: $e");
    }
  }

  Future<void> saveMarksToFirebase(MarksEntry mark) async {
    try {
      await FirebaseFirestore.instance.collection('marks').add({
        'studentName': mark.studentName,
        'subject': mark.subject,
        'marks': mark.marks,
      });
      await fetchMarks();
    } catch (e) {
      print("❌ Failed to save marks: $e");
    }
  }

  void _addAttendance() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final attendance = Attendance(name, DateTime.now(), true);
    await saveAttendanceToFirebase(attendance);
    _nameController.clear();
  }

  void _addMarks() async {
    final name = _nameController.text.trim();
    final subject = _subjectController.text.trim();
    final marks = int.tryParse(_marksController.text.trim()) ?? -1;
    if (name.isEmpty || subject.isEmpty || marks < 0) return;

    final mark = MarksEntry(name, subject, marks);
    await saveMarksToFirebase(mark);
    _nameController.clear();
    _subjectController.clear();
    _marksController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () async {
              await Navigator.pushNamed(context, '/graph');
              fetchAttendance();
              fetchMarks();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Student Name')),
            TextField(controller: _subjectController, decoration: InputDecoration(labelText: 'Subject')),
            TextField(
              controller: _marksController,
              decoration: InputDecoration(labelText: 'Marks'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                ElevatedButton(onPressed: _addAttendance, child: Text('Log Attendance')),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _addMarks, child: Text('Add Marks')),
              ],
            ),
            Divider(height: 30),
            Text("Attendance List", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: attendanceList.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final a = attendanceList[index];
                  return ListTile(
                    title: Text("${a.studentName} - ${a.date.toLocal().toString().split(' ')[0]}"),
                    trailing: Text(a.isPresent ? "Present" : "Absent"),
                  );
                },
              ),
            ),
            Divider(height: 30),
            Text("Marks List", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: marksList.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final m = marksList[index];
                  return ListTile(
                    title: Text("${m.studentName} - ${m.subject}"),
                    trailing: Text("${m.marks}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedScreen == 'home' ? 0 : 1,
        onTap: (index) {
          setState(() {
            selectedScreen = index == 0 ? 'home' : 'graph';
            if (selectedScreen == 'graph') {
              Navigator.pushNamed(context, '/graph');
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Graph'),
        ],
      ),
    );
  }
}

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  late Future<Map<String, Map<String, double>>> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _generateChartData();
  }

  Future<Map<String, Map<String, double>>> _generateChartData() async {
    final marksSnapshot = await FirebaseFirestore.instance.collection('marks').get();
    final attendanceSnapshot = await FirebaseFirestore.instance.collection('attendance').get();

    final Map<String, List<int>> marksMap = {};
    final Map<String, int> attendanceCount = {};

    for (var doc in marksSnapshot.docs) {
      final name = doc['studentName'];
      final marks = doc['marks'];
      marksMap.putIfAbsent(name, () => []).add(marks);
    }

    for (var doc in attendanceSnapshot.docs) {
      final name = doc['studentName'];
      final isPresent = doc['isPresent'] ?? true;
      if (isPresent) attendanceCount[name] = (attendanceCount[name] ?? 0) + 1;
    }

    final data = <String, Map<String, double>>{};
    for (var name in {...marksMap.keys, ...attendanceCount.keys}) {
      final totalMarks = marksMap[name]?.reduce((a, b) => a + b) ?? 0;
      final count = marksMap[name]?.length ?? 0;
      final avgMarks = count > 0 ? totalMarks / count : 0.0;
      final presentDays = attendanceCount[name]?.toDouble() ?? 0.0;
      data[name] = {
        'marks': avgMarks,
        'attendance': presentDays,
      };
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Performance Graph")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, Map<String, double>>>(
          future: _chartData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

            final students = snapshot.data!.keys.toList();
            final barGroups = <BarChartGroupData>[];

            for (int i = 0; i < students.length; i++) {
              final student = students[i];
              final values = snapshot.data![student]!;
              barGroups.add(BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(toY: values['marks']!, color: Colors.blue),
                  BarChartRodData(toY: values['attendance']!, color: Colors.green),
                ],
                showingTooltipIndicators: [0, 1],
              ));
            }

            return BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final index = value.toInt();
                        return Text(students[index]);
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: barGroups,
                gridData: FlGridData(show: true),
                groupsSpace: 20,
              ),
            );
          },
        ),
      ),
    );
  }
}
