import 'package:flutter/material.dart';
class PdfDemo extends StatefulWidget {
  const PdfDemo({Key? key}) : super(key: key);

  @override
  State<PdfDemo> createState() => _PdfDemoState();
}

class _PdfDemoState extends State<PdfDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("hello"),),);
  }
}
