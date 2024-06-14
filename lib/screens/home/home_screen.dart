import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/app_image.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/seach_location.dart';
import 'package:redda_customer/widget/custom_button.dart';
import 'package:redda_customer/widget/location.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../main.dart';
import '../auth/signIn/signIn_controller.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final SignInController _signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          drawer: drawer(context),
          appBar: AppBar(
            backgroundColor: white,
            forceMaterialTransparency: true,
            title: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //=========================Current Location==============

                    Text(
                      "Current Location",
                      style: Styles.lable414,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppImage.LOCATION),
                        const Gap(6),
                        Obx(() {
                          return SizedBox(
                            width: MySize.safeWidth! / 2,
                            child: Text(
                              controller.currentLocation.value,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.boldDarkGrey60012,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white, // Set the border color
                      width: 3.0, // Set the border width
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        // Set the shadow color
                        blurRadius: 10.0,
                        // Set the shadow blur radius
                        offset: const Offset(0, 5), // Set the shadow offset
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/id/237/300/300',
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              height: Get.height,
              width: Get.width,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        //=========================Slider==============

                        CarouselSlider(
                          carouselController: controller.slideController,
                          options: CarouselOptions(
                            height: 150.0,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            // onPageChanged: callbackFunction,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              controller.currentIndex.value = index;
                            },
                          ),
                          items: controller.items?.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    decoration: BoxDecoration(
                                        // color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Image.asset(
                                      i,
                                      fit: BoxFit.contain,
                                    ));
                              },
                            );
                          }).toList(),
                        ),
                        const Gap(14),
                        Center(
                          child: AnimatedSmoothIndicator(
                            axisDirection: Axis.horizontal,
                            activeIndex: controller.currentIndex.value,
                            count: controller.items?.length ?? 0,
                            effect: const ExpandingDotsEffect(
                              activeDotColor: primary,
                              dotColor: Colors.grey,
                              dotHeight: 8,
                              dotWidth: 8,
                            ),
                            onDotClicked: (index) {
                              controller.slideController.animateToPage(index);
                            },
                          ),
                        ),
                        const Gap(14),

                        //=========================SET Location==============
                        Container(
                          width: double.infinity,
                          height: 129,
                          padding: const EdgeInsets.only(
                              left: 24, top: 20, right: 24),
                          decoration: BoxDecoration(
                            // color: ,
                            border: Border.all(color: primary),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pick up or send Anything",
                                style: Styles.boldBlack616,
                              ),
                              const Gap(2),
                              Text(
                                "Delivering Convenience at Your Doorstep",
                                style: Styles.lable414,
                              ),
                              const Gap(12),
                              CustomButton(
                                width: double.infinity,
                                height: 32,
                                borderCircular: 7,
                                text: "Set pick up & drop location",
                                fun: ()async {
                                  print("is Permission==>> ${controller.status.value}");
                                  if (controller.status.value ==
                                      'Status.granted') {
                                    Get.toNamed(AppRoutes.PICKUPSCREEN);
                                  } else {
                                    var status = await Permission.locationWhenInUse.request();
                                    controller.rebuildLocationWidget();

                                    bool isLocationServiceEnabled =
                                        await Geolocator.isLocationServiceEnabled();
                                   DioExceptions.showMessage(context, controller.status.value);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const Gap(14),
                        Text(
                          "Your Location",
                          style: Styles.boldBlack616,
                        ),
                        const Gap(14),
                        Container(
                          padding: const EdgeInsets.all(4),
                          height: 331,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: primary),
                          ),
                          child:  Obx(
                                () => GetLocationScreen(key: controller.locationWidgetKey.value),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: controller.rebuildLocationWidget,
                          child: Text('Rebuild GetLocationScreen'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget drawer(
    BuildContext context,
  ) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MySize.getScaledSizeHeight(22),
                right: MySize.getScaledSizeHeight(34),
                top: MySize.getScaledSizeHeight(44),
                bottom: MySize.getScaledSizeHeight(14),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            AppImage.USERDUMMY,
                            width: MySize.size48,
                            height: MySize.size48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(MySize.size14!),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              style: Styles.boldBlack716,
                            ),
                            Text(
                              _signInController.model.fullname ?? "",
                              style: Styles.lable414,
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 16,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black12,
            ),
            _commonListtile(
                context: context,
                icon: AppImage.USER,
                title: 'Edit Profile',
                fun: () async {
                  Navigator.pop(context);
                  Get.toNamed(AppRoutes.EDIT_PROFILE);
                }),
            _commonListtile(
                context: context,
                icon: AppImage.ADDRESS,
                title: 'Addresses',
                fun: () async {
                  Navigator.pop(context);
                  Get.toNamed(AppRoutes.ADD_ADDRESS);
                  //Get.toNamed(AppRoutes.NO_ADDRESS);
                }),
            _commonListtile(
                context: context,
                icon: AppImage.WALLET,
                title: 'Payment & Refunds',
                fun: () async {
                  Navigator.pop(context);
                  Get.toNamed(AppRoutes.PAYMENTOPTION);

                  // showErrorMessage(
                  //   context: context,
                  //   message: 'Your account has been deleted.',
                  //   backgroundColor: green,
                  // );
                  // resate(context);
                  // delet(context);
                }),_commonListtile(
                context: context,
                icon: AppImage.WALLET,
                title: 'Search',
                fun: () async {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPlaceScreen()),
                  );

                }),
            _commonListtile(
                context: context,
                icon: AppImage.LOGOUT,
                title: 'LogOut',
                fun: () async {
                  Navigator.pop(context);
                  resate(context);
                  // showErrorMessage(
                  //   context: context,
                  //   message: 'Your account has been deleted.',
                  //   backgroundColor: green,
                  // );
                  // resate(context);
                  // delet(context);
                }),
          ],
        ),
      ),
    );
  }

  ListTile _commonListtile(
      {required BuildContext context,
      required String title,
      required String icon,
      required VoidCallback fun}) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      leading: SvgPicture.asset(
        icon.toString(),
        height: MySize.size18,
        width: MySize.size18,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: Styles.boldBlack614,
      ),
      onTap: fun,
    );
  }
}
