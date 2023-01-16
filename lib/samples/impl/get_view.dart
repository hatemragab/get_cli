import '../../common/utils/pubspec/pubspec_utils.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from Module_View file creation.
class GetViewSample extends Sample {
  final String _controllerDir;
  final String _viewName;
  final String _controller;
  final bool _isServer;

  GetViewSample(String path, this._viewName, this._controller,
      this._controllerDir, this._isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  String get import => _controllerDir.isNotEmpty
      ? '''import 'package:${PubspecUtils.projectName}/$_controllerDir';'''
      : '';

  String get _controllerName =>
      _controller.isNotEmpty ? 'GetView<$_controller>' : 'GetView';

  String get _flutterView => '''import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:super_up_core/super_up_core.dart';
import 'package:v_chat_utils/v_chat_utils.dart';
$import

class $_viewName extends $_controllerName {
 const $_viewName({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$_viewName'),
      ),
      body: GetBuilder<$_controllerName>(
        assignId: true,
        builder: (logic) {
          return VAsyncWidgetsBuilder(
            loadingState: logic.loadingState,
            onRefresh: controller.getData,
            loadingWidget: () => const SLoadingWidget(),
            errorWidget: () => const SErrorWidget(),
            emptyWidget: () => const SEmptyWidget(),
            successWidget: () {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final item = logic.data[index];
                  return ListTile(
                    title: "test".text,
                  );
                },
                itemCount: logic.data.length,
              );
            },
          );
        },
      ),
    );
  }
}
  ''';

  String get _serverView =>
      '''import 'package:get_server/get_server.dart'; $import

class $_viewName extends $_controllerName {
  @override
  Widget build(BuildContext context) {
    return const Text('GetX to Server is working!');
  }
}
  ''';

  @override
  String get content => _isServer ? _serverView : _flutterView;
}
