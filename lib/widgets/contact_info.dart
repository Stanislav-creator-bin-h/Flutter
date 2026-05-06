import 'package:flutter/material.dart';
import 'package:profile_card_app_v2/models/profile.dart';

class ContactInfo extends StatelessWidget {
  final Profile profile;

  const ContactInfo({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...profile.phoneNumbers.map((phone) => _buildContactRow(
                  icon: Icons.phone,
                  label: phone,
                )),
            ...profile.emails.map((email) => _buildContactRow(
                  icon: Icons.email,
                  label: email,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow({required IconData icon, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
