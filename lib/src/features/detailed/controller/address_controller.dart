import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import '../../../../models/address_model.dart';

class AddressesController extends GetxController {
  var addresses = <Address>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    isLoading(true);
    int userId = UserPreferences.userId;
    try {
      var response = await Dio()
          .get('http://139.59.38.234/api/users/address/?user_id=$userId');
      if (response.statusCode == 200) {
        var data = response.data['data'];
        if (data is List) {
          addresses.value =
              data.map((addressJson) => Address.fromJson(addressJson)).toList();
        }
      } else {
        print('Error fetching addresses: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteAddress(int addressId) async {
    int userId = UserPreferences.userId;
    try {
      var response = await Dio().delete(
          'https://notespaedia.deienami.com/api/users/address/$addressId/?user_id=$userId');
      if (response.statusCode == 200 || response.statusCode == 204) {
        fetchAddresses(); // Refresh the list after deletion
      } else {
        print('Error deleting address: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while deleting address: $e');
    }
  }
}
