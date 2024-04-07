import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:notespedia/models/country_model.dart';
import 'package:notespedia/models/state__model.dart';
import '../../../models/user_profile_model.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../repositories/user_preferences.dart';
import 'address_list_screen.dart';

class AddNewAddressScreen extends StatefulWidget {
  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController =
      TextEditingController(text: '+91 ');
  final TextEditingController addressController = TextEditingController();
  final TextEditingController addressOptionalController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  List<Country> countries = [];
  String? selectedCountryId = 'dummy';
  List<StateModel> states = [];
  String? selectedStateId = 'dummy';
  bool isCountrySelected = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCountries();
    fetchUserProfile();
    phoneNumberController.addListener(() {
      final text = phoneNumberController.text;
      if (!text.startsWith('+91 ')) {
        phoneNumberController.text = '+91 ';
        phoneNumberController.selection = TextSelection.fromPosition(
            TextPosition(offset: phoneNumberController.text.length));
      } else if (text.length > 14) {
        phoneNumberController.text = text.substring(0, 14);
        phoneNumberController.selection =
            TextSelection.fromPosition(TextPosition(offset: 14));
      }
    });
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
          nameController.text = userData.data.name; // Prefill name
          phoneNumberController.text =
              '+91 ${userData.data.mobileNumber}'; // Prefill phone number
        });
      } else {
        print('Failed to fetch user profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<void> fetchCountries() async {
    try {
      var response = await Dio()
          .get('https://notespaedia.deienami.com/api/common/countries/');
      List<dynamic> data = response.data['data'];
      setState(() {
        countries =
            data.map((countryJson) => Country.fromJson(countryJson)).toList();
        if (countries.isNotEmpty) {
          selectedCountryId = countries[0].id.toString();
        }
      });
    } catch (e) {
      print("Error fetching countries: $e");
    }
  }

  Future<void> fetchStates(String countryId) async {
    try {
      var response = await Dio().get(
          'https://notespaedia.deienami.com/api/common/states/?country_id=$countryId');
      List<dynamic> data = response.data['data'];
      setState(() {
        states =
            data.map((stateJson) => StateModel.fromJson(stateJson)).toList();
        if (states.isNotEmpty) {
          selectedStateId = states[0].id.toString();
        } else {
          selectedStateId = null;
        }
      });
    } catch (e) {
      print("Error fetching states: $e");
    }
  }

  void onDone() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      int userId = UserPreferences.userId;
      String countryName = countries
          .firstWhere((country) => country.id.toString() == selectedCountryId,
              orElse: () => Country(id: 0, name: ""))
          .name;
      String stateName = states
          .firstWhere((state) => state.id.toString() == selectedStateId,
              orElse: () => StateModel(id: 0, name: ""))
          .name;

      var data = {
        "contact_person_name": nameController.text,
        "contact_person_phone":
            phoneNumberController.text.replaceAll('+91 ', ''),
        "address_line_1": addressController.text,
        "address_line_2": addressOptionalController.text,
        "pin_code": pincodeController.text,
        "country": countryName,
        "state": stateName,
        "city": cityController.text,
        "user_id": userId.toString(),
      };
      print("Sending data: $data");
      try {
        var response = await Dio()
            .post('http://139.59.38.234/api/users/address/', data: data);
        if (!mounted) return;
        print("API Response: ${response.data}");
        if (response.statusCode == 201) {
          HelperFunctions.showTopSnackBar(
              context: context,
              title: "Success",
              message: "Address added Successfully");
          Future.delayed(Duration(seconds: 4), () {
            if (mounted) Get.back(result: true);
          });
        } else {
          HelperFunctions.showTopSnackBar(
              context: context,
              title: "Error",
              message: "Unable to add address");
        }
      } catch (e) {
        if (!mounted) return;
        if (e is DioException) {
          print('Response status code: ${e.response?.statusCode}');
          print('Response data: ${e.response?.data}');

          String errorMessage =
              e.response?.data['message'] ?? 'Unknown error occurred';
          HelperFunctions.showTopSnackBar(
            context: context,
            title: "Error",
            message: errorMessage,
          );
        } else {
          // Handle non-DioException errors
          print('Exception: $e');
        }
      }

      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add a New Address"),
          actions: <Widget>[
            isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : TextButton(
                    onPressed: onDone,
                    child: Text("Done", style: TextStyle(color: Colors.black)),
                  ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Your other form fields...
                      buildTextField(
                          'Name', 'Enter your name', nameController, true),
                      buildTextField('Phone Number', 'Enter your phone number',
                          phoneNumberController, true),
                      buildTextField('Address', 'Enter your address',
                          addressController, true),
                      buildTextField(
                          'Address (Optional)',
                          'Enter additional address details',
                          addressOptionalController,
                          false),
                      buildCountryDropdown(),
                      buildStateDropdown(),
                      buildTextField(
                          'City', 'Enter your city', cityController, true),
                      buildTextField('Pincode', 'Enter your pincode',
                          pincodeController, true,
                          isPincode: true),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint,
      TextEditingController controller, bool isRequired,
      {bool isPincode = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isPincode ? TextInputType.number : TextInputType.text,
        maxLength: isPincode ? 6 : null,
        decoration:
            InputDecoration(labelText: label, hintText: hint, counterText: ''),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Required Field';
          }
          if (isPincode) {
            final pincodeRegex = RegExp(r'^\d{6}$');
            if (!pincodeRegex.hasMatch(value!)) {
              return 'Please enter a valid 6-digit pincode';
            }
          }
          return null;
        },
      ),
    );
  }

  Widget buildCountryDropdown() {
    List<DropdownMenuItem<String>> countryItems = [
      DropdownMenuItem(
        value: 'dummy',
        child: Text("Select a Country"),
      ),
    ];

    countryItems.addAll(countries.map((Country country) {
      return DropdownMenuItem<String>(
        value: country.id.toString(),
        child: Text(country.name),
      );
    }).toList());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
            labelText: 'Country', hintText: 'Select your country'),
        value: !isCountrySelected ? 'dummy' : selectedCountryId,
        onChanged: (String? newValue) {
          if (newValue != null && newValue != 'dummy') {
            setState(() {
              selectedCountryId = newValue;
              isCountrySelected =
                  true; // Update to true when a country is selected
              states.clear();
              selectedStateId = 'dummy'; // Reset to default value
              fetchStates(newValue);
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty || value == 'dummy') {
            return 'Required Field';
          }
          return null;
        },
        items: countryItems,
      ),
    );
  }

  Widget buildStateDropdown() {
    List<DropdownMenuItem<String>> stateItems = [
      DropdownMenuItem(
        value: 'dummy',
        child: Text("Please Select a country first"),
      ),
    ];

    stateItems.addAll(states.map((StateModel state) {
      return DropdownMenuItem<String>(
        value: state.id.toString(),
        child: Text(state.name),
      );
    }).toList());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
            labelText: 'State', hintText: 'Please Select a country first'),
        value: !isCountrySelected || states.isEmpty ? 'dummy' : selectedStateId,
        onChanged: (String? newValue) {
          if (newValue != null && newValue != 'dummy') {
            setState(() {
              selectedStateId = newValue;
            });
          }
        },
        validator: (value) {
          if (selectedCountryId != null &&
              (value == null || value.isEmpty || value == 'dummy')) {
            return 'Required Field';
          }
          return null;
        },
        items: stateItems,
      ),
    );
  }
}
