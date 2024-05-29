import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/app_image.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/widget/custom_button.dart';
import 'package:redda_customer/widget/map_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:
        SafeArea(
          child: Container(
            height: Get.height,
            width: Get.width,
            // color: Colors.cyan,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Text(
                                    "Kalupur, Ahmedabad",
                                    style: Styles.boldDarkGrey60012,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //=========================Profile Image==============
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
                                  offset: const Offset(
                                      0, 5), // Set the shadow offset
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                'https://picsum.photos/id/237/300/300',
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                      borderRadius: BorderRadius.circular(15)),
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
                        padding:
                            const EdgeInsets.only(left: 24, top: 20, right: 24),
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
                              fun: () {},
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
                        height: 331,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: primary),
                        ),
                        child: MapWidget(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
