import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gyro/pages/accelerometer_screen.dart';
import 'package:gyro/pages/barometer_screen.dart';
import 'package:gyro/pages/gyroscope_screen.dart';
import 'package:gyro/pages/magnetometer_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // List of sensor-specific screens
  final List<Widget> _screens = [
    const AccelerometerScreen(),
    const GyroscopeScreen(),
    const MagnetometerScreen(),
    const BarometerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensor Hub')),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0x9f4376f8),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.speed), label: 'Accel'),
          BottomNavigationBarItem(
            icon: Icon(Icons.screen_rotation),
            label: 'Gyro',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Mag'),
          BottomNavigationBarItem(icon: Icon(Icons.compress), label: 'Baro'),
        ],
      ),
    );
  }
}
