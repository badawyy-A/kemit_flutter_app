import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/service_model.dart';
import 'service_card.dart';

class ServiceGridView extends StatelessWidget {
  const ServiceGridView({
    super.key,
  });

  final List<ServiceCardModel> serviceCards = const [
    ServiceCardModel(
      icon: Icons.local_hospital,
      title: 'Hospitals',
    ),
    ServiceCardModel(
      icon: Icons.emoji_transportation,
      title: 'Transportation',
    ),
    ServiceCardModel(
      icon: FontAwesomeIcons.landmark,
      title: 'Historical',
    ),
    ServiceCardModel(
      icon: Icons.card_giftcard_outlined,
      title: 'Souvenir',
    ),
    ServiceCardModel(
      icon: Icons.museum,
      title: 'Museums',
    ),
    ServiceCardModel(
      icon: Icons.festival,
      title: 'Entertainment',
    ),
    ServiceCardModel(
      icon: Icons.hotel,
      title: 'Hotels',
    ),
    ServiceCardModel(
      icon: Icons.restaurant,
      title: 'Restaurants',
    ),
    ServiceCardModel(
      icon: Icons.beach_access,
      title: 'Beaches',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160.w,
          mainAxisSpacing: 22.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 2.5 / 3,
        ),
        itemCount: serviceCards.length,
        itemBuilder: (context, index) {
          return ServiceCard(
            serviceCardModel: serviceCards[index],
          );
        },
      ),
    );
  }
}
