import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternateScreen extends StatelessWidget {
  const NoInternateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Screen')),
      body: Center(
        child: Lottie.asset(
          'assets/animation/lottie/no connection.json', // Path to your animation file
          width: 100, // Customize the width
          height: 100, // Customize the height
          fit: BoxFit.fill, // Adjust the fit of the animation
        ),
      ),
    );
  }
}
