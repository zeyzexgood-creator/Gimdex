import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'gimf',
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(
seedColor: const Color(0xFF56B6C2),
brightness: Brightness.dark,
),
useMaterial3: true,
),
home: const DevStudioHomePage(),
debugShowCheckedModeBanner: false,
);
}
}

class DevStudioHomePage extends StatelessWidget {
const DevStudioHomePage({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("DevStudio Flutter App"),
centerTitle: true,
),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(
Icons.rocket_launch,
size: 80,
color: Color(0xFFFF947A),
),
const SizedBox(height: 20),
Text(
'Hello from gimf! 🚀',
style: const TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 10),
const Text(
'Your Flutter code is ready to run.',
style: TextStyle(color: Colors.grey),
),
],
),
),
floatingActionButton: FloatingActionButton(
onPressed: () {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Flutter is awesome! 💙')),
);
},
child: const Icon(Icons.favorite),
),
);
}
}