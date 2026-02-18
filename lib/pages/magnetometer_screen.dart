import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerScreen extends StatelessWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MagnetometerEvent>(
      stream: magnetometerEventStream(
        samplingPeriod: SensorInterval.uiInterval,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final data = snapshot.data!;
        // Calculate heading in radians
        double heading = math.atan2(data.y, data.x);

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -heading, // Rotate opposite to heading
                child: const Icon(
                  Icons.explore,
                  size: 200,
                  color: Color(0x9f4376f8),
                ),
              ),
              const SizedBox(height: 40),
              Text("Magnetic Field Strength:"),
              Text("${data.x.toStringAsFixed(1)} μT (X)"),
              Text("${data.y.toStringAsFixed(1)} μT (Y)"),
            ],
          ),
        );
      },
    );
  }
}
