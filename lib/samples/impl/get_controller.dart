import 'package:recase/recase.dart';

import '../interface/sample_interface.dart';

/// [Sample] file from Module_Controller file creation.
class ControllerSample extends Sample {
  final String _fileName;
  final bool _isServer;
  ControllerSample(String path, this._fileName, this._isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  @override
  String get content => _isServer ? serverController : flutterController;

  String get serverController => '''import 'package:get_server/get_server.dart';
import 'package:flutter/material.dart';
import 'package:v_chat_utils/v_chat_utils.dart';
class ${_fileName.pascalCase}Controller extends GetxController {
  //TODO: Implement ${_fileName.pascalCase}Controller
  

}
''';
  String get flutterController => '''import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:v_chat_utils/v_chat_utils.dart';
class ${_fileName.pascalCase}Controller extends GetxController {
   final txtController = TextEditingController();
  VChatLoadingState loadingState = VChatLoadingState.ideal;
  final _data = <dynamic>[];

  List<dynamic> get data => _data;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    await vSafeApiCall<List<dynamic>>(
      onLoading: () async {
        loadingState = VChatLoadingState.loading;
        update();
      },
      onError: (exception, trace) {
        loadingState = VChatLoadingState.error;
        update();
      },
      request: () async {
        await Future.delayed(const Duration(seconds: 4));
        return [];
      },
      onSuccess: (response) {
        loadingState = VChatLoadingState.success;
        data.addAll(response);
        update();
      },
      ignoreTimeoutAndNoInternet: false,
      showToastError: true,
    );
  }

  @override
  void onClose() {
    txtController.dispose();
    super.onClose();
  }
}
''';
}
