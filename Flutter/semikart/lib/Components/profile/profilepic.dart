import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/popup.dart';
import '../../providers/profile_image_provider.dart'; // Adjust path if needed

class ProfilePicture extends ConsumerStatefulWidget {
  final String? imageUrl;
  final Function(File) onImageSelected;
  final String? initialImageUrl; // Add parameter to accept initial URL

  const ProfilePicture({
    Key? key,
    this.imageUrl,
    required this.onImageSelected,
    this.initialImageUrl, // Add to constructor
  }) : super(key: key);

  @override
  ConsumerState<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends ConsumerState<ProfilePicture> {
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

      if (image == null) return;

      final mimeType = image.mimeType?.toLowerCase() ?? '';
      final fileExtension = image.path.split('.').last.toLowerCase();

      final isImage = mimeType.startsWith('image/') ||
          ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(fileExtension);

      if (!isImage) {
        if (context.mounted) {
          await CustomPopup.show(
            context: context,
            title: 'Invalid File Type',
            message: 'Please select an image file (JPG, PNG, GIF, or WEBP)',
            buttonText: 'OK', // Add the required buttonText argument
            imagePath: 'public/assets/images/Alert.png',
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
        ref.read(profileImageProvider.notifier).state = _selectedImage!;
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (context.mounted) {
        await CustomPopup.show(
          context: context,
          title: 'Error',
          message: 'Failed to select image. Please try again.',
          buttonText: 'OK', // Add the required buttonText argument
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final profileSize = screenWidth * 0.3;
    final editIconSize = profileSize * 0.22;

    return SizedBox(
      width: profileSize,
      height: profileSize,
      child: Stack(
        children: [
          Container(
            width: profileSize,
            height: profileSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            clipBehavior: Clip.antiAlias,
            child: _getImageWidget(profileSize),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: editIconSize,
                height: editIconSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFA51414),
                ),
                child: Center(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: editIconSize * 0.5,
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
      size: profileSize * 0.5,
      color: Colors.grey[400],
    );
  }
}
