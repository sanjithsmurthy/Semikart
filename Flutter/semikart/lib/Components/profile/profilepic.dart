import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../common/popup.dart';

class ProfilePicture extends StatefulWidget {
  final String? imageUrl;
  final Function(File) onImageSelected;

  const ProfilePicture({
    Key? key,
    this.imageUrl,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _selectedImage;
  XFile? _webImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image != null) {
        // Get MIME type and file extension
        final mimeType = image.mimeType?.toLowerCase() ?? '';
        final fileExtension = image.path.split('.').last.toLowerCase();

        debugPrint('Image path: ${image.path}');
        debugPrint('MIME type: $mimeType');
        debugPrint('File extension: $fileExtension');

        // Validate MIME type or file extension
        final isImage = mimeType.startsWith('image/') ||
            ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(fileExtension);

        if (!isImage) {
          if (context.mounted) {
            await CustomPopup.show(
              context: context,
              title: 'Invalid File Type',
              message: 'Please select an image file (JPG, PNG, GIF, or WEBP)',
              imagePath: 'public/assets/images/Alert.png', // Add your image path here
            );
          }
          return;
        }

        setState(() {
          if (kIsWeb) {
            _webImage = image;
          } else {
            _selectedImage = File(image.path);
          }
        });

        // Notify parent widget about the selected image
        if (!kIsWeb && _selectedImage != null) {
          widget.onImageSelected(_selectedImage!);
        }
      }
    } catch (e) {
      // Show error popup for other errors
      if (context.mounted) {
        await CustomPopup.show(
          context: context,
          title: 'Error',
          message: 'Failed to select image. Please try again.',
        );
      }
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically calculate sizes based on screen width
    final profileSize = screenWidth * 0.3; // Reduced size to 25% of screen width
    final editIconSize = profileSize * 0.22; // Edit icon size is 22% of profile picture size

    return SizedBox(
      width: profileSize,
      height: profileSize,
      child: Stack(
        children: [
          // Profile Picture Container
          Container(
            width: profileSize,
            height: profileSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200], // Background color for the circle
            ),
            clipBehavior: Clip.antiAlias,
            child: _getImageWidget(profileSize), // Pass profile size for dynamic scaling
          ),
          // Edit Icon
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: editIconSize, // Dynamically calculated edit icon size
                height: editIconSize, // Dynamically calculated edit icon size
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFA51414),
                ),
                child: Center(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: editIconSize * 0.5, // Icon size is 50% of edit icon container
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getImageWidget(double profileSize) {
    if (kIsWeb) {
      if (_webImage != null) {
        return Image.network(
          _webImage!.path,
          width: profileSize,
          height: profileSize,
          fit: BoxFit.cover,
        );
      }
    } else if (_selectedImage != null) {
      return Image.file(
        _selectedImage!,
        width: profileSize,
        height: profileSize,
        fit: BoxFit.cover,
      );
    }

    if (widget.imageUrl != null) {
      return Image.network(
        widget.imageUrl!,
        width: profileSize,
        height: profileSize,
        fit: BoxFit.cover,
      );
    }

    return Icon(
      Icons.person,
      size: profileSize * 0.5, // Icon size is 50% of profile picture size
      color: Colors.grey[400],
    );
  }
}