import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/profile_image_provider.dart'; // Adjust path if needed

class ProfilePicture extends ConsumerStatefulWidget {
  final String? initialImageUrl;
  final Function(File) onImageSelected;
  final Function()? onImageDeleted; // New callback for deletion

  const ProfilePicture({
    Key? key,
    this.initialImageUrl,
    required this.onImageSelected,
    this.onImageDeleted, // Add this parameter
  }) : super(key: key);

  @override
  ConsumerState<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends ConsumerState<ProfilePicture> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false; // Add this loading state

  Future<void> _pickImage() async {
    try {
      // Add loading indicator
      setState(() {
        _isLoading = true; // Add this variable at class level
      });
      
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      
      // Check if component is still mounted
      if (!mounted) return;
      
      // Reset loading state
      setState(() {
        _isLoading = false;
      });
      
      if (image != null) {
        final file = File(image.path);
        
        // Validate file exists and is readable
        if (!await file.exists()) {
          print("Selected file doesn't exist: ${file.path}");
          return;
        }
        
        setState(() {
          _selectedImage = file;
        });
        
        // Wrap callback in try-catch
        try {
          widget.onImageSelected(file);
        } catch (e) {
          print("Error in onImageSelected callback: $e");
        }
        
        // Update provider
        ref.read(profileImageProvider.notifier).state = file;
      }
    } catch (e) {
      print("Error picking image: $e");
      
      // Check if component is still mounted
      if (!mounted) return;
      
      // Reset loading state if there was an error
      setState(() {
        _isLoading = false;
      });
      
      // Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not select image: ${e.toString()}")),
      );
    }
  }

  // Add method to delete the image
  void _deleteImage() {
    setState(() {
      _selectedImage = null;
    });
    ref.read(profileImageProvider.notifier).state = null; // Clear provider
    if (widget.onImageDeleted != null) {
      widget.onImageDeleted!(); // Notify parent
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = ref.watch(profileImageProvider);
    
    // Check if we have any image to show (selected, provider, or network)
    final bool hasImage = _selectedImage != null || 
                          profileImage != null || 
                          widget.initialImageUrl != null;

    return Stack(
      alignment: Alignment.center,
      children: [
        Builder(
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
                  ? CircularProgressIndicator(color: Color(0xFFA51414))
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
        
        // Edit icon - positioned on the LEFT edge - always visible
        Positioned(
          left: -8,
          bottom: 1,
          child: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.edit,
                size: 20,
                color: Color(0xFFA51414),
              ),
            ),
          ),
        ),
        
        // Delete icon - positioned on the RIGHT edge
        // Only show if there's an image to delete
        if (hasImage) // This conditional ensures delete icon only appears when an image exists
          Positioned(
            right: -8,
            bottom: 1,
            child: GestureDetector(
              onTap: _deleteImage,
              child: CircleAvatar(
                radius: 18, // Made consistent with edit icon
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.delete_outline,
                  size: 20, // Made consistent with edit icon
                  color: Color(0xFFA51414),
                ),
              ),
            ),
          ),
          
        // Loading indicator - centered
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFA51414),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
