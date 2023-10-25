import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:printing/printing.dart';


class Demo extends StatelessWidget {
  Demo({super.key});

  final ExportDelegate exportDelegate = ExportDelegate();
  Future<Uint8List> loadExistingPdfFile() async {
    // Replace this with code to load your existing PDF file
    // For example, you can use the 'path_provider' package to get the file as bytes
    // and return it as a Uint8List.
    // Here's an example using 'package:path_provider/path_provider.dart':
    final ExportOptions overrideOptions = ExportOptions(
      pageFormatOptions: PageFormatOptions.custom(
          width: 430.w,height: 900.h,
          marginLeft: 18.w,marginRight: 17.w,
          marginBottom: 10.h,marginTop: 30.h),
      textFieldOptions: TextFieldOptions.uniform(
        interactive: false,
      ),
      checkboxOptions: CheckboxOptions.uniform(
        interactive: false,
      ),
    );
    final pdf = await exportDelegate.exportToPdfDocument('demo',
        overrideOptions: overrideOptions);
    final path=   pdf.save();
    return path;
  }
  Future<void> _printPdf() async {
    final pdf = await exportDelegate.exportToPdfDocument('demo');

    // Load your existing PDF file as a Uint8List
    final existingPdf = await loadExistingPdfFile();

    // Print the existing PDF
    await Printing.layoutPdf(
      onLayout: (format) {
        return existingPdf;
      },
    );
  }
  @override
  Widget build(BuildContext context) =>  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff004A17),
        actions: [
          Text(
            'HEADLINE',
            style:GoogleFonts.poppins(textStyle: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              height: 0,
            ),),
          ),
          SizedBox(width: 28.w,)
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () async {

              loadExistingPdfFile().then((value) => _printPdf());
              
            },
            child: const Row(
              children: [
                Text('Export as static'),
                Icon(Icons.save_alt_outlined),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {

            },
            child: const Row(
              children: [
                Text('Export as interactive'),
                Icon(Icons.save_alt_outlined),
              ],
            ),
          ),
        ],
      ),
      body: ExportFrame(
        frameId: 'demo',
        exportDelegate: exportDelegate,
        child: const QuestionnaireExample(),
      ));
}

class QuestionnaireExample extends StatefulWidget {
  const QuestionnaireExample({super.key});

  @override
  State<QuestionnaireExample> createState() => _QuestionnaireExampleState();
}

class _QuestionnaireExampleState extends State<QuestionnaireExample> {

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110.h,
          width: 395.w,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(left: 230.w,right: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'HEADLINE',
                  style:TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    letterSpacing: 3.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Container(
                  width: 140.w,
                  height: 15.h,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'COSTUMES',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        letterSpacing: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: Text(
                    'Opp. KMT Silks, Collegepadi',
                    textAlign: TextAlign.center,
                    style:TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      letterSpacing: -0.1.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      ' 9895 03 64 42, 9995 14 73 11',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],)
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              'Name :  ',
              textAlign: TextAlign.center,
              style:TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                letterSpacing: 0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'AJVAD KANMANAM',
              textAlign: TextAlign.center,
              style:TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                letterSpacing: 0.sp,
              ),
            ),

          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Date :  ',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        letterSpacing: 0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '07-09-2023',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        letterSpacing: 0.sp,
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Bill No. :  ',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        letterSpacing: 0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '5979',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 11.sp,
                        letterSpacing: 0.sp,
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Due Date :  ',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        letterSpacing: 0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '11-09-2023',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 11.sp,
                        letterSpacing: 0.sp,
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Trial Date :  ',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        letterSpacing: 0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        letterSpacing: 0.sp,
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 40.h,)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft: Radius.circular(10.r)),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(1),
                        },
                        border: TableBorder(verticalInside: BorderSide(color: Colors.black)),
                        children: [
                          TableRow(
                              children: [
                                Text(
                                  'ITEMS',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'RATE',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'QTY',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                          ),
                          TableRow( children: [Divider(color: Colors.black,),Divider(color: Colors.black,),Divider(color: Colors.black,)]),
                          TableRow(
                              children: [
                                Text(
                                  'Pants',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                                Text(
                                  '300',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                                Text(
                                  '1',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                              ]
                          ),
                          TableRow( children: [SizedBox(height: 10.h,),SizedBox(height: 10.h,),SizedBox(height: 10.h,)]),
                          TableRow(
                              children: [
                                Text(
                                  'Shirt',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                                Text(
                                  '300',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                                Text(
                                  '1',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                              ]
                          ),
                          TableRow( children: [SizedBox(height: 10.h,),SizedBox(height: 10.h,),SizedBox(height: 10.h,)]),
                          TableRow(
                              children: [
                                Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                                Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                                Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                              ]
                          ),
                          TableRow( children: [SizedBox(height: 5.h,),SizedBox(height: 5.h,),SizedBox(height: 5.h,)]),
                        ],
                      )),

                  SizedBox(width: 2.w,),
                  Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10.r),bottomRight: Radius.circular(10.r)),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                        },
                        border: TableBorder(verticalInside: BorderSide(color: Colors.black),horizontalInside: BorderSide(color: Colors.black)),
                        children: [
                          TableRow(
                              children: [
                                SizedBox(height: 20.h,
                                  child: Text(
                                    'Grand Total',
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                      letterSpacing: 0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '650',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,

                                  ),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                SizedBox(height: 20.h,
                                  child: Text(
                                    'Dicount',
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                      letterSpacing: 0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,

                                  ),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                SizedBox(height: 20.h,
                                  child: Text(
                                    'Net Total',
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                      letterSpacing: 0.sp,
                                      height: 1.7,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,

                                  ),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                SizedBox(height: 20.h,
                                  child: Text(
                                    'Advance',
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                      letterSpacing: 0.sp,
                                      height: 1.7,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,

                                  ),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                SizedBox(height: 20.h,
                                  child: Text(
                                    'Balance',
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                      letterSpacing: 0.sp,
                                      height: 1.7,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    letterSpacing: 0.sp,

                                  ),
                                ),
                              ]
                          ),

                        ],
                      ))  ],
              ),
            ),
          ],
        ),



        SizedBox(height: 5.h),
        SizedBox(
            width: 395.w,
            child: Divider(color: Colors.black,thickness:5.h )),
        SizedBox(height: 30.h),

        Row(
          children: [
            Container(
              height: 50.h,
              width: 195.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 1.w)
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(" Order No",
                        style: TextStyle(
                            fontSize: 10
                        ),),
                      SizedBox(width: 7.w,),
                      SizedBox(
                        width: 55.w,
                        child: Text("5979744",
                          style: TextStyle(
                              fontSize: 11
                          ),),
                      ),
                      Text("Pants",
                        style: TextStyle(
                            fontSize: 10
                        ),),
                      SizedBox(width: 7,),
                      SizedBox(
                        width: 50.w,
                        child: Text("5979",
                          style: TextStyle(
                              fontSize: 11
                          ),),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 105.w,
                        child: Text(" Hunais Pc",
                          style: TextStyle(
                              fontSize: 11
                          ),),
                      ),
                      Text("Due",
                        style: TextStyle(
                            fontSize: 10
                        ),),
                      SizedBox(width: 8.w,),
                      SizedBox(
                        width: 60.w,
                        child: Text("08-09-2023",
                          style: TextStyle(
                              fontSize: 11
                          ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 50.h,
              width: 195.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 1.w)
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(" Order No",
                        style: TextStyle(
                            fontSize: 10
                        ),),
                      SizedBox(width: 7.w,),
                      SizedBox(
                        width: 55.w,
                        child: Text("5979744",
                          style: TextStyle(
                              fontSize: 11
                          ),),
                      ),
                      Text("Shirt",
                        style: TextStyle(
                            fontSize: 10
                        ),),
                      SizedBox(width: 7.w,),
                      SizedBox(
                        width: 50.w,
                        child: Text("5979",
                          style: TextStyle(
                              fontSize: 11
                          ),),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 104.w,
                        child: Text(" Hunais Pc",
                          style: TextStyle(
                              fontSize: 11
                          ),),
                      ),
                      Text("Due",
                        style: TextStyle(
                            fontSize: 10
                        ),),
                      SizedBox(width: 10.w,),
                      SizedBox(
                        width: 60.w,
                        child: Text("08-09-2023",
                          style: TextStyle(
                              fontSize: 11
                          ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 195.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Le",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Wa",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Se",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Td",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Th",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Kn",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Bo",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Zp",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 175.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 175.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.w,top: 5.h),
                              child: const Text("W: Medium",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 10
                                ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5.w,top: 5.h),
                              child: const Text("B.L:2",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 10
                                ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5.w,top: 5.h),
                              child: const Text("S:",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 11
                                ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5.w,top: 5.h),
                              child: const Text("Btm St: Single",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 10
                                ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5.w,top: 5.h),
                              child: const Text("1/4",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 10
                                ),),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Container(
                    height: 455.h,
                    width: 86.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 1.w)
                    ),
                    child: Column(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(right: 4.w,top: 5.h),
                          child:  Text("Bk Pkt: Padi Hole Button",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 8.sp
                            ),),
                        ),
                      ],),
                  ),
                ],
              ),
            ),
            Container(
              width: 195.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Le",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Ch",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Sh",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Bo",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Bl",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Sl",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Rl",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Rs",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Sv",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Co",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Cm",
                            style: TextStyle(
                                fontSize: 10
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Pk",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 19.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Center(
                          child: Text("Cf",
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5/27.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.w)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w,top: 5.h),
                          child: const Text("40.5",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11
                            ),),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 455.h,
                    width: 86.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 1.w)
                    ),
                    child: Column(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: 3.w,top: 10.h),
                          child:  Text("Regular",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 8.sp
                            ),),
                        ),
                      ],),
                  ),
                ],
              ),
            )
          ],
        ),

      ],
    ),
  );


}