import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:printer/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  runApp(const MyApp('Printing Demo'));
}
String path='';
class MyApp extends StatefulWidget {
  const MyApp(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_ , child) {
          return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: Demo()
        ),
      );}
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
  Future<Uint8List> saveFile(document, String name) async {
    final directory = await getExternalStorageDirectory();
    final File file = File('${directory?.path}/$name.pdf');

    await file.writeAsBytes(await document.save());
    debugPrint('Saved exported PDF at: ${file.path}');
    final bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }

  Future<Uint8List> loadExistingPdfFile() async {
    // Replace this with code to load your existing PDF file
    // For example, you can use the 'path_provider' package to get the file as bytes
    // and return it as a Uint8List.
    // Here's an example using 'package:path_provider/path_provider.dart':
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = File(appDocDir.absolute.path);
    print('sufail'+appDocDir.absolute.path);
    final bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }

  Future<void> _selectAndPrintPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        path=result.paths[0].toString();
      });
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
