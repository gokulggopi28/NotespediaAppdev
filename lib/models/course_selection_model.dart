class Course {
  final int id;
  final String name;

  Course({required this.id, required this.name});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CourseList {
  final List<Course> data;

  CourseList({required this.data});

  factory CourseList.fromJson(Map<String, dynamic> json) {
    // Correctly access the 'courses' list within the 'data' object
    var list = json['data']['courses'] as List;
    List<Course> courses = list.map((i) => Course.fromJson(i)).toList();
    return CourseList(data: courses);
  }
}
