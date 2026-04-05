import 'package:bloc/bloc.dart';
import 'package:data_class/data_class.dart';
import 'package:equatable/equatable.dart';

@Data()
class MediaSkeletonState extends Equatable {
  const MediaSkeletonState({
    this.isGestureGuide = false,
    this.isGestureStart = false,
    this.x = 0,
    this.y = 0,
    this.zoom = 1,
    this.angle = 0,
  });

  final bool isGestureGuide;
  // first two-finger hold; release one finger; then move around;
  final bool isGestureStart;

  final double x;
  final double y;
  final double zoom;
  final double angle;

  @override
  List<Object?> get props => [isGestureGuide, x, y, zoom, angle];
}

class MediaSkeletonCubit extends Cubit<int> {
  MediaSkeletonCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
