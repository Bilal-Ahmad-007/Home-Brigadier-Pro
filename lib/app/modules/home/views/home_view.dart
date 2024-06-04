import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:homebrigadier_pro/app/modules/home/controllers/home_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Platform.isAndroid
              ? WillPopScope(
                  onWillPop: () async {
                    if (await controller.webController.canGoBack()) {
                      await controller.webController.goBack();
                      return false;
                    } else {
                      SystemNavigator.pop();
                      return true;
                    }
                  },
                  child: _webViewBody(context),
                )
              : GestureDetector(
                  onHorizontalDragEnd: (details) async {
                    if (details.primaryVelocity! > 0) {
                      await controller.webController.canGoBack()
                          ? controller.webController.goBack()
                          : log("last page");
                    }
                  },
                  child: _webViewBody(context),
                ),
        ),
      ),
    );
  }

  Widget _webViewBody(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: controller.webController),
        Obx(() => controller.loadPercentage.value < 100
            ? Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.sizeOf(context).height * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: LinearProgressIndicator(
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                            value: controller.loadPercentage.toDouble() / 100)),
                    const Spacer(),
                    SvgPicture.asset(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      fit: BoxFit.scaleDown,
                      'assets/images/site_logo.svg',
                    ),
                    const Spacer(),
                  ],
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}
