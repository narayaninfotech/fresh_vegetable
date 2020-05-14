import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshvegetable/model/get_images.dart';
import 'package:freshvegetable/model/item.dart';
import 'package:freshvegetable/network/images_data_provider.dart';
import 'package:freshvegetable/routes.dart';
import 'package:freshvegetable/screen/change_password_screen.dart';
import 'package:freshvegetable/screen/splash_screen.dart';
import 'package:freshvegetable/values/app_fonts.dart';
import 'package:freshvegetable/values/colors.dart';
import 'package:freshvegetable/values/navigate.dart';
import 'package:freshvegetable/values/shared_preference_util.dart';
import 'package:freshvegetable/values/utils.dart';
import 'package:popup_menu/popup_menu.dart';

List<Item> cartItemList = List<Item>();

class VegetabeListScreen extends StatefulWidget {
  @override
  _VegetabeListScreenState createState() => _VegetabeListScreenState();
}

class _VegetabeListScreenState extends State<VegetabeListScreen> {
  List<Item> itemList = List<Item>();

  bool isShowDialog = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getImagesData();

//    itemList.add(Item(1, 'assets/images/broccoli.png', 'Broccoli', 1, 10));
//    itemList.add(Item(2, 'assets/images/kale.png', 'Kale', 1, 20));
//    itemList.add(Item(3, 'assets/images/pepper.png', 'Red Pepper', 1, 30));
//    itemList
//        .add(Item(4, 'assets/images/strawberry.png', 'Strawberries', 1, 40));
//    // Extra
//    itemList.add(Item(5, 'assets/images/broccoli.png', 'Broccoli', 1, 50));
//    itemList.add(Item(6, 'assets/images/kale.png', 'Kale', 1, 60));
//    itemList.add(Item(7, 'assets/images/pepper.png', 'Red Pepper', 1, 70));
//    itemList
//        .add(Item(8, 'assets/images/strawberry.png', 'Strawberries', 1, 80));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Positioned.fill(
        child: Container(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 50),
                        InkWell(
                          onTap: (){
                            getImagesData();
                          },
                          child: Image.asset(
                            'assets/images/icon-refresh.png',
                            color: AppColors.primaryElement,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        SizedBox(width: 50),
                        InkWell(
                          onTap: () async {
                            if (cartItemList.length > 0) {
                              await Navigator.of(context).pushNamed(
                                  Routes.cartVegetabeListScreenRoute);
                              setState(() {});
                            }
                            else{
                              toast("Please Add Atleast One Itm To Continue");
                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Image.asset(
                                    'assets/images/icon-cart.png',
                                    color: AppColors.primaryElement,
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                cartItemList.length > 0
                                    ? Align(
                                        alignment: Alignment.bottomRight,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                              width: 15,
                                              height: 15,
                                              alignment: Alignment.center,
                                              color: AppColors.accentElement,
                                              child: Text(
                                                '${cartItemList.length}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppColors
                                                      .ternaryBackground,
                                                ),
                                              )),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        InkWell(
                          onTap: () {
                            showSaveDiscardDialog();
                          },
                          child: Image.asset(
                            'assets/images/icon-settings.png',
                            color: AppColors.primaryElement,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        SizedBox(width: 50),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: itemList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        Item item = itemList[index];
                        for (int counter = 0;
                            counter < cartItemList.length;
                            counter++) {
                          if (item.id == cartItemList[counter].id) {
                            item = cartItemList[counter];
                            break;
                          }
                        }
                        await showDialog(
                            context: context,
                            builder: (_) {
                              return MyDialog(item);
                            });
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: AppColors.secondaryBackground,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Expanded(
//                                  child: Image.asset(
//                                    itemList[index].image,
//                                    fit: BoxFit.contain,
//                                    width: double.infinity,
//                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    imageUrl: itemList[index].image,
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
                                  itemList[index].name,
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '₹ ${itemList[index].price.toStringAsFixed(2)} KG',
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
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      Positioned(
          child: isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : Container()),
    ]));
  }

  void getImagesData() async {
    setState(() {
      isLoading = true;
    });
    GetImagesData getImagesData = await fetchImagesData();

    for (int i = 0; i < getImagesData.getImages.length; i++) {
      itemList.add(Item(
          int.parse(getImagesData.getImages[i].id),
          getImagesData.getImages[i].imageUrl,
          getImagesData.getImages[i].name,
          double.parse(getImagesData.getImages[i].kg),
          double.parse(getImagesData.getImages[i].price)));
    }

    setState(() {
      isLoading = false;
    });
  }

  void showSaveDiscardDialog() {
    if (!isShowDialog) {
      isShowDialog = true;
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext buildContext) {
            return Container(
              height: 200,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        color: AppColors.primaryBackground,
                        child: Center(
                          child: Text(
                            'CHANGE PASSWORD',
                            style: TextStyle(color: AppColors.ternaryBackground),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.changePasswordScreenRoute);
                    },
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.transparent,
                  ),

                  InkWell(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        color: AppColors.primaryBackground,
                        child: Center(
                          child: Text(
                            'LOGOUT',
                            style: TextStyle(color: AppColors.ternaryBackground),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      SharedPreferenceUtil.clear();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.transparent,
                  ),
                  InkWell(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        color: AppColors.primaryBackground,
                        child: Center(
                          child: Text(
                            'CANCEL',
                            style: TextStyle(color: AppColors.ternaryBackground),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      onBackPress();
                    },
                  ),
                ],
              ),
            );
          }).whenComplete(() {
        isShowDialog = false;
      });
    } else {
      onBackPress();
    }
  }

  onBackPress() {
    Navigator.of(context).pop();
  }
}

class MyDialog extends StatefulWidget {
  Item item;

  MyDialog(this.item);

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  width: double.infinity,
                  imageUrl: widget.item.image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.item.name,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 220,
                  height: 60,
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
                          if (widget.item.kg > 0.5) {
                            setState(() {
                              widget.item.kg = widget.item.kg - 0.5;
                            });
                          }
                        },
                        child: Text(
                          '-',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: Text(
                          '${widget.item.kg.toStringAsFixed(2)} KG',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          if (widget.item.kg < 99) {
                            setState(() {
                              widget.item.kg = widget.item.kg + 0.5;
                            });
                          }
                        },
                        child: Text(
                          '+',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Item item = widget.item;
                  bool isNew = true;
                  for (int counter = 0;
                      counter < cartItemList.length;
                      counter++) {
                    if (item.id == cartItemList[counter].id) {
                      isNew = false;
                      break;
                    }
                  }
                  if (isNew) {
                    cartItemList.add(item);
                  }
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 60,
                      color: AppColors.accentElement,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/icon-add-cart.png',
                            color: AppColors.accentText,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'ADD TO CART',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.accentText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

