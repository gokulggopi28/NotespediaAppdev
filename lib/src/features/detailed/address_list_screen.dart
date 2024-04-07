import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespedia/src/features/detailed/settings_screen.dart';
import 'add_address_screen.dart'; // Ensure this matches your project structure
import 'controller/address_controller.dart';
import 'edit_address_screen.dart'; // Ensure this matches your project structure

class AddressesScreen extends StatelessWidget {
  final AddressesController controller = Get.put(AddressesController());

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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Get.to(SettingsScreen()), // Using GetX navigation
            ),
            title: Text("Addresses"),
            backgroundColor: Colors.white,
            centerTitle: false,
          ),
          body: Column(
            children: [
              ListTile(
                title: Text("Add new address"),
                trailing: Icon(Icons.chevron_right),
                onTap: () async {
                  print("Navigating to AddNewAddressScreen");
                  final result = await Get.to(() => AddNewAddressScreen());
                  print("Back from AddNewAddressScreen with result: $result");
                  if (result == true) {
                    print("Fetching addresses...");
                    controller.fetchAddresses();
                  }
                },

                // Using GetX navigation
              ),
              Expanded(
                child: Obx(
                  () => // Using Obx for reactivity
                      controller.addresses.isNotEmpty
                          ? ListView.builder(
                              itemCount: controller.addresses.length,
                              itemBuilder: (context, index) {
                                var address = controller.addresses[index];
                                return Card(
                                  margin: EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          address.contactPersonName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            '${address.addressLine1}\n${address.addressLine2 ?? ''}\n${address.city}\n${address.pinCode}\n${address.state}\n${address.country}\n${address.contactPersonPhone}'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () async {
                                                print(
                                                    "Navigating to EditAddressScreen");
                                                final result = await Get.to(
                                                    () => EditAddressScreen(
                                                        editingAddress:
                                                            address));
                                                print(
                                                    "Back from EditAddressScreen with result: $result");
                                                if (result == true) {
                                                  print(
                                                      "Fetching addresses...");
                                                  controller.fetchAddresses();
                                                }
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                // Show confirmation dialog before deleting
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Confirm"),
                                                      content: Text(
                                                          "Are you sure you want to delete this address?"),
                                                      actions: <Widget>[
                                                        // Cancel button
                                                        TextButton(
                                                          onPressed: () {
                                                            // Close the dialog. The address is not deleted.
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text("Cancel"),
                                                        ),
                                                        // Delete button
                                                        TextButton(
                                                          onPressed: () {
                                                            // Pop the dialog first
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            // Then delete the address
                                                            controller
                                                                .deleteAddress(
                                                                    address.id);
                                                          },
                                                          child: Text("Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red)),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            if (address.isDefault == 1)
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Default',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(child: Text('No addresses yet')),
                ),
              ),
            ],
          ),
        ));
  }
}
