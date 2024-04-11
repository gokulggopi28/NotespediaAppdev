class UserProfile {
  final String name;
  final String courseName;
  final String college;
  final String profileimage;
  final int notes;
  final int followers;
  final int following;
  final int? getMeNotified;

  UserProfile({
    required this.name,
    required this.courseName,
    required this.college,
    required this.profileimage,
    required this.notes,
    required this.followers,
    required this.following,
    this.getMeNotified,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['data']['name'] ?? '',
      courseName: json['data']['course_name'] ?? '',
      college: json['data']['college'] ?? '',
      profileimage: json['data']["profile_image"] ?? '',
      notes: json['data']['notes'] ?? 0,
      followers: json['data']['followers'] ?? 0,
      following: json['data']['following'] ?? 0,
      getMeNotified: json['data']['get_me_notified'] ?? 0,
    );
  }
}
