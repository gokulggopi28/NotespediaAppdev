import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as gett;
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/src/features/home/controller/fresh_release_controller.dart';
import 'package:notespedia/src/features/navigation/navigationController.dart';
import 'package:notespedia/src/features/search/controller/search_screen_controller.dart';
import '../../../models/course_selection_model.dart';
import '../../../models/user_profile_model.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../widgets/profile/user_profile_controller.dart';
import '../home/controller/books_category_controller.dart';
import '../home/controller/circular_story_controller.dart';
import '../home/controller/course_selection_controller.dart';
import '../home/controller/staff_publisher_controller.dart';
import '../home/controller/top_reads_controller.dart';
import '../navigation/home_screen.dart';

class PersonalInformationScreen extends StatefulWidget {
  final bool hidePhoneNumber;
  final bool hideEmail;
  final bool emailExists;
  final bool phoneExists;
  PersonalInformationScreen({
    this.hidePhoneNumber = false,
    this.hideEmail = false,
    this.emailExists = false,
    this.phoneExists = false,
  });
  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  File? _selectedImage;

  //bool _isLoading = false;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: '+91 ');
  final TextEditingController collegeController = TextEditingController();
  String? _profileImageUrl;

  int? userId;
  List<Course> courses = [];
  int? selectedCourseId;

  @override
  void initState() {
    super.initState();

    fetchCourses();
    fetchUserProfile();
  }

  Future<void> fetchCourses() async {
    try {
      var response =
          await Dio().get('http://139.59.38.234/api/common/courses/');
      if (response.statusCode == 200) {
        final courseList = CourseList.fromJson(response.data);
        setState(() {
          courses = courseList.data;
        });
      } else {
        print('Failed to fetch courses: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      int? fetchedUserId = UserPreferences.userId;
      if (fetchedUserId == null) {
        print('Error: User ID is null in UserPreferences');
        return;
      }

      var response = await Dio().get(
          'http://notespaedia.deienami.com/api/users/profile/?user_id=$fetchedUserId');
      if (response.statusCode == 200) {
        var userData = UserData.fromJson(response.data);
        setState(() {
          _profileImageUrl = userData.data.profileImage;
          fullNameController.text = userData.data.name ?? '';
          emailController.text = userData.data.email ?? '';
          phoneController.text = userData.data.mobileNumber.startsWith('+91 ')
              ? userData.data.mobileNumber
              : '+91 ${userData.data.mobileNumber}';
          collegeController.text = userData.data.college ?? '';
          selectedCourseId = userData.data.courseId;
        });
      } else {
        print('Failed to fetch user profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    print("Selected image path: ${image.path}");
    setState(() {
      _selectedImage = File(image.path); // Update the selected image file
    });
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) {
      print('No image selected or User ID is null');
      return;
    }
    print("Uploading image: ${_selectedImage!.path}");

    try {
      FormData formData = FormData.fromMap({
        "user_id": UserPreferences.userId.toString(),
        "profile_image": await MultipartFile.fromFile(_selectedImage!.path,
            filename: _selectedImage!.path.split('/').last),
      });
      print('FormData: $formData');

      var response = await Dio().put(
        'https://notespaedia.deienami.com/api/users/profile_image_update/',
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        print('Server response: ${response.data}');
      } else {
        print('Failed to upload image: ${response.statusCode}');
        print('Server response: ${response.data}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<bool> _validateProfileCompletion() async {
    bool isFullNameFilled = fullNameController.text.trim().isNotEmpty;
    bool isEmailFilled =
        emailController.text.trim().isNotEmpty || widget.hideEmail;
    bool isPhoneNumberFilled =
        phoneController.text.trim().isNotEmpty || widget.hidePhoneNumber;
    bool isCollegeFilled = collegeController.text.trim().isNotEmpty;
    bool isCourseSelected = selectedCourseId != null;

    return isFullNameFilled &&
        isEmailFilled &&
        isPhoneNumberFilled &&
        isCollegeFilled &&
        isCourseSelected;
  }

  void _showIncompleteProfileSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Please Complete the Profile to Continue"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void updateTextControllers(Data userData) {
    setState(() {
      fullNameController.text = userData.name ?? '';
      emailController.text = userData.email ?? '';

      phoneController.text = userData.mobileNumber.startsWith('+91 ')
          ? userData.mobileNumber
          : '+91 ${userData.mobileNumber}';
      collegeController.text = userData.college ?? '';
      selectedCourseId = userData.courseId;
    });
  }

  Future<void> updateUserProfile() async {
    if (!await _validateProfileCompletion()) {
      HelperFunctions.showTopSnackBar(
        context: context,
        title: "Incomplete Profile",
        message: "Please complete the profile to continue",
      );
      return;
    }
    if (fullNameController.text.isEmpty) {
      HelperFunctions.showTopSnackBar(
        context: context,
        title: "Error",
        message: "Please enter your full name",
      );
      return;
    }
    int userId = UserPreferences.userId ?? 0;
    print("UserId:$userId");
    if (userId <= 0) {
      print('Error: User ID is null or invalid');
      return;
    }
    await uploadImage();
    try {
      var data = {
        "mobile_number": phoneController.text.replaceAll('+91 ', ''),
        "email": emailController.text,
        // "profile_image": null,
        "course_id": selectedCourseId,
        "college": collegeController.text,
        "name": fullNameController.text,
        "user_id": UserPreferences.userId,
        // "is_onboarding": widget.isOnboarding ? 1 : 0,
      };
      // if (!_hidePhoneNumber) {
      //   data["mobile_number"] = phoneController.text.replaceAll('+91 ', '');
      // }

      print('Sending data: $data');
      var response = await Dio().put(
        'https://notespaedia.deienami.com/api/users/profile_update/',
        data: data,
      );

      if (response.statusCode == 200) {
        print('Success: ${response.data}');
        HelperFunctions.showTopSnackBar(
          context: context,
          title: "Status Message",
          message: "Profile Updated Successfully",
        );
        Future.delayed(Duration(seconds: 2), () {
          final UserProfileController userProfileController =
              gett.Get.find<UserProfileController>();
          userProfileController.fetchUserProfile(userId);
          userProfileController.update();
          gett.Get.find<NavigationController>()
              .changeIndex(0); // Set selectedIndex to 3
          gett.Get.to(() => HomeScreen());
        });
      } else {
        print('Error: ${response.statusCode} - ${response.data}');
        HelperFunctions.showTopSnackBar(
          context: context,
          title: "Error",
          message: "Failed: ${response.data}",
        );
      }
    } on DioError catch (dioError) {
      print(
          'DioError: ${dioError.response?.data} - ${dioError.response?.statusCode}');
      HelperFunctions.showTopSnackBar(
        context: context,
        title: "Error",
        message: "Failed: ${dioError.response?.data}",
      );
    } catch (e) {
      print('Exception: $e');
      HelperFunctions.showTopSnackBar(
        context: context,
        title: "Error",
        message: "An exception occurred: $e",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imageSize = screenSize.width * 0.25;
    double iconSize = imageSize * 0.35;
    gett.Get.put(CourseSelectionController());
    gett.Get.put(FreshReleaseController());
    gett.Get.put(StaffPublisherController());
    gett.Get.put(TopReadsController());
    gett.Get.put(CircularStoryController());
    gett.Get.put(BooksCategoryController());
    gett.Get.put(SearchScreenController());
    return WillPopScope(
        onWillPop: () async {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current route.
            return false;
          }
          if (!await _validateProfileCompletion()) {
            HelperFunctions.showTopSnackBar(
              context: context,
              title: "Incomplete Profile",
              message: "Please complete the profile to continue",
            );
            return Future.value(
                false); // Prevents the user from leaving the screen
          }
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                if (await _validateProfileCompletion()) {
                  Navigator.of(context).pop();
                } else {
                  HelperFunctions.showTopSnackBar(
                    context: context,
                    title: "Incomplete Profile",
                    message: "Please complete the profile to continue",
                  );
                }
              },
            ),
            title: Text("Personal Information"),
            actions: <Widget>[
              TextButton(
                onPressed: updateUserProfile,
                child: Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.1),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: imageSize,
                        height: imageSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : _profileImageUrl != null &&
                                        _profileImageUrl!.isNotEmpty
                                    ? NetworkImage(_profileImageUrl!)
                                    : NetworkImage(
                                            'https://notespedia-books.s3.ap-south-1.amazonaws.com/static/Default+Profile+Image.png')
                                        as ImageProvider,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: iconSize,
                          height: iconSize,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: iconSize * 0.6,
                            ),
                            onPressed: pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.05),
                buildTextField(
                    'Full Name', 'Enter your full name', fullNameController,
                    readOnly: false),

                buildTextField(
                  'Email ID',
                  'Enter your email',
                  emailController,
                  readOnly: emailController.text.isNotEmpty,
                  visible: !widget.hideEmail,
                ),
                buildTextField(
                  'Phone Number',
                  "Phone Number",
                  phoneController,
                  readOnly: phoneController.text.isNotEmpty &&
                      phoneController.text != '+91 ',
                  visible: !widget.hidePhoneNumber,
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                //   child: TextField(
                //     controller: phoneController,
                //     keyboardType: TextInputType.phone,
                //     decoration: InputDecoration(
                //       labelText: 'Phone',
                //       hintText: 'Enter your phone number',

                //     ),
                //   ),
                // ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonFormField<int>(
                    value: selectedCourseId,
                    decoration: InputDecoration(labelText: 'Course'),
                    items: courses.map((course) {
                      return DropdownMenuItem<int>(
                        value: course.id,
                        child: Text(course.name),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedCourseId = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                buildTextField(
                    'College', 'Enter your college', collegeController,
                    readOnly: false),
              ],
            ),
          ),
        ));
  }

  Widget buildTextField(
      String label, String hint, TextEditingController controller,
      {bool readOnly = false, bool visible = true}) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
