import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class SpherePage extends StatefulWidget {
  @override
  _SpherePageState createState() => _SpherePageState();
  const SpherePage({Key key, @required this.yourname}) : super(key: key);
  final String yourname;
}

class _SpherePageState extends State<SpherePage> {
  ARKitController arkitController;
  ARKitSphere sphere;
  ARKitText text;
  ARKitNode nodeText;
  bool nameVisible = false;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('inCitu Example')),
        body: Container(
          child: ARKitSceneView(
            enableTapRecognizer: true,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodeTap = (nodes) => onNodeTapHandler(nodes);

    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty(
        color: Colors.red,
      ),
    );

    text = ARKitText(
      text: widget.yourname,
      extrusionDepth: 1,
      materials: [material],
    );

    sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );

    nodeText = ARKitNode(
      name: 'text',
      geometry: text,
      position: vector.Vector3(-0.3, 0.3, -1.4),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );

    final nodeSphere = ARKitNode(
      name: 'sphere',
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.5),
    );

    this.arkitController.add(nodeSphere);
  }

  void onNodeTapHandler(List<String> nodesList) {
    if (nameVisible) {
      this.arkitController.remove("text");
      nameVisible = false;
    } else {
      this.arkitController.add(nodeText);
      nameVisible = true;
    }
  }
}
