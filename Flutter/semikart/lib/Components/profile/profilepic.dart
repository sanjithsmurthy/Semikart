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
  bool _isLoading = false;

  Future<void> _pickImage() async {
    try {
      setState(() {
        _isLoading = true;
      });
      
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
      });
      
      if (image != null) {
        final file = File(image.path);
        
        if (!await file.exists()) {
          print("Selected file doesn't exist: ${file.path}");
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Selected file could not be found.")),
            );
          }
          return;
        }
        
        setState(() {
          _selectedImage = file;
        });
        
        try {
          widget.onImageSelected(file);
        } catch (e) {
          print("Error in onImageSelected callback: $e");
        }
        
        ref.read(profileImageProvider.notifier).state = file;
      }
    } catch (e) {
      print("Error picking image: $e");
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not select image: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = ref.watch(profileImageProvider);
    
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector( // Make the CircleAvatar tappable to pick an image
          onTap: _isLoading ? null : _pickImage, // Disable tap while loading
          child: Builder(
            builder: (context) {
              ImageProvider? bgImage;
              if (_selectedImage != null) {
                if (_selectedImage!.path.isNotEmpty) {
                  bgImage = FileImage(_selectedImage!);
                }
              } else if (profileImage != null) {
                if (profileImage.path.isNotEmpty) {
                  bgImage = FileImage(profileImage);
                }
              } else if (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty) {
                bgImage = NetworkImage(widget.initialImageUrl!);
              }
              return CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[200],
                child: _isLoading
                    ? const CircularProgressIndicator(color: Color(0xFFA51414))
                    : (bgImage == null
                        ? Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey.shade600,
                          )
                        : null),
                backgroundImage: !_isLoading ? bgImage : null,
              );
            },
          ),
        ),
        
        // Loading indicator - centered (if picking image)
        if (_isLoading && _selectedImage == null && profileImage == null && widget.initialImageUrl == null)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
