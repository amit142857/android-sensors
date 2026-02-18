import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class BarometerScreen extends StatelessWidget {
  const BarometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BarometerEvent>(
      stream: barometerEventStream(samplingPeriod: SensorInterval.uiInterval),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return const Center(
            child: Text("Barometer not supported on this device"),
          );
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final pressure = snapshot.data!.pressure;
        // Standard pressure is ~1013. We map 950-1050 to a height factor
        double level = ((pressure - 950) / 100).clamp(0.0, 1.0);

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: 100,
                      height: 300 * level,
                      decoration: BoxDecoration(
                        color: const Color(0x9f4376f8).withOpacity(0.6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "${pressure.toStringAsFixed(1)} hPa",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Text("Atmospheric Pressure"),
            ],
          ),
        );
      },
    );
  }
}
