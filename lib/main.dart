import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terapia Libre',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          print("Loading: $url");
        },
      ))
      ..loadRequest(Uri.parse('https://terapialibre.com.ar/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xFFC1C700), // Color de la barra superior
            height: 50, // Altura de la barra superior
            width: double.infinity,
          ),
          Expanded(
            child: WillPopScope(
              onWillPop: () async {
                if (await _controller.canGoBack()) {
                  _controller.goBack();
                  return false; // Evita la navegación hacia atrás del sistema
                }
                return true; // Permite la navegación hacia atrás del sistema
              },
              child: WebViewWidget(controller: _controller),
            ),
          ),
        ],
      ),
    );
  }
}
