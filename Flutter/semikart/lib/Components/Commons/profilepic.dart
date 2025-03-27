import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onEditPressed;

  const ProfilePicture({
    Key? key,
    this.imageUrl,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 139,
      height: 139,
      child: Stack(
        children: [
          // Main profile circle
          Container(
            width: 139,
            height: 139,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imageUrl == null
                ? Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.grey[400],
                  )
                : null,
          ),
          // Edit button
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onEditPressed,
              child: Container(
                width: 31,
                height: 31,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEE8924),
                ),
                child: Center(
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
}