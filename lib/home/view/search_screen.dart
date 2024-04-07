import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import CupertinoIcons for iOS back icon
import 'package:provider/provider.dart';
import 'package:resmpk/models/stop.dart';
import 'package:resmpk/helpers/app_style.dart';
import 'package:resmpk/home/cubit/home_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
    required this.stops,
    required this.onTap,
  }) : super(key: key);

  final List<Stop> stops;
  final Function(Stop) onTap;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late List<Stop> _filteredStops;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredStops = widget.stops;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterStops(String query) {
    setState(() {
      _filteredStops = widget.stops.where((stop) => stop.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.watch<HomeCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Wyszukiwarka',
          style: AppStyles.titleDetails,
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: AppStyles.bodyText,
              decoration: InputDecoration(
                hintText: 'Znajdz przystanek',
                hintStyle: AppStyles.bodyText.copyWith(color: AppColors.gray500),
                fillColor: AppColors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterStops,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredStops.length,
              itemBuilder: (context, index) {
                final stop = _filteredStops[index];
                return _buildItem(context, stop);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, Stop stop) {
    final homeCubit = context.read<HomeCubit>();
    final color = homeCubit.state.selectedStop?.id == stop.id ? AppColors.primary : AppColors.black;

    return GestureDetector(
      onTap: () => widget.onTap(stop),
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
}
