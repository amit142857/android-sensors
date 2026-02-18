import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerScreen extends StatelessWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccelerometerEvent>(
      stream: accelerometerEventStream(
        samplingPeriod: SensorInterval.uiInterval,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final data = snapshot.data!;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0x9f4376f8),
                        width: 2,
                      ),
                    ),
                  ),
                  // Animated "Bubble" that moves based on X and Y
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 100),
                    alignment: Alignment(
                      (data.x / 10).clamp(-1.0, 1.0), // Normalize X
                      (data.y / 10).clamp(-1.0, 1.0), // Normalize Y
                    ),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0x9f4376f8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text("X: ${data.x.toStringAsFixed(2)} m/s²"),
              Text("Y: ${data.y.toStringAsFixed(2)} m/s²"),
              Text("Z: ${data.z.toStringAsFixed(2)} m/s²"),
            ],
          ),
        );
      },
    );
  }
}
