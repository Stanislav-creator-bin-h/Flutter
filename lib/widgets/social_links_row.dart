import 'package:flutter/material.dart';
import '../models/profile.dart';

class SocialLinksRow extends StatelessWidget {
  final Profile profile;

  const SocialLinksRow({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: profile.socialLinks.entries.map((entry) {
        return _buildSocialButton(platform: entry.key, url: entry.value);
      }).toList(),
    );
  }

  Widget _buildSocialButton({required String platform, required String url}) {
    final colors = {
      'GitHub': Colors.grey[800],
      'LinkedIn': Colors.blue[700],
      'Twitter': Colors.cyan,
      'Instagram': Colors.purple,
    };

    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(_getIconForPlatform(platform), size: 20),
      label: Text(platform),
      style: ElevatedButton.styleFrom(
        backgroundColor: colors[platform] ?? Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  IconData _getIconForPlatform(String platform) {
    final icons = {
      'GitHub': Icons.code,
      'LinkedIn': Icons.business_center,
      'Twitter': Icons.chat,
      'Instagram': Icons.camera_alt,
    };
    return icons[platform] ?? Icons.link;
  }
}
