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
    return SizedBox(
      width: 139,
      height: 139,
      child: Stack(
        children: [
          Container(
            width: 139,
            height: 139,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFFA51414),
                width: 2,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              clipBehavior: Clip.antiAlias,
              child: _getImageWidget(),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 31,
                height: 31,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFA51414),
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getImageWidget() {
    if (kIsWeb) {
      if (_webImage != null) {
        return Image.network(
          _webImage!.path,
          width: 139,
          height: 139,
          fit: BoxFit.cover,
        );
      }
    } else if (_selectedImage != null) {
      return Image.file(
        _selectedImage!,
        width: 139,
        height: 139,
        fit: BoxFit.cover,
      );
    }
    
    if (widget.imageUrl != null) {
      return Image.network(
        widget.imageUrl!,
        width: 139,
        height: 139,
        fit: BoxFit.cover,
      );
    }
    
    return Icon(
      Icons.person,
      size: 70,
      color: Colors.grey[400],
    );
  }
}