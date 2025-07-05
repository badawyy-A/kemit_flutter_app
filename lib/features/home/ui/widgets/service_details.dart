import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/home/ui/widgets/tourism_view.dart';
import 'package:morshd/features/nearest_places/logic/cubit/get_places_cubit.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({super.key, required this.category});
  final String category;

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => getIt<GetPlacesCubit>()..getPlaces(),
        child: TourismView(category: widget.category),
      ),
    );
  }
}
