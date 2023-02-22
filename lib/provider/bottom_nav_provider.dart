import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavState extends StateNotifier<int> {
  BottomNavState() : super(0);

  @override
  set state(int value) {
    super.state = value;
  }
}
