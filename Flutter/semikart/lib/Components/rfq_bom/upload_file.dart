import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../common/red_button.dart';
import 'dart:io';

class CustomSquare extends StatefulWidget {
  const CustomSquare({Key? key}) : super(key: key);

  @override
  State<CustomSquare> createState() => _CustomSquareState();
}

class _CustomSquareState extends State<CustomSquare> {
  String? _fileName;
  String? _fileExtension;
  File? _selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        _fileName = file.name;
        _fileExtension = file.extension;
        if (file.path != null) {
          _selectedFile = File(file.path!);
        }
      });
      print('File selected: ${file.name}');
    } else {
      print('File selection canceled.');
    }
  }

  Widget _getFileIcon(double screenWidth) {
    double iconSize = screenWidth * 0.125; // 12.5% of screen width

    if (_fileExtension == null) {
      return Image.asset(
        'public/assets/images/cloud_icon.png',
        fit: BoxFit.contain,
      );
    }

    if (_fileExtension!.toLowerCase() == 'pdf') {
      return Icon(Icons.picture_as_pdf, size: iconSize, color: Colors.red);
    } else if (['xlsx', 'xls'].contains(_fileExtension!.toLowerCase())) {
      return Icon(Icons.table_chart, size: iconSize, color: Colors.green);
    }

    return Icon(Icons.insert_drive_file, size: iconSize, color: Colors.grey);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamic dimensions based on screen width
    final double containerHorizontalPadding =
        screenWidth * 0.04; // 4% of screen width
    final double innerContainerPadding =
        screenWidth * 0.04; // 4% of screen width
    final double borderRadius = screenWidth * 0.05; // 5% of screen width
    final double shadowSpreadRadius =
        screenWidth * 0.0125; // 1.25% of screen width
    final double shadowBlurRadius = screenWidth * 0.025; // 2.5% of screen width
    final double iconWidth = screenWidth * 0.25; // 25% of screen width
    final double iconHeight = screenWidth *
        0.25; // 25% of screen width (to maintain square aspect ratio)
    final double fileNameFontSize = screenWidth * 0.035; // 3.5% of screen width
    final double uploadTextFontSize = screenWidth * 0.04; // 4% of screen width
    final double supportedFormatsFontSize =
        screenWidth * 0.03; // 3% of screen width
    final double sizedBoxHeightSmall =
        screenWidth * 0.025; // 2.5% of screen width
    final double sizedBoxHeightMedium =
        screenWidth * 0.0375; // 3.75% of screen width
    final double buttonWidth = screenWidth * 0.3; // 30% of screen width
    final double buttonHeight = screenWidth * 0.1; // 10% of screen width

    return Container(
      color: Colors.white,
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: containerHorizontalPadding),
      child: Container(
        padding: EdgeInsets.all(innerContainerPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: shadowSpreadRadius,
              blurRadius: shadowBlurRadius,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickFile,
              child: Column(
                children: [
                  SizedBox(
                    width: iconWidth,
                    height: iconHeight,
                    child: _getFileIcon(screenWidth),
                  ),
                  if (_fileName != null)
                    Padding(
                      padding: EdgeInsets.only(top: sizedBoxHeightSmall),
                      child: Text(
                        _fileName!,
                        style: TextStyle(
                          fontSize: fileNameFontSize,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ),
            if (_fileName == null) ...[
              SizedBox(height: sizedBoxHeightSmall),
              Text(
                'Upload Parts List',
                style: TextStyle(
                  fontSize: uploadTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sizedBoxHeightSmall),
              Text(
                'Supported formats: Excel (XLS, XLSX), PDF.',
                style: TextStyle(
                  fontSize: supportedFormatsFontSize,
                  color: const Color(0xFF757575),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: sizedBoxHeightMedium),
            Center(
              child: RedButton(
                label: _fileName == null ? "Browse" : "Replace File",
                onPressed: _pickFile,
                width: buttonWidth,
                height: buttonHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
