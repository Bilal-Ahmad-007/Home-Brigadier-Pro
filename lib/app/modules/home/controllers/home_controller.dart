import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:homebrigadier_pro/consts/static_values.dart';

class HomeController extends GetxController {
  late final WebViewController webController;
  var loadPercentage = 0.obs;
  var url = ''.obs;

  @override
  void onInit() {
    super.onInit();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (change) {},
        onPageStarted: (url) {
          loadPercentage.value = 0;
          this.url.value = url;
        },
        onProgress: (progress) {
          loadPercentage.value = progress;
        },
        onPageFinished: (url) {
          loadPercentage.value = 100;
        },
      ))
      ..loadRequest(
        Uri.parse(StaticValue.webUrl),
      );

    if (Platform.isAndroid) {
      addFileSelectionListener();
    }
  }

  void addFileSelectionListener() async {
    final androidController =
        webController.platform as AndroidWebViewController;
    await androidController.setOnShowFileSelector(_androidFilePicker);
  }

  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      return [file.uri.toString()];
    }
    return [];
  }
}
