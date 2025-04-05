import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;
import 'dart:typed_data';

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {

  ArCoreController? augmentedRealityCoreControlller;

  augmentedRealityViewCreated(ArCoreController coreController)
  {
    augmentedRealityCoreControlller = coreController;

    displayEarthSphere(augmentedRealityCoreControlller!);
  }


  displayEarthSphere(ArCoreController coreController) async
  {
    final ByteData earthTextureBytes = await rootBundle.load("assets/images/earth_map.jpg");

    final materials = ArCoreMaterial(
      color: Colors.blue,
      textureBytes: earthTextureBytes.buffer.asUint8List(),
    );

    final sphere = ArCoreSphere(
      materials: [materials],
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5),
    );

    augmentedRealityCoreControlller!.addArCoreNode(node);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ar"),
      ),
      body: ArCoreView(
          onArCoreViewCreated: augmentedRealityViewCreated
      ),
    );
  }
}
