import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:custom_image_picker/custom_image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _customImagePickerPlugin = CustomImagePicker();

  Uint8List? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () async {
                      var img = await _customImagePickerPlugin.getImage(context);
                      setState(() {
                        _selectedImage = img;
                      });
                    },
                    child: const Text("Get Dialog"));
              }),
              _selectedImage == null
                  ? const SizedBox.shrink()
                  : Image.memory(
                      _selectedImage!,
                      height: 300,
                      width: 300,
                      fit: BoxFit.contain,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
