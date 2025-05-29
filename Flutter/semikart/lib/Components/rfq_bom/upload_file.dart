import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import '../common/red_button.dart';
import 'dart:io';

class CustomSquare extends StatefulWidget {
  final Function(bool) onFileUploaded;
  const CustomSquare({Key? key, required this.onFileUploaded})
      : super(key: key);

  @override
  State<CustomSquare> createState() => _CustomSquareState();
}

class _CustomSquareState extends State<CustomSquare> {
  String? _fileName;
  String? _fileExtension;
  File? _selectedFile;
  bool _isFileUploaded = false;

  Future<void> _pickFile() async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'documents',
      extensions: ['xlsx', 'xls', 'pdf'],
    );
    final XFile? xFile = await openFile(acceptedTypeGroups: [typeGroup]);
    final File? file = xFile != null ? File(xFile.path) : null;

    if (file != null) {
      // Check if the widget is still mounted before calling setState
      if (!mounted) return;
      setState(() {
        _fileName = file.path.split(Platform.pathSeparator).last; // Use platform-specific separator
        _fileExtension = file.path.split('.').last;
        _selectedFile = file;
        _isFileUploaded = true;
      });
      print('File selected: ${file.path}');
      widget.onFileUploaded(
          _isFileUploaded); // Notify parent that file is uploaded
    } else {
      print('File selection canceled.');
      // Optionally notify parent if selection is cancelled and file was previously uploaded
      // if (_isFileUploaded) {
      //   setState(() {
      //     _isFileUploaded = false;
      //     _fileName = null;
      //     _fileExtension = null;
      //     _selectedFile = null;
      //   });
      //   widget.onFileUploaded(false);
      // }
    }
  }

  // Updated to accept scale factor for consistent scaling
  Widget _getFileIcon(double scale) {
    // Base icon size relative to reference width (e.g., 50px on 412px width)
    double baseIconSize = 45.0;
    double iconSize = baseIconSize * scale;

    // Use a default icon if extension is null or unknown
    IconData defaultIconData = Icons.insert_drive_file;
    Color defaultIconColor = Colors.grey;

    if (_fileExtension == null) {
      // Keep the cloud icon asset if preferred for the initial state
      return Image.asset(
        'public/assets/images/cloud_icon.png', // Ensure this path is correct
        fit: BoxFit.contain,
        // Optionally scale the Image widget itself if needed
        // width: iconSize,
        // height: iconSize,
      );
    }

    String lowerCaseExtension = _fileExtension!.toLowerCase();

    if (lowerCaseExtension == 'pdf') {
      return Icon(Icons.picture_as_pdf, size: iconSize, color: Colors.red);
    } else if (['xlsx', 'xls'].contains(lowerCaseExtension)) {
      return Icon(Icons.table_chart, size: iconSize, color: Colors.green);
    }

    // Fallback icon for other/unknown types
    return Icon(defaultIconData, size: iconSize, color: defaultIconColor);
  }

  @override
  Widget build(BuildContext context) {
    // --- Responsive Scaling Setup ---
    const double referenceWidth = 412.0;
    // const double referenceHeight = 917.0; // Not directly used but good practice

    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    // Calculate scale factor based on width
    final double scale = screenWidth / referenceWidth;
    // --- End Responsive Scaling Setup ---

    // --- Scaled Dimensions ---
    // Base values chosen relative to reference width (412px)
    final double containerHorizontalPadding = 16.0 * scale; // Base: 16px
    final double innerContainerPadding = 16.0 * scale; // Base: 16px
    final double borderRadius = 20.0 * scale; // Base: 20px
    final double shadowSpreadRadius = 5.0 * scale; // Base: 5px
    final double shadowBlurRadius = 10.0 * scale; // Base: 10px
    final double shadowOffsetY = 3.0 * scale; // Base: 3px
    // Icon container size (adjust base value as needed)
    final double iconContainerSize = 100.0 * scale; // Base: 100px square
    final double fileNameFontSize = 14.0 * scale; // Base: 14px
    final double uploadTextFontSize = 16.0 * scale; // Base: 16px
    final double supportedFormatsFontSize = 12.0 * scale; // Base: 12px
    final double sizedBoxHeightSmall = 10.0 * scale; // Base: 10px
    final double sizedBoxHeightMedium = 15.0 * scale; // Base: 15px
    // Button dimensions (adjust base values as needed)
    final double buttonWidth = 120.0 * scale; // Base: 120px
    final double buttonHeight = 40.0 * scale; // Base: 40px
    final double buttonFontSize = 14.0 * scale; // Base: 14px (assuming RedButton uses it)
    // --- End Scaled Dimensions ---

    return Container(
      color: Colors.white, // Keep original background
      // No fixed width needed, let parent handle width constraints
      padding: EdgeInsets.symmetric(horizontal: containerHorizontalPadding*0.6), // Scaled
      child: Container(
        padding: EdgeInsets.all(innerContainerPadding*0.6), // Scaled
        decoration: BoxDecoration(
          color: Colors.white, // Keep original color
          borderRadius: BorderRadius.circular(borderRadius), // Scaled
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Keep original shadow color/opacity
              spreadRadius: shadowSpreadRadius, // Scaled
              blurRadius: shadowBlurRadius, // Scaled
              offset: Offset(0, shadowOffsetY), // Use scaled Y offset
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
                  // Container to hold the icon/image with fixed scaled size
                  Container(
                    width: iconContainerSize, // Scaled
                    height: iconContainerSize, // Scaled
                    alignment: Alignment.center, // Center the icon/image
                    child: _getFileIcon(scale), // Pass scale factor
                  ),
                  // Display file name if selected
                  if (_fileName != null)
                    Padding(
                      padding: EdgeInsets.only(top: sizedBoxHeightSmall*0.1), // Scaled
                      child: Text(
                        _fileName!,
                        style: TextStyle(
                          fontSize: fileNameFontSize, // Scaled
                          color: Colors.black, // Keep original color
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis, // Prevent long names breaking layout
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ),
            // Display upload instructions if no file is selected
            if (_fileName == null) ...[
              // SizedBox(height: sizedBoxHeightSmall*0.2), // Scaled
              Text(
                'Upload Parts List',
                style: TextStyle(
                  fontSize: uploadTextFontSize*0.7, // Scaled
                  fontWeight: FontWeight.bold, // Keep original weight
                  color: const Color(0xFF000000), // Keep original color
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sizedBoxHeightSmall*0.5), // Scaled
              Text(
                'Supported formats: Excel (XLS, XLSX), PDF.',
                style: TextStyle(
                  fontSize: supportedFormatsFontSize*0.8, // Scaled
                  color: const Color(0xFF757575), // Keep original color
                ),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: sizedBoxHeightMedium*0.5), // Scaled spacing before button
            // Browse/Replace Button
            Center(
              child: RedButton(
                label: _fileName == null ? "Browse" : "Replace File",
                onPressed: _pickFile,
                width: buttonWidth*0.8, // Use scaled width
                height: buttonHeight*0.8, // Use scaled height
                fontSize: buttonFontSize, // Pass scaled font size (ensure RedButton uses it)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
