import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../Commons/popup.dart';

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
        // Get MIME type for both web and mobile
        final mimeType = image.mimeType?.toLowerCase() ?? '';
        final isImage = mimeType.startsWith('image/');
        
        if (!isImage) {
          if (context.mounted) {
            await CustomPopup.show(
              context: context,
              title: 'Invalid File Type',
              message: 'Please select an image file (JPG, PNG, GIF or WEBP)',
              imagePath: 'public/assets/images/Alert.png',  // Add your image path here
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
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically calculate sizes based on screen width
    final profileSize = screenWidth * 0.35; // Profile picture size is 35% of screen width
    final editIconSize = profileSize * 0.22; // Edit icon size is 22% of profile picture size
    final borderWidth = profileSize * 0.015; // Border width is 1.5% of profile picture size

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
              border: Border.all(
                color: Color(0xFFA51414),
                width: borderWidth, // Dynamically calculated border width
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              clipBehavior: Clip.antiAlias,
              child: _getImageWidget(profileSize), // Pass profile size for dynamic scaling
            ),
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
                decoration: BoxDecoration(
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