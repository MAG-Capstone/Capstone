import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;


class QRScanner extends StatefulWidget {
    const QRScanner({
    super.key,
    required this.cameras,
  
  });

final List<CameraDescription> cameras;

  
  
  @override
  _QRState createState() => _QRState();
}

class _QRState extends State<QRScanner> {

 late CameraController _controller;

  @override
  void initState() {
    initCamera();
    super.initState();
  }
  
  initCamera(){
  _controller = CameraController(_cameras[0], ResolutionPreset.max);
  _controller.initialize().then((_){
    if(!mounted){
      return;
    }
    setState(() {});
  }
  );  
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
}

  @override
  Widget build(BuildContext context) {

   if(!_controller.value.isInitialized){
    return Container();
   }
   else{
    return CameraPreview(_controller);
   }

  }
}