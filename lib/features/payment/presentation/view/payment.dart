// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';
import 'package:flutter_final_assignment/core/common/widget/semi_big_text.dart';
import 'package:flutter_final_assignment/core/common/widget/small_text.dart';
import 'package:flutter_final_assignment/features/home/domain/entity/home_entity.dart';
import 'package:flutter_final_assignment/features/navbar/presentation/view/bottom_navigation/bottom_navigation_bar.dart';
import 'package:flutter_final_assignment/features/order_summary/presentation/viewmodel/order_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// import '../../../order_summary/domain/entity/order_entity.dart';

class OrderItems {
  final String orderId;

  OrderItems(
    this.orderId, 
  );
}

class PaymentView extends ConsumerStatefulWidget {
  final HomeEntity homeEntity;
  final String orderId;
  const PaymentView({
    Key? key,
    required this.homeEntity,
    required this.orderId,
  }) : super(key: key);

  @override
  ConsumerState<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends ConsumerState<PaymentView> {
  // @override
  // void initState() {
  //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  //     if (!isAllowed) {
  //       AwesomeNotifications().requestPermissionToSendNotifications();
  //     }
  //   });
  //   super.initState();
  // }

  // // Function to show the awesome notification
  // void showAwesomeNotification() {
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 1,
  //       channelKey: 'basic_channel',
  //       title: 'Payment Successful',
  //       body: 'Date: ${_getFormattedDate(DateTime.now())}',
  //       notificationLayout: NotificationLayout.BigPicture,
  //       bigPicture: 'asset://assets/images/success.png',
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // final art = widget.homeEntity;
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    // final orderId = widget.orderId;
    // var orderState = ref.watch(orderViewModelProvider);
    // final List<OrderEntity> orderData = orderState.orders;
    // final List<OrderItems> orders = orderData.map((order) {
    //   return OrderItems(
    //     order.orderId ?? "",
    //   );
    // }).toList();

    // final gap = SizedBox(height: isTablet ? 10 : 20);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Success',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/success.gif',
                height: isTablet ? 500 : 300,
                width: isTablet ? 500 : 300,
              ),
              // const SizedBox(height: 20),
              Text(
                'Payment Successfully Placed on ${_getFormattedDate(DateTime.now())}',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 28 : 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              const SmallText(
                text: 'Please wait till further notice. Thank You !!!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          // showAwesomeNotification();

                          await ref.watch(orderViewModelProvider.notifier).getYourOrder();
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ButtomNavView(
                                selectedIndex: 3,
                              ),
                            ),
                          );

                          // await ref.read(orderViewModelProvider.notifier).updateOrderToPaid(
                          //   orders[0].orderId,
                          // );

                        },
                        child: SemiBigText(
                          text: "Updates",
                          spacing: 0,
                          color: AppColorConstant.whiteTextColor,
                        )),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColorConstant.lightColor,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ButtomNavView(
                                selectedIndex: 1,
                              ),
                            ),
                          );
                        },
                        child: SemiBigText(
                          text: "Explore Upcoming",
                          spacing: 0,
                          color: AppColorConstant.blackTextColor,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFormattedDate(DateTime dateTime) {
    // Format the date using DateFormat from the intl package
    return DateFormat('dd MMM, yyyy').format(dateTime);
  }
}
