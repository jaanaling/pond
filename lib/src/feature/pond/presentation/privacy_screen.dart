import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivicyScreen extends StatefulWidget {
  const PrivicyScreen({super.key});

  @override
  State<PrivicyScreen> createState() => _PrivicyScreenState();
}

class _PrivicyScreenState extends State<PrivicyScreen> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: CupertinoColors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF2b7a78),
      child: Stack(
        children: [
        
          Padding(
            padding: EdgeInsets.only(top: 114 + MediaQuery.of(context).padding.top,),
            child: SafeArea(
              top: false,
              child: WebViewWidget(
                controller: _controller
                  ..loadRequest(
                    Uri.parse('https://pondcarea.com/privacy.html'),
                  )
                  ..setBackgroundColor(
                    Color(0xFF2b7a78),
                  ),
              ),
            ),
          ),
          const AppBarWidget(
            title: 'Privacy Policy',
            hasBackIcon: true,
          ),
        ],
      ),
    );
  }
}
