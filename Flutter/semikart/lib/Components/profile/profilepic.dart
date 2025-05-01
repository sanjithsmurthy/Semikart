import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/profile_image_provider.dart'; // Adjust path if needed

class ProfilePicture extends ConsumerStatefulWidget {
  final String? initialImageUrl;
  final Function(File) onImageSelected;

  const ProfilePicture({
    Key? key,
    this.initialImageUrl,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  ConsumerState<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends ConsumerState<ProfilePicture> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      setState(() {
        _selectedImage = file;
      });
      widget.onImageSelected(file); // Notify parent widget
      ref.read(profileImageProvider.notifier).state = file; // Update provider
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = ref.watch(profileImageProvider);

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 60, // Size of the profile image
          backgroundImage: _selectedImage != null
              ? FileImage(_selectedImage!)
              : profileImage != null
                  ? FileImage(profileImage)
                  : widget.initialImageUrl != null
                      ? NetworkImage(widget.initialImageUrl!)
                      : const AssetImage('public/assets/images/profile_picture.png') as ImageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage, // Enable upload only when edit icon is clicked
            child: CircleAvatar(
              radius: 18, // Size of the edit icon
              backgroundColor: Colors.white,
              child: Icon(
                Icons.edit,
                size: 18,
                color: Color(0xFFA51414), // Updated color to #a51414
              ),
            ),
          ),
        ),
      ],
    );
  }
}
