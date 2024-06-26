import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraUsagePage extends StatefulWidget {

  const CameraUsagePage({super.key});

  @override
  State createState() {
    return _CameraUsageState();
  }
}

class _CameraUsageState extends State<CameraUsagePage> {

  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: buildCameraWidget(),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller!.takePicture();

            if (!context.mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  //获取相机信息
  Future<void> getCameraDescription() async{
    if (_initializeControllerFuture != null) {
      return _initializeControllerFuture!;
    } else {
      final cameras = await availableCameras();
      _controller = CameraController(cameras.first, ResolutionPreset.medium);
      _initializeControllerFuture = _controller!.initialize();
      return _initializeControllerFuture;
    }
  }


  Widget buildCameraWidget() {
    return FutureBuilder<void>(
      future: getCameraDescription(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.done) {
          if (asyncSnapshot.hasError) {
            return const Center(
              child: Text("Camera Error"),
            );
          } else {
            //摄像头信息获取成功
            return showCamera();
          }
        } else {
          return const Center(
            child: Text("Camera Loading"),
          );
        }
      },
    );
  }

  Widget showCamera() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return CameraPreview(_controller!);
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }


  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}