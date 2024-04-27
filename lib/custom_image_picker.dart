import 'dart:typed_data';
import 'dart:io' as io;

import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:custom_image_picker/custom_image_picker_constants.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import 'custom_image_picker_platform_interface.dart';

class CustomImagePicker {
  Future<Uint8List?> getImage(BuildContext context) async {
    Uint8List? selectedImage;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose Image Source"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          selectedImage = await _getImage(CustomImagePickerConstants.camera);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.photo_camera,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          selectedImage = await _getImage(CustomImagePickerConstants.gallery);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
    return selectedImage;
  }

  Future<Uint8List?> _getImage(String source) async {
    if (io.Platform.isAndroid) {
      return await CustomImagePickerPlatform.instance.getImage(source);
    } else if (io.Platform.isIOS) {
      if (CustomImagePickerConstants.gallery == source) {
        return await _selectIOSImage();
      } else {
        //camera
        return await _getIOSCameraImage();
      }
    } else {
      return null;
    }
  }

  Future<Uint8List?> _selectIOSImage() async {
    XTypeGroup typeGroup = const XTypeGroup(
      label: 'Images',
      uniformTypeIdentifiers: ['public.png', 'public.jpeg'],
    );
    final XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    return await file?.readAsBytes();
  }

  Future<Uint8List?> _getIOSCameraImage() async {
    final ImagePickerPlatform picker = ImagePickerPlatform.instance;
    final XFile? file = await picker.getImageFromSource(source: ImageSource.camera);
    return await file?.readAsBytes();
  }
}
