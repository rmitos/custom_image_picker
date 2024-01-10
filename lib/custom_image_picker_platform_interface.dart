import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_image_picker_method_channel.dart';

abstract class CustomImagePickerPlatform extends PlatformInterface {
  CustomImagePickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomImagePickerPlatform _instance = MethodChannelCustomImagePicker();

  static CustomImagePickerPlatform get instance => _instance;

  static set instance(CustomImagePickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Uint8List?> getImage(String imageSource) {
    throw UnimplementedError('getImage() has not been implemented.');
  }
}
