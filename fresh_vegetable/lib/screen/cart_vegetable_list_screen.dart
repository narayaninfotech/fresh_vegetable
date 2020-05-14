import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshvegetable/model/address.dart';
import 'package:freshvegetable/model/address_list.dart';
import 'package:freshvegetable/model/cart_data_request.dart';
import 'package:freshvegetable/model/cart_data_response.dart';
import 'package:freshvegetable/model/order_list.dart';
import 'package:freshvegetable/model/order_request.dart';
import 'package:freshvegetable/model/order_response.dart';
import 'package:freshvegetable/network/cart_data_provider.dart';
import 'package:freshvegetable/screen/vegetable_list_screen.dart';
import 'package:freshvegetable/values/app_fonts.dart';
import 'package:freshvegetable/values/colors.dart';
import 'package:freshvegetable/values/network_check.dart';
import 'package:freshvegetable/values/shared_preference_util.dart';
import 'package:freshvegetable/values/utils.dart';
import 'package:freshvegetable/values/validators.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../routes.dart';

List<Address> addressItemList = List<Address>();

class CartVegetabeListScreen extends StatefulWidget {
  @override
  _CartVegetabeListScreenState createState() => _CartVegetabeListScreenState();
}

class _CartVegetabeListScreenState extends State<CartVegetabeListScreen> {
  TextEditingController addressController = TextEditingController();
  String address;
  TextEditingController cityController = TextEditingController();
  String city;
  TextEditingController zipController = TextEditingController();
  String zip;
  TextEditingController landmarkController = TextEditingController();
  String landmark;

  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    OrderResponse orderResponse = await createOrder(OrderRequest(
      amount: (getTotal() * 100).toInt(),
      currency: "INR",
      paymentCapture: 1,
      receipt: "h1",
    ));
    if (orderResponse != null && orderResponse.id != null) {
      var options = {
        'key': 'rzp_test_7NoKIfUhJH8XhK',
        'amount': getTotal() * 100,
        'name': 'Fresh Vegetable',
        'order_id': orderResponse.id,
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        debugPrint(e);
        Fluttertoast.showToast(msg: "$e");
      }
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    String email = await SharedPreferenceUtil.getString('email');
    CartDataResponse cartDataResponse =
        await sendCartDataRequest(CartDataRequest(
      userId: email,
      orderList: json.encode(OrderList(item: cartItemList).toJson()),
      address: json.encode(AddressList(addressItem: addressItemList).toJson()),
      amount: getTotal().toString(),
      paymentId: response.paymentId,
      orderId: response.orderId,
    ));

    if (cartDataResponse != null) {
      if (cartDataResponse.result == "Data added") {
        cartItemList.clear();
        addressItemList.clear();
        setState(() {});

        Navigator.of(context)
            .pushReplacementNamed(Routes.vegetabeListScreenRoute);
        Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId);
      }
    } else {
      print("Internal server error");
    }

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: AppColors.ternaryBackground,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  color: AppColors.secondaryBackground,
                  alignment: Alignment.center,
                  child: Text(
                    'Cart',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: cartItemList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: AppColors.secondaryBackground,
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    cartItemList.removeAt(index);
                                    setState(() {});
                                    if (cartItemList.length == 0) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset(
                                      'assets/images/icon-trash.png',
                                      fit: BoxFit.cover,
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CachedNetworkImage(
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  imageUrl: cartItemList[index].image,
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                              value:
                                                  downloadProgress.progress)),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                cartItemList[index].name,
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 180,
                                  height: 50,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  color: AppColors.ternaryBackground,
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          if (cartItemList[index].kg > 0.5) {
                                            setState(() {
                                              cartItemList[index].kg =
                                                  cartItemList[index].kg - 0.5;
                                            });
                                          }
                                        },
                                        child: Text(
                                          '-',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      Expanded(
                                        child: Text(
                                          '${cartItemList[index].kg.toStringAsFixed(2)} KG',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      InkWell(
                                        onTap: () {
                                          if (cartItemList[index].kg < 99) {
                                            setState(() {
                                              cartItemList[index].kg =
                                                  cartItemList[index].kg + 0.5;
                                            });
                                          }
                                        },
                                        child: Text(
                                          '+',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '₹ ${cartItemList[index].price.toStringAsFixed(2)} KG',
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '₹ ${(cartItemList[index].price * cartItemList[index].kg).toStringAsFixed(2)} for ${cartItemList[index].kg.toStringAsFixed(2)} KG',
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                if (getTotal() >= 100) {
                  addAddress();
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          backgroundColor: AppColors.ternaryBackground,
                          //this right here
                          child: Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MINIMUM PAYMENT REQUIRED: ₹100",
                                    style: TextStyle(
                                      color: AppColors.accentText,
                                      fontFamily: AppFonts.fontFamilyLatoBold,
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: SizedBox(
                                      width: 100,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: AppColors.accentText),
                                        ),
                                        color: AppColors.accentElement,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                  ;
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    alignment: Alignment.center,
                    width: 400,
                    height: 60,
                    color: AppColors.accentElement,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Total: ₹ ${getTotal().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.accentText,
                          ),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          'assets/images/icon-add-cart.png',
                          color: AppColors.accentText,
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'PLACE ORDER',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.accentText,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getTotal() {
    double total = 0;
    for (int counter = 0; counter < cartItemList.length; counter++) {
      total = total + (cartItemList[counter].price * cartItemList[counter].kg);
    }
    return total;
  }

  void addAddress() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: AppColors.ternaryBackground,
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Enter Delivery Address',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.accentElement,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextField(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.secondaryText,
                          ),
                          controller: addressController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.secondaryText,
                                width: 1.0,
                              ),
                            ),
                            prefix: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
                              child: Icon(
                                Icons.add_location,
                                size: 16,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            labelText: 'Address',
                            labelStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                            hintText: 'Address',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.secondaryText,
                          ),
                          controller: cityController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.secondaryText,
                                width: 1.0,
                              ),
                            ),
                            prefix: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
                              child: Icon(
                                Icons.location_city,
                                size: 16,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            labelText: 'City',
                            labelStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                            hintText: 'City',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.secondaryText,
                          ),
                          controller: zipController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.secondaryText,
                                width: 1.0,
                              ),
                            ),
                            prefix: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
                              child: Icon(
                                Icons.pin_drop,
                                size: 16,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            labelText: 'Zip Code',
                            labelStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                            hintText: 'Zip Code',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.secondaryText,
                          ),
                          controller: landmarkController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.secondaryText,
                                width: 1.0,
                              ),
                            ),
                            prefix: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
                              child: Icon(
                                Icons.label,
                                size: 16,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            labelText: 'Landmark',
                            labelStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                            hintText: 'Landmark',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            hideKeyboard(context);
                            if (addressController.text.isEmpty) {
                              toast("Please Enter Address");
                            } else if (cityController.text.isEmpty) {
                              toast("Please Enter City");
                            } else if (zipController.text.isEmpty) {
                              toast("Please Enter Zip Code");
                            } else if (landmarkController.text.isEmpty) {
                              toast("Please Enter Landmark");
                            } else {
                              NetworkCheck().check().then((internet) {
                                if (internet != null && internet) {
                                  addressItemList.add(Address(
                                      addressController.text,
                                      cityController.text,
                                      zipController.text,
                                      landmarkController.text));
                                  openCheckout();
                                  Navigator.of(context).pop();
                                } else {
                                  toast(
                                      'Please Check Your Internet Connection And Try Again');
                                }
                              });
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 60,
                              color: AppColors.accentElement,
                              child: Text(
                                'PROCEED',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.accentText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
