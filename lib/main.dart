import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  runApp(const MyApp('Printing Demo'));
}

class MyApp extends StatelessWidget {
  const MyApp(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ElevatedButton(
          onPressed: () {
            _selectAndPrintPdf().then((value) => _printPdf());
          },
          child: Text('Print PDF'),
        ),
      ),
    );
  }

  Future<void> _printPdf() async {
    // Load your existing PDF file as a Uint8List
    final existingPdf = await loadExistingPdfFile();

    // Print the existing PDF
    await Printing.layoutPdf(
      onLayout: (format) {
        return existingPdf;
      },
    );
  }

  Future<Uint8List> loadExistingPdfFile() async {
    // Replace this with code to load your existing PDF file
    // For example, you can use the 'path_provider' package to get the file as bytes
    // and return it as a Uint8List.
    // Here's an example using 'package:path_provider/path_provider.dart':
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = File('/data/user/0/com.example.printer/cache/file_picker/AccountStatement_01-APR-2022_to_20-SEP-2023.pdf');
    final bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }
  Future<void> _selectAndPrintPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      Uint8List? bytes = result.files.first.bytes;
      if (bytes != null) {
        await Printing.layoutPdf(
          onLayout: (format) {
            return bytes;
          },
        );
      }
    }
  }
}
