import 'package:flutter/material.dart';
import 'package:profile_card_app_v2/models/profile.dart';
import 'package:profile_card_app_v2/widgets/profile_card.dart';
import 'package:profile_card_app_v2/widgets/contact_info.dart';
import 'package:profile_card_app_v2/widgets/social_links_row.dart';
import 'package:profile_card_app_v2/widgets/app_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
      profile = Profile.defaultProfile;
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
                    AppButton(
                      label: 'Edit Profile',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
