import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  String imgPath;

  Future initCameraController(CameraDescription cameraDescription) async {
    if(cameraDescription != null) {
      await cameraController.dispose();
    }

    cameraController = CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if(mounted){
        setState(() {

        });
      }
    });

    if(cameraController.value.hasError){
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      await cameraController.initialize();
    } catch(e) {
      _showCameraException(e);
    }

    if(mounted){
      setState(() {

      });
    }

  }

  /// Display camera preview

  Widget _cameraPreviewWidget() {
    if(cameraController == null || !cameraController.value.isInitialized){
      return Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        ),
      );
    }

    return AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child: CameraPreview(cameraController),
    );
  }

  Widget _cameraControlWidget(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _showCameraException(e) {
    String errorText = 'Error ${e.code} \nError message: ${e.description}';
  }
}
