part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  const HomeState({
    required this.isLoading,
    required this.isLoadingRoute,
    required this.position,
    required this.stops,
    required this.selectedStop,
  });

  final bool isLoading;
  final bool isLoadingRoute;
  final LatLng position;
  final List<Stop> stops;
  final Stop? selectedStop;

  factory HomeState.initial() => const HomeState(
        isLoading: false,
        isLoadingRoute: false,
        position: LatLng(50.041118039423466, 21.9991345523946),
        stops: [],
        selectedStop: null,
      );

  HomeState copyWith({
    bool? isLoading,
    bool? isLoadingRoute,
    LatLng? position,
    List<Stop>? stops,
    Stop? selectedStop,
  }) {
    return HomeState(
      isLoadingRoute: isLoadingRoute ?? this.isLoadingRoute,
      isLoading: isLoading ?? this.isLoading,
      position: position ?? this.position,
      stops: stops ?? this.stops,
      selectedStop: selectedStop ?? this.selectedStop,
    );
  }

  @override
  List<Object?> get props => [
        isLoadingRoute,
        isLoading,
        position,
        stops,
        selectedStop,
      ];
}
