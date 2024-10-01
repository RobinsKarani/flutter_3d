import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Simulate loading the model asynchronously
  Future<bool> loadModel() async {
    try {
      // Simulating model load delay
      await Future.delayed(const Duration(seconds: 2));
      // You can implement the actual model loading check here
      return true; // Model loaded successfully
    } catch (e) {
      debugPrint('Error loading 3D model: $e');
      return false; // Model failed to load
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 3D'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FutureBuilder<bool>(
            future: loadModel(), // Call the async function to load the model
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while the model is loading
                return const CircularProgressIndicator();
              } else if (snapshot.hasError || snapshot.data == false) {
                // Show an error message if model fails to load
                return const Text(
                  'Failed to load 3D model',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                );
              } else {
                // If model loads successfully, display it
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A 3d model of taco',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tap and drag to rotate the modelll',
                    ),
                    const SizedBox(height: 20),
                    
                    const SizedBox(
                      height: 400,
                      child: Flutter3DViewer(
                        src: 'assets/models/taco.gltf',
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
