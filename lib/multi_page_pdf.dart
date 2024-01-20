import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pdf/pdf.dart' as pdfLib;
import 'package:pdf/widgets.dart' as pw;

class MultiPagePdf extends StatefulWidget {
  const MultiPagePdf({Key? key}) : super(key: key);

  @override
  State<MultiPagePdf> createState() => _MultiPagePdfState();
}

class MeasurmentData {
  final String headline;
  final String subheadline;
  final String address;
  final String phoneNumber;

  MeasurmentData({
    required this.headline,
    required this.subheadline,
    required this.address,
    required this.phoneNumber,
  });
}

class _MultiPagePdfState extends State<MultiPagePdf> {
  late List<MeasurmentData> bills;

  @override
  void initState() {
    super.initState();

    bills = List.generate(
      10,
          (index) => MeasurmentData(
        headline: 'HEADLINE',
        subheadline: 'COSTUMES',
        address: 'Opp. KMT Silks, Collegepadi',
        phoneNumber: '9895 03 64 42, 9995 14 73 11',
      ),
    );
  }

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    for (int index = 0; index < bills.length; index++) {
      final containerData = bills[index];

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

    return pdf.save();
  }

  pw.Widget buildPdfContainer({
    required String headline,
    required String subheadline,
    required String address,
    required String phoneNumber,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          height: 110,
          width: 470,
          color: pdfLib.PdfColor.fromInt(Colors.black.value),
          child: pw.Padding(
            padding: pw.EdgeInsets.only(left: 230, right: 0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  headline,
                  style: pw.TextStyle(
                    color: pdfLib.PdfColor.fromInt(Colors.white.value),
                    fontSize: 25,
                    letterSpacing: 3,
                  ),
                ),
                pw.Container(
                  width: 140,
                  height: 15,
                  color: pdfLib.PdfColor.fromInt(Colors.white.value),
                  child: pw.Center(
                    child: pw.Text(
                      subheadline,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        color: pdfLib.PdfColor.fromInt(Colors.black.value),
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
                      color: pdfLib.PdfColor.fromInt(Colors.white.value),
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
                        color: pdfLib.PdfColor.fromInt(Colors.white.value),
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: () {
          generatePdf().then((pdfBytes) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfPreviewScreen(pdfBytes: pdfBytes),
              ),
            );
          });
        },
        child: SizedBox(
          width: 200,
          height: 40,
          child: Center(
            child: Text("Preview"),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: bills.length,
        itemBuilder: (BuildContext context, int index) {
          return Text("Hello");
        },
      ),
    );
  }
}

class PdfPreviewScreen extends StatelessWidget {
  final Uint8List pdfBytes;

  const PdfPreviewScreen({Key? key, required this.pdfBytes}) : super(key: key);

  Future<void> printPdf(Uint8List pdfBytes) async {
    PdfPageFormat format = PdfPageFormat(
      8.5 * PdfPageFormat.inch,
      11.0 * PdfPageFormat.inch,
      marginLeft: 80.0,
      marginRight: 70.0,
      marginTop: 20.0,
      marginBottom: 70.0,
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
      format: format,
    );
  }

  // Function to handle sharing
  void _handleShare() {
    //Share.shareFiles(['path/to/your/pdf/file.pdf'], text: 'Check out this PDF!');
  }

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
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _handleShare,
          ),
        ],
      ),
      body: SfPdfViewer.memory(pdfBytes),
    );
  }
}
