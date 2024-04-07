class ExplorePost {
  final int id;
  final String postTitle;
  final String fileUrl;
  final String createdOn;
  final String name;
  final String profileImage;

  ExplorePost({
    required this.id,
    required this.postTitle,
    required this.fileUrl,
    required this.createdOn,
    required this.name,
    required this.profileImage,
  });

  factory ExplorePost.fromJson(Map<String, dynamic> json) => ExplorePost(
        id: json['id'] ?? 0, // Assuming 0 as a default value for id
        postTitle: json['post_title'] ?? '',
        fileUrl: json['file_url'] ?? '',
        createdOn: json['created_on'] ?? '',
        name: json['name'] ?? '',
        profileImage:
            json['profile_image'] ?? '', // Assuming you have a default image
      );
}
