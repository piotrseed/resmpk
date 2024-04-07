import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import 'package:provider/provider.dart';
import 'package:resmpk/helpers/app_constants.dart';
import 'package:resmpk/helpers/app_style.dart';
import 'package:resmpk/home/cubit/home_cubit.dart';
import 'package:resmpk/models/connections.dart';
import 'package:resmpk/models/stop.dart';
import 'package:resmpk/routers/app_route.gr.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late MapController mapController;
  late ScrollController scrollController;
  late AnimationController controllerAnimation;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onCurrentLocation(context);
      _scrollToSelected(context);
      controllerAnimation = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerAnimation.dispose();
  }

  void _onCurrentLocation(BuildContext context) {
    final homeState = context.read<HomeCubit>().state;
    final selected = homeState.selectedStop;
    if (selected != null) {
      mapController.move(selected.latLng, 17);
    } else {
      mapController.move(homeState.position, 17);
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;

    return Scaffold(
      backgroundColor: AppColors.gray100,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildMap(context),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final homeState = context.read<HomeCubit>().state;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - AppConstants.heightBody + 20.0,
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              backgroundColor: AppColors.gray100,
              initialCenter: homeState.position,
              initialZoom: 16,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.drag | InteractiveFlag.pinchMove | InteractiveFlag.pinchZoom,
              ),
              onMapReady: () {
                homeCubit.getCurrentLocation();
                _onCurrentLocation(context);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                // urlTemplate: 'https://api.maptiler.com/maps/bright-v2/{z}/{x}/{y}@2x.png?key=CupJujGiKllQoAfHhIDY',
                // urlTemplate: 'https://api.maptiler.com/maps/streets-v2-light/{z}/{x}/{y}@2x.png?key=CupJujGiKllQoAfHhIDY',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'pl.devise.resmpk',
              ),
              MarkerClusterLayerWidget(
                options: MarkerClusterLayerOptions(
                  maxClusterRadius: 80,
                  size: const Size(40, 40),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(50),
                  maxZoom: 15,
                  markers: [
                    Marker(
                      point: homeState.position,
                      width: 40,
                      height: 40,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: const Icon(Icons.my_location, size: 20, color: AppColors.primary),
                      ),
                    ),
                    ...homeState.stops.map((stop) => _buildMarker(context, stop)),
                  ],
                  builder: (context, markers) {
                    return Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                      child: Center(
                        child: Text(
                          markers.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildActionsMarker(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: AppConstants.heightBody,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray400.withOpacity(0.1),
              spreadRadius: 12,
              blurRadius: 8,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 6),
              decoration: const BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
            ),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        _buildActions(context),
        _buildStops(context),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final homeState = context.watch<HomeCubit>().state;
    final stops = homeState.stops;
    return GestureDetector(
      onTap: () => context.router.push(
        SearchRoute(
          stops: stops,
          onTap: (Stop stop) async {
            Navigator.of(context).pop();
            await homeCubit.selectedStop(stop: stop);
            _scrollToSelected(context);
            _animatedMapMove(stop.latLng, 17, stop);
          },
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            SizedBox(
              width: 70,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search, color: AppColors.black),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Szukaj...',
                style: AppStyles.bodyText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStops(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;

    return Container(
      height: 190,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: List.generate(
            homeState.stops.length,
            (index) => _buildItem(context, homeState.stops[index]),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, Stop stop) {
    final homeCubit = context.read<HomeCubit>();
    final color = homeCubit.state.selectedStop?.id == stop.id ? AppColors.primary : AppColors.black;

    return GestureDetector(
      onTap: () {
        homeCubit.selectedStop(stop: stop);
        _onCurrentLocation(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.gray100, width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Icon(Icons.directions_bus, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stop.name,
                    style: AppStyles.stopTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('${stop.distanceM} m', style: AppStyles.stopMeters),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToSelected(BuildContext context) {
    final homeState = context.read<HomeCubit>().state;
    final selectedStop = homeState.selectedStop;
    if (selectedStop != null) {
      final index = context.read<HomeCubit>().state.stops.indexOf(selectedStop);
      if (index != -1) {
        scrollController.animateTo(
          index * 64.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  Widget _buildActionsMarker(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;
    final homeCubit = context.read<HomeCubit>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (homeState.isLoadingRoute) _buildLoader(),
              _buildRowConnections(context),
              Column(
                children: [
                  _buildButton(
                    onPressed: () => homeCubit.init(),
                    icon: Icons.refresh,
                  ),
                  const SizedBox(height: 8),
                  _buildButton(
                    onPressed: () async {
                      await homeCubit.init();
                      mapController.move(homeState.position, 17);
                    },
                    icon: Icons.my_location,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRowConnections(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;
    final connections = homeState.selectedStop?.connections;
    final selected = homeState.selectedStop;
    if (connections != null && connections.isNotEmpty) {
      return Expanded(
        child: Wrap(
          spacing: 4,
          runSpacing: 4,
          verticalDirection: VerticalDirection.up,
          direction: Axis.horizontal,
          children: connections
              .map(
                (connection) => _buildButtonRoute(
                  context,
                  onPressed: () => context.router.push(DetailsRoute(
                    connections: connections,
                    stop: selected!,
                  )),
                  connection: connection,
                ),
              )
              .toList(),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildLoader() {
    return const SizedBox(
      width: 32,
      height: 32,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
      ),
    );
  }

  Widget _buildButton({required VoidCallback onPressed, required IconData icon}) {
    return SizedBox(
      width: 48,
      height: 48,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray400.withOpacity(0.1),
                spreadRadius: 12,
                blurRadius: 8,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.black),
        ),
      ),
    );
  }

  Widget _buildButtonRoute(BuildContext context, {required VoidCallback onPressed, required Connections connection}) {
    return SizedBox(
      width: 38,
      height: 38,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray400.withOpacity(0.1),
                spreadRadius: 12,
                blurRadius: 8,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Text(connection.routeShortName, style: AppStyles.buttonRoute),
          ),
        ),
      ),
    );
  }

  Marker _buildMarker(BuildContext context, Stop stop) {
    final homeCubit = context.read<HomeCubit>();
    final homeState = context.watch<HomeCubit>().state;
    final selected = homeState.selectedStop;
    var color;

    if (selected != null) {
      if (selected.latLng == stop.latLng) {
        color = AppColors.primary;
      } else {
        color = AppColors.gray400;
      }
    } else {
      color = AppColors.black;
    }

    return Marker(
      point: stop.latLng,
      width: 40,
      height: 40,
      child: GestureDetector(
        onTap: () async {
          await homeCubit.selectedStop(stop: stop);
          _scrollToSelected(context);
          _animatedMapMove(stop.latLng, 17, stop);
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Center(
            child: Icon(Icons.directions_bus, size: 25, color: color),
          ),
        ),
      ),
    );
  }

  void _animatedMapMove(LatLng destLocation, double destZoom, Stop stop) {
    final latTween = Tween<double>(begin: mapController.camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(begin: mapController.camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.camera.zoom, end: destZoom);
    final Animation<double> animation = CurvedAnimation(parent: controllerAnimation, curve: Curves.fastOutSlowIn);
    controllerAnimation.addListener(() {
      mapController.move(LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)), zoomTween.evaluate(animation));
    });
    controllerAnimation.forward();
  }
}
