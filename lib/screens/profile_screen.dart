import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/profile.dart';
import '../widgets/profile_card.dart';
import '../widgets/contact_info.dart';
import '../widgets/social_links_row.dart';
import '../widgets/app_button.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Profile profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      profile = Profile(
        name: widget.user.name,
        title: widget.user.job,
        bio:
            'Contact ${widget.user.name} for more details about ${widget.user.job}.',
        avatarUrl: 'https://cdn-icons-png.flaticon.com/512/3541/3541871.png',
        phoneNumbers: [widget.user.phone],
        emails: [widget.user.email],
        socialLinks: {'GitHub': '', 'LinkedIn': '', 'Twitter': ''},
      );
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profile Card'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileCard(profile: profile),
                    const SizedBox(height: 24),
                    ContactInfo(profile: profile),
                    const SizedBox(height: 24),
                    SocialLinksRow(profile: profile),
                    const SizedBox(height: 32),
                    AppButton(label: 'Edit Profile', onPressed: () {}),
                  ],
                ),
              ),
            ),
    );
  }
}
