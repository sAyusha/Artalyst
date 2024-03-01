// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';
import 'package:flutter_final_assignment/core/common/widget/semi_big_text.dart';
import 'package:flutter_final_assignment/core/common/widget/small_text.dart';
import 'package:flutter_final_assignment/features/home/domain/entity/home_entity.dart';
import 'package:flutter_final_assignment/features/navbar/presentation/view/bottom_navigation/bottom_navigation_bar.dart';
import 'package:flutter_final_assignment/features/order_summary/presentation/viewmodel/order_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderItems {
  final String orderId;

  OrderItems(
    this.orderId, 
  );
}

class DeliveryView extends ConsumerStatefulWidget {
  final HomeEntity homeEntity;
  const DeliveryView({
    Key? key,
    required this.homeEntity,
  }) : super(key: key);

  @override
  ConsumerState<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends ConsumerState<DeliveryView> {

  @override
  Widget build(BuildContext context) {
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
          'Delivery',
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
                'assets/images/delivery.png',
                height: isTablet ? 500 : 300,
                width: isTablet ? 500 : 300,
              ),
              // const SizedBox(height: 20),
              Text(
                'Your order will be delivered after 2 days.',
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
}
