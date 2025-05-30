import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/profile_image_provider.dart'; // Adjust path if needed

class ProfilePicture extends ConsumerStatefulWidget {
  final String? initialImageUrl;

  const ProfilePicture({
    Key? key,
    this.initialImageUrl,
  }) : super(key: key);

  @override
  ConsumerState<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends ConsumerState<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    final profileImage = ref.watch(profileImageProvider);

    ImageProvider? bgImage;
    if (profileImage != null && profileImage.path.isNotEmpty) {
      bgImage = FileImage(profileImage);
    } else if (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty) {
      bgImage = NetworkImage(widget.initialImageUrl!);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[200],
          child: bgImage == null
              ? Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey.shade600,
                )
              : null,
          backgroundImage: bgImage,
        ),
      ],
    );
  }
}
