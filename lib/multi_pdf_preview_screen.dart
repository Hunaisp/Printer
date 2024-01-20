import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
class MultiPagePdfPreviewScreen extends StatefulWidget {
  final Uint8List pdfBytes;
  const MultiPagePdfPreviewScreen({super.key,required this.pdfBytes});

  @override
  State<MultiPagePdfPreviewScreen> createState() => _MultiPagePdfPreviewScreenState();
}

class _MultiPagePdfPreviewScreenState extends State<MultiPagePdfPreviewScreen> {
  Future<void> printPdf(Uint8List pdfBytes) async {
    PdfPageFormat format = PdfPageFormat(
        8.5 * PdfPageFormat.inch, 11.0 * PdfPageFormat.inch,
        marginLeft: 80.0.w,
        marginRight: 70.0.w,
        marginTop: 20.0.h,
        marginBottom: 70.0.h);

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
      format: format,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(      appBar: AppBar(leading: TextButton(onPressed: (){
      printPdf(widget.pdfBytes);
    },child: Text('Print'),),
      centerTitle: true,
      backgroundColor: Color(0xff004A10),
      title: Text('HEADLINE'),
    ),
      body: PdfPreview(
        build: (format) => widget.pdfBytes,
      ),);
  }
}
