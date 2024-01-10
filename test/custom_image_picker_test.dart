import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:custom_image_picker/custom_image_picker.dart';
import 'package:custom_image_picker/custom_image_picker_platform_interface.dart';
import 'package:custom_image_picker/custom_image_picker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCustomImagePickerPlatform with MockPlatformInterfaceMixin implements CustomImagePickerPlatform {

  @override
  Future<Uint8List?> getImage(String imageSource) {
    // TODO: implement getImage
    throw UnimplementedError();
  }
}

void main() {
  final CustomImagePickerPlatform initialPlatform = CustomImagePickerPlatform.instance;

  test('$MethodChannelCustomImagePicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCustomImagePicker>());
  });

  test('getPlatformVersion', () async {
    CustomImagePicker customImagePickerPlugin = CustomImagePicker();
    MockCustomImagePickerPlatform fakePlatform = MockCustomImagePickerPlatform();
    CustomImagePickerPlatform.instance = fakePlatform;

    //expect(await customImagePickerPlugin.getPlatformVersion(), '42');
  });
}
