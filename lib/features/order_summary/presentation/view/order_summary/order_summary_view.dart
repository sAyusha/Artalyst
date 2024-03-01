import 'package:flutter/material.dart';
import 'package:flutter_final_assignment/config/constants/app_color_constant.dart';
import 'package:flutter_final_assignment/features/home/domain/entity/home_entity.dart';
import 'package:flutter_final_assignment/features/order_summary/domain/entity/order_entity.dart';
// import 'package:flutter_final_assignment/features/order_summary/domain/entity/order_entity.dart';
// import 'package:flutter_final_assignment/features/order_summary/presentation/viewmodel/order_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../../../../../config/constants/api_endpoint.dart';
import '../../../../../core/common/components/rounded_button_field.dart';
import '../../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../../core/common/widget/semi_big_text.dart';
import '../../../../../core/common/widget/small_text.dart';
import '../../../../bidding/domain/entity/bidding_entity.dart';
import '../../../../payment/presentation/view/payment.dart';
import '../../viewmodel/order_viewmodel.dart';
// import '../../../../shipping/presentation/view/shipping/shipping_view.dart';
// import '../../../domain/entity/order_entity.dart';
// import '../../viewmodel/order_viewmodel.dart';

class OrderItems {
  final String orderId;

  OrderItems(
    this.orderId, 
  );
}

class OrderSummaryView extends ConsumerStatefulWidget {
  final HomeEntity art;
  final BidEntity bid;
  final ShippingAddress shippingAddress;
  const OrderSummaryView({
    Key? key,
    required this.art,
    required this.bid,
    required this.shippingAddress,
  }) : super(key: key);

  @override
  ConsumerState<OrderSummaryView> createState() => _OrderSummaryViewState();
}

class _OrderSummaryViewState extends ConsumerState<OrderSummaryView> {
  // Define a variable to hold the shipping fees amount.
  double shippingFees = 90.0;

  @override
  Widget build(BuildContext context) {
    final art = widget.art;

    var orderState = ref.watch(orderViewModelProvider);
    final List<OrderEntity> orderData = orderState.yourOrders;
    final order = orderData.isNotEmpty
      ? orderData[0].orderId
      : "sss";
    // final List<OrderItems> orders = orderData.map((order) {
    //   return OrderItems(
    //     order.orderId ?? "",
    //   );
    // }).toList();
    
    final double bidAmount = widget.bid.bidAmount.toDouble();

    final ShippingAddress shippingAddress = widget.shippingAddress;

    // var userState = ref.watch(profileViewModelProvider);
    // List<ProfileEntity> userData = userState.userData;

    final double totalAmount = bidAmount + shippingFees;

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final gap = SizedBox(height: isTablet ? 12.0 : 10.0);

    // khatli integration
    // ignore: unused_local_variable
    String referenceId = "";

    void onSuccess(PaymentSuccessModel success) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const SemiBigText(
                text: 'Payment Success',
                spacing: 0,
              ),
              actions: [
                SimpleDialogOption(
                    child: SmallText(
                      text: "ok",
                      color: AppColorConstant.successColor,
                    ),
                    onPressed: () async {
                      referenceId = success.idx;

                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentView(
                            orderId: order ?? "",
                            homeEntity: art,
                          ),
                        ),
                      );
                    })
              ],
            );
          });
    }

    void onFailure(PaymentFailureModel failure) {
      debugPrint(failure.toString());
    }

    void onCancel() {
      debugPrint("Cancelled by user");
    }

    payWithKhaltiInApp(String artId, String artTitle) {
      KhaltiScope.of(context).pay(
        config: PaymentConfig(
            amount: 1000, productIdentity: artId, productName: artTitle),
        preferences: [
          PaymentPreference.khalti,
        ],
        onSuccess: onSuccess,
        onFailure: onFailure,
        onCancel: onCancel,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ORDER SUMMARY',
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: AppColorConstant.lightNeutralColor4, width: 1.0),
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: isTablet
              ? EdgeInsets.all(AppColorConstant.kDefaultPadding)
              : EdgeInsets.all(AppColorConstant.kDefaultPadding / 2),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    '${ApiEndpoints.baseUrl}/uploads/${art.image}',
                    width: double.infinity,
                    height: isTablet ? 500 : 300,
                    fit: isTablet ? BoxFit.fill : BoxFit.cover,
                  ),
                ),
              ),
              gap,
              Text(
                art.title, 
                style: TextStyle(
                  fontSize: isTablet ? 28 : 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // gap,
              Text(
                art.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.w500,
                  height: isTablet ? 1.6 : 1.5,
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),
              Container(
                // width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: AppColorConstant.lightNeutralColor4, width: 2.0),
                  ),
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SmallText(text: "Subtotal"),
                    SmallText(text: "₹ $bidAmount"),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SmallText(text: "Shipping Fees"),
                    SmallText(
                      text: "₹ $shippingFees",
                    ),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SemiBigText(
                      text: "Total", 
                      spacing: 0,
                      color: Colors.green[900] ?? Colors.green,

                    ),
                    SemiBigText(
                      text: "₹ $totalAmount", 
                      spacing: 0,
                      color: Colors.green[900] ?? Colors.green,

                    ),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),
              SizedBox(
                width: double.infinity,
                child: RoundedButton(
                    text: "CHECKOUT",
                    press: () async {
                      await ref.read(orderViewModelProvider.notifier).addOrder(
                          OrderEntity(
                            orderItems: [
                              OrderItem(
                                image: art.image ?? "",
                                title: art.title,
                                description: art.description,
                              )
                            ],
                            shippingAddress: shippingAddress,
                            paymentMethod: "Khalti",
                            bidAmount: bidAmount,
                            shippingPrice: shippingFees,
                            totalAmount: totalAmount,
                          ),
                          widget.art.artId ?? "");

                         // ignore: use_build_context_synchronously
                         showSnackBar(
                        message: 'Order confirmed Successfully',
                        context: context,
                        color: AppColorConstant.successColor,
                      );

                      // khalti payment integration
                      payWithKhaltiInApp(
                          widget.art.artId ?? "", widget.art.title);
                      // ignore: use_build_context_synchronously
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PaymentView(
                      //       orderId: order ?? "",
                      //       homeEntity: art,
                      //     ),
                      //   ),
                      // );

                    await ref.watch(orderViewModelProvider.notifier).getYourOrder(
                    );
                    }),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
