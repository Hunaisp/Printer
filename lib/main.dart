import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'multi_page_pdf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiPagePdf(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            generatePdf().then((pdfBytes) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PdfPreviewScreen(pdfBytes)),
              );
            });
          },
          child: Text('Generate and Preview PDF'),
        ),
      ),
    );
  }

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    // Example list of Container data
    final List<ContainerData> containerList = [
      ContainerData(
        headline: 'HEADLINE',
        subheadline: 'COSTUMES',
        address: 'Opp. KMT Silks, Collegepadi 1',
        phoneNumber: '9895 03 64 42, 9995 14 73 11',
      ),
      ContainerData(
        headline: 'HEADLINE',
        subheadline: 'COSTUMES',
        address: 'Opp. KMT Silks, Collegepadi 2',
        phoneNumber: '9895 03 64 42, 9995 14 73 12',
      ),
      // Add more ContainerData as needed
    ];

    for (final containerData in containerList) {
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return buildPdfContainer(
            headline: containerData.headline,
            subheadline: containerData.subheadline,
            address: containerData.address,
            phoneNumber: containerData.phoneNumber,
          );
        },
      ));
    }

    final pdfBytes = await pdf.save();
    return pdfBytes;
  }
}

pw.Widget buildPdfContainer({
  required String headline,
  required String subheadline,
  required String address,
  required String phoneNumber,
}) {
  return pw.Container(
    height: 110,
    width: 395,
    color: PdfColor.fromInt(Colors.black.value),
    child: pw.Padding(
      padding: pw.EdgeInsets.only(left: 230, right: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text(
            headline,
            style: pw.TextStyle(
              color: PdfColor.fromInt(Colors.white.value),
              fontSize: 25,
              letterSpacing: 3,
            ),
          ),
          pw.Container(
            width: 140,
            height: 15,
            color: PdfColor.fromInt(Colors.white.value),
            child: pw.Center(
              child: pw.Text(
                subheadline,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  color: PdfColor.fromInt(Colors.black.value),
                  fontSize: 10,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw.Center(
            child: pw.Text(
              address,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                color: PdfColor.fromInt(Colors.white.value),
                fontSize: 8,
                letterSpacing: -0.1,
              ),
            ),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                phoneNumber,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  color: PdfColor.fromInt(Colors.white.value),
                  fontSize: 8,
                ),
              ),
            ],
          ),
         pw.SizedBox(height: 16),
          pw.Row(
            children: [
              pw.Text(
                'Name :  ',
                textAlign: pw.TextAlign.center,
                style:pw.TextStyle(
                  fontSize: 10,color: PdfColor.fromInt(Colors.black.value),
                  letterSpacing: 0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'AJVAD KANMANAM',
                textAlign: pw.TextAlign.center,
                style:pw.TextStyle(
                  fontSize: 10,color: PdfColor.fromInt(Colors.black.value),
                  letterSpacing: 0,
                ),
              ),

            ],
          ),
        ],
      ),
    ),
  );
}

class PdfPreviewScreen extends StatelessWidget {
  final Uint8List pdfBytes;

  PdfPreviewScreen(this.pdfBytes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              printPdf(pdfBytes);
            },
          ),
        ],
      ),
      body: PdfPreview(
        build: (format) => pdfBytes,
      ),
    );
  }

  Future<void> printPdf(Uint8List pdfBytes) async {
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfBytes);
  }
}

class ContainerData {
  final String headline;
  final String subheadline;
  final String address;
  final String phoneNumber;

  ContainerData({
    required this.headline,
    required this.subheadline,
    required this.address,
    required this.phoneNumber,
  });
}