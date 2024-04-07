import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class InAppSubscription {
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  InAppSubscription() : super() {}

  void setupInAppSubscription(
      {required Function(PurchaseDetails) onPurchaseDone}) {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList, onPurchaseDone);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      // handle error here.
    }) as StreamSubscription<List<PurchaseDetails>>?;
  }

  void dispose() {
    _subscription?.cancel();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList,
      Function(PurchaseDetails p1) onPurchaseDone) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        //_showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          print("$purchaseDetails");
          onPurchaseDone(purchaseDetails);
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (valid) {
          //   _deliverProduct(purchaseDetails);
          // } else {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          print("$purchaseDetails");
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<void> doPurchase(int productID) async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      // toast("Subscription store not available");
      return;
      // The store cannot be reached or accessed. Update the UI accordingly.
    }
    const Set<String> _kIds = <String>{
      'com.notespaedia.npquarterlysubscription',
      'com.notespaedia.nphalfyearlysubscription',
      'com.notespaedia.npyearlysubscription'
    };
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }
    List<ProductDetails> products = response.productDetails;
    ProductDetails _selectedProduct;
    _selectedProduct = products.firstWhere(
        (element) => element.id == 'com.notespaedia.npquarterlysubscription');
    if (productID == 13) {
      _selectedProduct = products.firstWhere(
          (element) => element.id == 'com.notespaedia.npquarterlysubscription');
    } else if (productID == 14) {
      _selectedProduct = products.firstWhere((element) =>
          element.id == 'com.notespaedia.nphalfyearlysubscription');
    } else if (productID == 15) {
      _selectedProduct = products.firstWhere(
          (element) => element.id == 'com.notespaedia.npyearlysubscription');
    }
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: _selectedProduct);
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }
}
