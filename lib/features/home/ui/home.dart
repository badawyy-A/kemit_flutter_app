import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/home/image_classification/ui/image_classification_screen.dart';
import 'package:morshd/features/home/ui/home_screen_body.dart';
import 'package:morshd/features/nerest_places_on_map/service/location_service.dart';
import 'package:morshd/features/nerest_places_on_map/ui/map_view.dart';
import '../../nerest_places_on_map/logic/get_nearest_places_cubit/get_nearest_places_cubit.dart';
import '../../settings/ui/settings_screen.dart';
import '../chat_gemini/home_page.dart';
import 'widgets/home_screen_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _pageIndex = 2;

  final List<Widget> _screens = [
    ChatBotScreen(),
    HomePage(),
    HomeScreenBody(),
    BlocProvider(
      create: (context) => getIt<GetNearestPlacesCubit>()..getNearestPlaces(),
      child: MapView(),
    ),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    LocationService.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_pageIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
