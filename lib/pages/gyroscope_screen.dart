import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeScreen extends StatelessWidget {
  const GyroscopeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GyroscopeEvent>(
      stream: gyroscopeEventStream(samplingPeriod: SensorInterval.uiInterval),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final data = snapshot.data!;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Smooth rotation animation based on X and Y axis
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: data.y),
                duration: const Duration(milliseconds: 100),
                builder: (context, double value, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Perspective
                      ..rotateX(data.x)
                      ..rotateY(value),
                    alignment: Alignment.center,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0x9f4376f8),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 10),
                        ],
                      ),
                      child: const Icon(
                        Icons.mobile_friendly,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              Text("X: ${data.x.toStringAsFixed(2)}"),
              Text("Y: ${data.y.toStringAsFixed(2)}"),
              Text("Z: ${data.z.toStringAsFixed(2)}"),
            ],
          ),
        );
      },
    );
  }
}
