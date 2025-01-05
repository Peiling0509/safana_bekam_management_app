import 'dart:io';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show Offset, rootBundle;

import 'package:path_provider/path_provider.dart';
import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/components/toast.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';

import 'package:safana_bekam_management_app/data/model/patients/patients_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/model/treatment/acupoint_model.dart';

class TreatmentController extends GetxController {
  final Rx<LoaderState> state = LoaderState.initial.obs;

  Rx<PatientsModel> patient = PatientsModel(
    id: 1,
    name: "John Doe",
    myKad: "900101-14-5678",
    gender: "Male",
    ethnicity: "Malay",
    mobileNo: "0123456789",
    email: "john.doe@example.com",
    postcode: "12345",
    state: "Selangor",
    address: "123 Jalan Mawar, Shah Alam",
    occupation: "Engineer",
    medicalHistory: ["Hypertension"],
  ).obs;

  List<AcupointModel> acupointModels = [
    AcupointModel(
      bodyPart: "Depan",
      acupoint: [
        Acupoint(
          point: Offset(-43.0, -184.9),
          skinRection: 1,
          bloodQuantity: 5,
        ),
        Acupoint(
          point: Offset(40.8, -188.2),
          skinRection: 2,
          bloodQuantity: 4,
        ),
        Acupoint(
          point: Offset(-0.2, -90.2),
          skinRection: 2,
          bloodQuantity: 4,
        ),
      ],
    ),
    AcupointModel(
      bodyPart: "Belakang",
      acupoint: [
        Acupoint(
          point: Offset(-34.4, 1.8),
          skinRection: 1,
          bloodQuantity: 5,
        ),
        Acupoint(
          point: Offset(-2.4, -364.9),
          skinRection: 2,
          bloodQuantity: 4,
        ),
        Acupoint(
          point: Offset(31.1, 229.7),
          skinRection: 2,
          bloodQuantity: 4,
        ),
      ],
    ),
    AcupointModel(
      bodyPart: "Muka",
      acupoint: [
        Acupoint(
          point: Offset(-4.4, -234.7),
          skinRection: 1,
          bloodQuantity: 5,
        ),
        Acupoint(
          point: Offset(-85.9, 26.5),
          skinRection: 2,
          bloodQuantity: 4,
        ),
        Acupoint(
          point: Offset(99.2, 30.0),
          skinRection: 2,
          bloodQuantity: 4,
        ),
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    state.listen((v) {
      switch (v) {
        case LoaderState.initial:
        case LoaderState.loading:
          LoadingDialog.show();
          break;
        case LoaderState.empty:
        case LoaderState.loaded:
        case LoaderState.failure:
          LoadingDialog.hide();
          break;
      }
    });
  }

  Future<void> generateReport() async {
    try {
      state.value = LoaderState.loading;
      // Save the PDF
      String currentMilliseconds =
          DateTime.now().millisecondsSinceEpoch.toString();
      final directory = await getApplicationDocumentsDirectory();
      final String path =
          '${directory.path}/treatment_report_$currentMilliseconds.pdf';
      final file = File(path);
      final report = await generatePdf();

      toast("File saved at '$path'");
      await file.writeAsBytes(await report.save());
      await OpenFile.open(path);

      state.value = LoaderState.loaded;
    } catch (e) {
      print(e.toString());
      state.value = LoaderState.failure;
    }
  }

  Future<pw.Document> generatePdf() async {
    final pdf = pw.Document();
    // Load image file
    final bytes = await rootBundle.load(AssetPath.logo);
    //final imageFile = File(AssetPath.logo);
    final logo = pw.MemoryImage(bytes.buffer.asUint8List());

    //page 1
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header with logo and company details
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(logo, width: 150, height: 150),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Safana Bekam'),
                      pw.Text('195, Lorong Palm Villa 11, Taman Palm Villa,'),
                      pw.Text('Kota Samarahan'),
                      pw.Text('+60 19-4992979'),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 20),

              // Report Title
              pw.Center(
                child: pw.Text(
                  'LAPORAN RAWATAN',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.SizedBox(height: 20),

              // Patient Information Section
              pw.Container(
                width: double.infinity,
                decoration: const pw.BoxDecoration(
                  color: PdfColors.grey300,
                ),
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  'Maklumat Pelanggan',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),

              pw.SizedBox(height: 5),

              // Patient Details Grid
              pw.Table(
                children: [
                  _buildTableRow('Nama', getName, 'No. Tel', getMobileNo),
                  _buildTableRow('No. MyKad', getMyKad, 'Emel', getEmail),
                  _buildTableRow(
                      'Jantina', getGender, 'Pekerjaan', getOccupation),
                  _buildTableRow(
                    'Bangsa',
                    getEthnicity,
                    'Alamat',
                    "HSIODHASNNFDSDJKFNSDJKHFJASKFKJSDJFKSDJFKDSFKLSDJFLKSDJFLKJSDN VVSDMN KJJFIOWEJRIOWEJ",
                  ),
                ],
              ),

              pw.SizedBox(height: 20),

              // Treatment Record Section
              pw.Container(
                width: double.infinity,
                decoration: const pw.BoxDecoration(
                  color: PdfColors.grey300,
                ),
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  'Rekod Rawatan',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),

              pw.SizedBox(height: 5),

              // Treatment Details Grid
              pw.Table(
                children: [
                  _buildTableRow(
                      'Rawatan', "Rawatan 1", 'Tarikh', 'DD-MM-YYYY'),
                  _buildTableRow('Pakej', "1", 'Juruterapi', "Mr.Saffa"),
                  _buildTableRow('BP Before', '/', 'BP After', '/'),
                  _buildTableRow('Masalah', '', '', ''),
                ],
              ),

              // Page number at bottom
              pw.Spacer(),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child:
                    pw.Text('Page 1', style: const pw.TextStyle(fontSize: 12)),
              ),
            ],
          );
        },
      ),
    );

    const bodyViewWidth = 300.0;
    const bodyViewHeight = 600.0;

    for (var acupointModel in acupointModels) {
      final bodyImageBytes = await getBodyImageForPart(acupointModel.bodyPart!);
      final bodyImage = pw.MemoryImage(bodyImageBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header with logo and company details
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(logo, width: 150, height: 150),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('Safana Bekam'),
                        pw.Text('195, Lorong Palm Villa 11, Taman Palm Villa,'),
                        pw.Text('Kota Samarahan'),
                        pw.Text('+60 19-4992979'),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),

                //show section header once
                //Catatan
                if (acupointModels.indexOf(acupointModel) == 0)
                  pw.Container(
                    width: double.infinity,
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Catatan',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                pw.SizedBox(height: 8),
                //Bahagian
                pw.Container(
                  width: double.infinity,
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.grey100,
                  ),
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'Bahagian: ${acupointModel.bodyPart}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 20),
                //body view
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      height: acupointModel.bodyPart == "Belakang"
                          ? 650
                          : bodyViewHeight,
                      width: bodyViewWidth,
                      child: pw.Stack(
                        alignment: pw.Alignment.center,
                        fit: pw.StackFit.expand,
                        children: [
                          // Base body image
                          pw.Center(
                            child: pw.Image(
                              bodyImage,
                              fit: pw.BoxFit.contain,
                            ),
                          ),

                          // Acupoints overlay
                          if (acupointModel.acupoint != null)
                            ...acupointModel.acupoint!
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key + 1;
                              final acupoint = entry.value;
                              var scale = 0.0;
                              var dy = 0.0;
                              switch (acupointModel.bodyPart!.toLowerCase()) {
                                case "depan":
                                  scale = 0.749609592361934;
                                  dy = (acupoint.point!.dy * scale) +
                                      (bodyViewHeight / 2);
                                  break;
                                case "belakang":
                                  scale = 0.8235294271642914;
                                  dy = (acupoint.point!.dy * scale) + (650 / 2);
                                  break;
                                case "muka":
                                  scale = 0.3731536737308306;
                                  dy = (acupoint.point!.dy * scale) +
                                      (bodyViewHeight / 2);
                                  break;
                                default:
                              }

                              final dx = (acupoint.point!.dx * scale) +
                                  (bodyViewWidth / 2);

                              return pw.Positioned(
                                left: dx - 12.5,
                                top: dy - 12.5,
                                child: pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 20,
                                    height: 20,
                                    decoration: pw.BoxDecoration(
                                        shape: pw.BoxShape.circle,
                                        color: PdfColors.grey100,
                                        border: pw.Border.all(
                                            color: PdfColors.black, width: 2)),
                                    child: pw.Text(
                                      "$index",
                                    )),
                              );
                            }),
                        ],
                      ),
                    ),
                    //Acupoint table
                    pw.Expanded(
                      child: pw.Table(
                       border: pw.TableBorder.all(color: PdfColors.white),
                        columnWidths: {
                          0: const pw.FlexColumnWidth(1),
                          1: const pw.FlexColumnWidth(1),
                          2: const pw.FlexColumnWidth(1),
                        },
                        children: [
                          // Header row
                          pw.TableRow(
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.grey300,
                            ),
                            children: [
                              pw.Container(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Acupoint",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ),
                              pw.Container(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Tindak Balas Kulit",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ),
                              pw.Container(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  "Kuantiti Darah",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          // Data rows
                          if (acupointModel.acupoint != null)
                            ...acupointModel.acupoint!
                                .asMap()
                                .entries
                                .map((entry) => pw.TableRow(
                                      children: [
                                        pw.Container(
                                          decoration: const pw.BoxDecoration(
                                            color: PdfColors.grey100,
                                          ),
                                          padding: const pw.EdgeInsets.all(8),
                                          child: pw.Text(
                                            '${entry.key + 1}',
                                            style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold),
                                          ),
                                        ),
                                        pw.Container(
                                          decoration: const pw.BoxDecoration(
                                            color: PdfColors.grey100,
                                          ),
                                          padding: const pw.EdgeInsets.all(8),
                                          child: pw.Text(
                                            '${entry.value.skinRection}',
                                            style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold),
                                          ),
                                        ),
                                        pw.Container(
                                          decoration: const pw.BoxDecoration(
                                            color: PdfColors.grey100,
                                          ),
                                          padding: const pw.EdgeInsets.all(8),
                                          child: pw.Text(
                                            '${entry.value.bloodQuantity}',
                                            style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )),
                        ],
                      ),
                    )
                  ],
                ),

                // Acupoints details table
                pw.SizedBox(height: 20),
              ],
            );
          },
        ),
      );
    }
    return pdf;
  }

  pw.TableRow _buildTableRow(
      String label1, String value1, String label2, String value2) {
    const cellWidth = 250.0;
    return pw.TableRow(
      children: [
        if (label1 != "")
          pw.Container(
            width: cellWidth,
            padding: const pw.EdgeInsets.symmetric(vertical: 5.0),
            child: pw.Container(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              padding: const pw.EdgeInsets.all(8),
              child: pw.ConstrainedBox(
                constraints: const pw.BoxConstraints(maxWidth: cellWidth - 16),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Label section
                    pw.SizedBox(
                      width: 60, // Fixed width for labels
                      child: pw.Text(
                        label1,
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    // Colon separator
                    pw.SizedBox(
                      width: 10,
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    // Value section
                    pw.Expanded(
                      child: pw.Text(
                        value1,
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        pw.SizedBox(width: 8.0),
        if (label2 != "")
          pw.Container(
            width: cellWidth,
            padding: const pw.EdgeInsets.symmetric(vertical: 5.0),
            child: pw.Container(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              padding: const pw.EdgeInsets.all(8),
              child: pw.ConstrainedBox(
                constraints: const pw.BoxConstraints(maxWidth: cellWidth - 16),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Label section
                    pw.SizedBox(
                      width: 60, // Fixed width for labels
                      child: pw.Text(
                        label2,
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    // Colon separator
                    pw.SizedBox(
                      width: 10,
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    // Value section
                    pw.Expanded(
                      child: pw.Text(
                        value2,
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<dynamic> getBodyImageForPart(String bodyPart) async {
    switch (bodyPart.toLowerCase()) {
      case "depan":
        final bytes = await rootBundle.load(AssetPath.bodyFront);
        return bytes.buffer.asUint8List();
      case "belakang":
        final bytes = await rootBundle.load(AssetPath.bodyBack);
        return bytes.buffer.asUint8List();
      case "muka":
        final bytes = await rootBundle.load(AssetPath.face);
        return bytes.buffer.asUint8List();
      default:
        throw Exception('Unknown body part: $bodyPart');
    }
  }

  String get getName => patient.value.name ?? "No Name Provided";
  String get getMyKad => patient.value.myKad ?? "No MyKad Provided";
  String get getGender => patient.value.gender ?? "No Gender Specified";
  String get getEthnicity =>
      patient.value.ethnicity ?? "No Ethnicity Specified";
  String get getMobileNo =>
      patient.value.mobileNo ?? "No Mobile Number Provided";
  String get getEmail => patient.value.email ?? "No Email Provided";
  String get getPostcode => patient.value.postcode ?? "No Postcode Provided";
  String get getState => patient.value.state ?? "No State Provided";
  String get getAddress => patient.value.address ?? "No Address Provided";
  String get getOccupation =>
      patient.value.occupation ?? "No Occupation Specified";
  List<dynamic> get getMedicalHistory => patient.value.medicalHistory ?? [];
}

class PdfCoordinateTransformer {
  final double bodyViewWidth;
  final double bodyViewHeight;
  final double imageScaleFactor;

  PdfCoordinateTransformer({
    required this.bodyViewWidth,
    required this.bodyViewHeight,
    this.imageScaleFactor = 0.6,
  });

  pw.Positioned transformAcupoint(Acupoint acupoint) {
    // Calculate the actual image dimensions in the PDF
    final imageWidth = bodyViewWidth * imageScaleFactor;
    final imageHeight = bodyViewHeight * imageScaleFactor;

    // Calculate the scaling factors
    final scaleX = imageWidth / bodyViewWidth;
    final scaleY = imageHeight / bodyViewHeight;

    // Calculate margins to center the image
    final marginX = (bodyViewWidth - imageWidth) / 2;
    final marginY = (bodyViewHeight - imageHeight) / 2;

    // Transform the coordinates
    final dx = marginX + (bodyViewWidth / 2 + acupoint.point!.dx) * scaleX;
    final dy = marginY + (bodyViewHeight / 2 + acupoint.point!.dy) * scaleY;

    return pw.Positioned(
      left: dx - 12.5,
      top: dy - 12.5,
      child: pw.Container(
        width: 20,
        height: 20,
        decoration: const pw.BoxDecoration(
          shape: pw.BoxShape.circle,
          color: PdfColors.red,
        ),
      ),
    );
  }
}
