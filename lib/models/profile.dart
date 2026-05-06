class Profile {
  final String name;
  final String title;
  final String bio;
  final String avatarUrl;
  final List<String> phoneNumbers;
  final List<String> emails;
  final Map<String, String> socialLinks;

  const Profile({
    required this.name,
    required this.title,
    required this.bio,
    required this.avatarUrl,
    required this.phoneNumbers,
    required this.emails,
    required this.socialLinks,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      bio: json['bio'] ?? '',
      avatarUrl: json['avatarUrl'] ?? 'https://i.pravatar.cc/300',
      phoneNumbers: List<String>.from(json['phoneNumbers'] ?? []),
      emails: List<String>.from(json['emails'] ?? []),
      socialLinks: Map<String, String>.from(json['socialLinks'] ?? {}),
    );
  }

  static const defaultProfile = Profile(
    name: 'Станіслав.Г',
    title: 'Developer',
    bio: 'Flutter developer.',
    avatarUrl: 'https://i.pravatar.cc/300',
    phoneNumbers: ['+3809865*****', '+3809865*****'],
    emails: ['stanislav@example.com', 'stanislav@example.com'],
    socialLinks: {
      'GitHub': '',
      'LinkedIn': '',
      'Twitter': '',
    },
  );
}
