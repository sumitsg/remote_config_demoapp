import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_congigue_demoapp/common/DI/dependancy_container.dart';
import 'package:remote_congigue_demoapp/common/colors_pages.dart';
import 'package:remote_congigue_demoapp/common/custom_text_style.dart';
import 'package:remote_congigue_demoapp/domain/entities/app_config_entity.dart';
import 'package:remote_congigue_demoapp/domain/entities/check_update_model_entity.dart';
import 'package:remote_congigue_demoapp/domain/usecase/get_product_list_usecase.dart';
import 'package:remote_congigue_demoapp/domain/usecase/get_product_stream.dart';
import 'dart:developer' as dev;

import 'package:remote_congigue_demoapp/presentation/bloc/product_detail_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
// late ProductListingData data ;

  late ProductDetailBloc bloc;

  @override
  void initState() {
    // dev.log("${jsonEncode(ProductListingData.fromListToJson(productData))}");
    bloc = BlocProvider.of<ProductDetailBloc>(context);

    // bloc.add(GetProductDetailsEvent());
    bloc.add(GetProductDetailsStreamEvent());

    bloc.add(CheckForAppUpdate());

    super.initState();
  }

  @override
  void dispose() {
    bloc.controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.black00,
      appBar: AppBar(
        title: const Text("Flutter Events"),
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () => bloc.add(GetProductDetailsStreamEvent()),
              icon: const Icon(Icons.replay_outlined))
        ],
      ),
      body: SafeArea(
          child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        buildWhen: (previous, current) {
          if (current is AppUpdateFetchSuccessfully) {
            CheckUpdateModelEntity entityData = current.checkUpdateData;
            print("Data in UI is--->$entityData");

            var androidPLatform = Platform.isAndroid;

            WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
              Widget cancelButton = TextButton(
                child: Text(
                  "Skip",
                  style: CustomTextStyles.instance
                      .smTextSemiBold(color: CustomColors.whiteff),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
              Widget continueButton = TextButton(
                child: Text(
                  "Update",
                  style: CustomTextStyles.instance
                      .smTextSemiBold(color: CustomColors.whiteff),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (Platform.isAndroid) {
                    _launchUrl(url: "https://play.google.com");
                  } else {
                    _launchUrl(url: "https://www.apple.com/in/app-store/");
                  }
                },
              );

              AlertDialog alert = AlertDialog(
                backgroundColor: CustomColors.black14,
                title: const Text("Update available"),
                content: const Text("A new version of the app is available"),
                actions: [cancelButton, continueButton],
              );

              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            });
          }
          return current is ProductFetchSuccessState;
        },
        builder: (context, state) {
          if (state is ProductFetchSuccessState) {
            // print(object)
            dev.log(state.dataList.toString());

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.55),
                itemCount: state.dataList.length,
                itemBuilder: (context, index) {
                  ProductDataEntity data = bloc.productList[index];
                  return Container(
                      decoration: BoxDecoration(
                          color: CustomColors.grey24,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            height: 130,
                            child: Image.network(
                              data.imgUrl,

                              height: 130,
                              // width: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Divider(
                            thickness: 0.7,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  data.productBrand,
                                  style: CustomTextStyles.instance.normalText(),
                                ),
                                const SizedBox(height: 2),
                                Text(data.productName,
                                    style: CustomTextStyles.instance.normalText(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 8),
                                Text("${data.gender} | ${data.color} ",
                                    style: CustomTextStyles.instance
                                        .smTextSemiBold(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400)),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\u{20B9}${data.ogPrice}",
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text("\u{20B9}${data.price}",
                                          style: CustomTextStyles.instance
                                              .normalText(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text("Discount: ${data.discount}%",
                                    style: CustomTextStyles.instance.normalText(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 15),
                                Text(
                                  "Reviews: ${data.reviewCount}",
                                ),
                                // SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ));
                },
                // separatorBuilder: (context, index) => const Divider(height: 5),
              ),
            );
          }
          return Container(
            child: Center(
              child: Text("No Data found from server"),
            ),
          );
        },
      )),
    );
  }

  _launchUrl({required String url}) async {
    if (await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}

class ProductListingData {
  final String productBrand;
  final String productName;
  final String gender;
  final String color;
  final String price;
  final String ogPrice;
  final String discount;
  final String imgUrl;

  ProductListingData({
    required this.productBrand,
    required this.productName,
    required this.gender,
    required this.color,
    required this.price,
    required this.ogPrice,
    required this.discount,
    required this.imgUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "productBrand": productBrand,
      "productName": productName,
      "gender": gender,
      "color": color,
      "price": price,
      "ogPrice": ogPrice,
      "discount": discount,
      "imgUrl": imgUrl,
    };
  }

  static List<Map<String, dynamic>> fromListToJson(
      List<ProductListingData> list) {
    return list.map((e) => e.toJson()).toList();
  }
}
