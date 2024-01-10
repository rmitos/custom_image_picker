import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_image_picker_platform_interface.dart';

class MethodChannelCustomImagePicker extends CustomImagePickerPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_image_picker');

  @override
  Future<Uint8List?> getImage(String imageSource) async {
    final imagePath = await methodChannel.invokeMethod<Uint8List?>('getImage', {"code": imageSource});
    return imagePath;
  }
}
