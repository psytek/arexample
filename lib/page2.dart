import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

class Page2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  const Page2({Key key, @required this.yourname}) : super(key: key);
  final String yourname;
}

class _MyAppState extends State<Page2> {
  ARKitController arkitController;
  ARKitNode nodeText;
  bool nameVisible = false;
  ARKitSphere sphere;
  ARKitText text;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Tap the sphere'),
        ),
        body: ARKitSceneView(
          onARKitViewCreated: onARKitViewCreated,
          enableTapRecognizer: true,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (ar) {
      if (nameVisible) {
        this.arkitController.remove(nodeText.name);
        nameVisible = false;
      } else {
        this.arkitController.add(nodeText);
        nameVisible = true;
      }
    };

    text = ARKitText(
      text: widget.yourname,
      extrusionDepth: 1,
    );

    sphere = ARKitSphere(
      radius: 0.1,
    );

    nodeText = ARKitNode(
      geometry: text,
      position: Vector3(-0.3, 0.3, -1.4),
      scale: Vector3(0.02, 0.02, 0.02),
    );

    final nodeSphere = ARKitNode(
      geometry: sphere,
      position: Vector3(0, 0, -0.5),
    );

    this.arkitController.add(nodeSphere);
  }
}
