import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:notespedia/models/address_model.dart'; // Adjust path as necessary
import 'package:notespedia/models/country_model.dart'; // Adjust path as necessary

import 'package:notespedia/utils/helpers/helper_functions.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import '../../../models/state__model.dart';
import 'address_list_screen.dart';

class EditAddressScreen extends StatefulWidget {
  final Address? editingAddress;

  EditAddressScreen({Key? key, this.editingAddress}) : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController addressOptionalController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  List<Country> countries = [];
  String? selectedCountryId;
  List<StateModel> states = [];
  String? selectedStateId;

  @override
  void initState() {
    super.initState();
    fetchCountries().then((_) {
      if (widget.editingAddress != null) {
        // Assuming you can find the country and state by name or ID
        selectedCountryId = countries
            .firstWhere(
                (country) => country.name == widget.editingAddress!.country,
                orElse: () => countries.first)
            .id
            .toString();
        fetchStates(selectedCountryId!).then((_) {
          setState(() {
            selectedStateId = states
                .firstWhere(
                    (state) => state.name == widget.editingAddress!.state,
                    orElse: () => states.first)
                .id
                .toString();
          });
        });

        nameController.text = widget.editingAddress!.contactPersonName;
        phoneNumberController.text = widget.editingAddress!.contactPersonPhone;
        addressController.text = widget.editingAddress!.addressLine1!;
        addressOptionalController.text =
            widget.editingAddress!.addressLine2 ?? '';
        cityController.text = widget.editingAddress!.city;
        pincodeController.text = widget.editingAddress!.pinCode.toString();
      }
    });

    phoneNumberController.addListener(() {
      final text = phoneNumberController.text;
      if (!text.startsWith('+91 ')) {
        phoneNumberController.text = '+91 ' + text;
        phoneNumberController.selection = TextSelection.fromPosition(
            TextPosition(offset: phoneNumberController.text.length));
      }
    });
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
    if (widget.editingAddress == null) {
      // Handle error: No address to edit
      print("No address provided for editing.");
      return;
    }

    int userId = UserPreferences
        .userId; // Assuming UserPreferences has a getter for userId
    String addressId = widget.editingAddress!.id.toString();

    // Construct the payload
    var data = {
      "contact_person_name": nameController.text,
      "contact_person_phone": phoneNumberController.text.replaceAll('+91 ', ''),
      "address_line_1": addressController.text,
      "address_line_2": addressOptionalController.text,
      "pin_code": pincodeController.text,
      "country": countries
          .firstWhere((country) => country.id.toString() == selectedCountryId,
              orElse: () => Country(id: 0, name: ""))
          .name,
      "state": states
          .firstWhere((state) => state.id.toString() == selectedStateId,
              orElse: () => StateModel(id: 0, name: ""))
          .name,
      "city": cityController.text,
      "user_id": userId
    };

    try {
      var response = await Dio().patch(
          'https://notespaedia.deienami.com/api/users/address/$addressId/?user_id=$userId',
          data: data);

      if (response.statusCode == 200) {
        HelperFunctions.showTopSnackBar(
            context: context,
            title: "Success",
            message: "Address Updated Successfully");
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) Get.back(result: true);
        });
      } else {
        HelperFunctions.showTopSnackBar(
            context: context, title: "Error", message: "Unable to add address");
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
      HelperFunctions.showTopSnackBar(
          context: context,
          title: "Error",
          message: "An error occurred while updating the address");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Check if it's possible to pop the current route.
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current route.
            return false; // Prevent the system from popping the route, as we've handled it manually.
          }
          return true; // Allow the system to handle the back button (e.g., exiting the app) if no routes to pop.
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Edit Address"),
            actions: <Widget>[
              TextButton(
                onPressed: onDone,
                child: Text("Done", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField('Name', 'Enter your name', nameController),
                  buildTextField('Phone Number', 'Enter your phone number',
                      phoneNumberController),
                  buildTextField(
                      'Address', 'Enter your address', addressController),
                  buildTextField(
                      'Address (Optional)',
                      'Enter additional address details',
                      addressOptionalController),
                  buildCountryDropdown(),
                  buildStateDropdown(),
                  buildTextField('City', 'Enter your city', cityController),
                  buildTextField(
                      'Pincode', 'Enter your pincode', pincodeController),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildTextField(
      String label, String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }

  Widget buildCountryDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedCountryId,
        decoration: InputDecoration(
            labelText: 'Country', hintText: 'Select your country'),
        onChanged: (newValue) {
          setState(() {
            selectedCountryId = newValue;
            states.clear(); // Clear existing states when country changes
            selectedStateId = null; // Reset selected state
          });
          fetchStates(newValue!);
        },
        items: countries.map<DropdownMenuItem<String>>((Country country) {
          return DropdownMenuItem<String>(
            value: country.id.toString(),
            child: Text(country.name),
          );
        }).toList(),
      ),
    );
  }

  Widget buildStateDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedStateId,
        decoration:
            InputDecoration(labelText: 'State', hintText: 'Select your state'),
        onChanged: states.isNotEmpty
            ? (newValue) {
                setState(() {
                  selectedStateId = newValue;
                });
              }
            : null,
        items: states.map<DropdownMenuItem<String>>((StateModel state) {
          return DropdownMenuItem<String>(
            value: state.id.toString(),
            child: Text(state.name),
          );
        }).toList(),
      ),
    );
  }
}
