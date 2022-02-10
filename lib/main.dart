// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, unnecessary_new, unrelated_type_equality_checkss

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegador Flutter',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController direccion = TextEditingController(text: "https://tienda-proyecto-183e3.web.app");
  FlutterWebviewPlugin webview = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: "https://tienda-proyecto-183e3.web.app",
        withJavascript: true,
        withLocalStorage: true,
        withZoom: false,
        enableAppScheme: true,
        appBar: AppBar(
        title:Padding(
             padding: const EdgeInsets.all(0.0),
             child: Container(
               height: 42,
              decoration: 
              BoxDecoration (
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left:6.0),
              child: TextField(
                style: TextStyle(fontSize: 15),
                textInputAction: TextInputAction.search,
                controller: direccion,
                keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon:Icon(Icons.search,
                            size: 20),
                          onPressed: (){buscarWeb();})
                          ),
                onSubmitted: (url)=>buscarWeb(),
              ),
          ),
          ), 
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Atrás',
            onPressed: () {
              webview.goBack();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Atrás')));
            }),
            IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Adelante',
            onPressed: () {
                webview.goForward();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Adelante')));
            }),IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Actualizar',
            onPressed: () {
              webview.reload();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Actualizar')));
            })
        ],
      ),   
    );
  }

  buscarWeb(){
    setState(() {
      if(!direccion.text.contains(".")){
        direccion.text = "https://www.google.es/search?q=" + direccion.text;
      }else if(!direccion.text.contains("https://")){
        direccion.text = "https://" + direccion.text;
      }
      webview.reloadUrl(direccion.text);
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }
}