import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  bool choolCheckDone = false;
  GoogleMapController? mapController;

  // latitude - 위도, longitude - 경도
  static final LatLng HomeLatLng = LatLng(
    37.3457,
    126.7419,
  );
  static final CameraPosition initialPosition = CameraPosition(
    target: HomeLatLng,
    zoom: 16,
  );
  static double RoundDistance = 100;

  static final Circle withinDistanceCircle = Circle(
    // 동그라미들 간의 분류를 위해 Id를 포함함.
    circleId: CircleId('withinDistanceCircle'),
    center: HomeLatLng,
    fillColor: Colors.blueAccent.withOpacity(0.3),
    radius: RoundDistance,
    strokeColor: Colors.blueAccent,
    strokeWidth: 1,
  );
  static final Circle notwithinDistanceCircle = Circle(
    // 동그라미들 간의 분류를 위해 Id를 포함함.
    circleId: CircleId('notwithinDistanceCircle'),
    center: HomeLatLng,
    fillColor: Colors.redAccent.withOpacity(0.3),
    radius: RoundDistance,
    strokeColor: Colors.redAccent,
    strokeWidth: 1,
  );
  static final Circle checkDoneCircle = Circle(
    // 동그라미들 간의 분류를 위해 Id를 포함함.
    circleId: CircleId('checkDoneCircle'),
    center: HomeLatLng,
    fillColor: Colors.greenAccent.withOpacity(0.3),
    radius: RoundDistance,
    strokeColor: Colors.greenAccent,
    strokeWidth: 1,
  );
  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: HomeLatLng,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          // future 파라미터 안에는 무조건 Future<T>를 리턴해주는 함수만 사용할 수 있음.
          future: checkPermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == '위치 권한이 허가되었습니다.') {
              return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {
                    bool isWithinRange = false;

                    if (snapshot.hasData) {
                      final start = snapshot.data!; // 현재 내 위치
                      final end = HomeLatLng; // 센터 위치

                      final distance = Geolocator.distanceBetween(
                        start.latitude,
                        start.longitude,
                        end.latitude,
                        end.longitude,
                      );

                      print('둘 사이의 거리 : ${distance.toInt()}M');
                      if (distance < RoundDistance) {
                        isWithinRange = true;
                      }
                    }
                    print(snapshot.data);
                    return Column(
                      children: [
                        _CustomGoogleMap(
                          initialPosition: initialPosition,
                          circle: choolCheckDone
                              ? checkDoneCircle
                              : isWithinRange
                              ? withinDistanceCircle
                              : notwithinDistanceCircle,
                          marker: marker,
                          onMapCreated: onMapCreated,
                        ),
                        _ChoolCheckButton(
                          isWithinRange: isWithinRange,
                          onChooCheckPressed: onChooCheckPressed,
                          choolCheckDone: choolCheckDone,
                        ),
                      ],
                    );
                  });
            }

            return Center(
              child: Text(snapshot.data),
            );
          },
        ));
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onChooCheckPressed() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('출근하기'),
          content: Text('출근을 하시겠습니다?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("출근하기"),
            )
          ],
        );
      },
    );
    if (result) {
      setState(() {
        choolCheckDone = true;
      });
    }
    print("출근완료");
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요.';
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요.';
    }

    // 남은 경우는 whileInUse이거나 always이므로 accept된 거임.
    return '위치 권한이 허가되었습니다.';
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  const _CustomGoogleMap({
    required this.initialPosition,
    required this.circle,
    required this.marker,
    required this.onMapCreated,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false, // 이건 앱바에 GMC를 사용해서 직접 기능 구현함
        circles: Set.from([circle]),
        markers: Set.from([marker]),
        onMapCreated: onMapCreated,
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  final bool isWithinRange;
  final VoidCallback onChooCheckPressed;
  final bool choolCheckDone;

  const _ChoolCheckButton({
    required this.isWithinRange,
    required this.onChooCheckPressed,
    required this.choolCheckDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timelapse_outlined,
              size: 50,
              color: choolCheckDone
                  ? Colors.greenAccent
                  : isWithinRange
                  ? Colors.blueAccent
                  : Colors.redAccent,
            ),
            const SizedBox(
              height: 10,
            ),
            if (!choolCheckDone && isWithinRange)
              TextButton(
                onPressed: onChooCheckPressed,
                child: Text(
                  '출근하기',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
          ],
        ));
  }
}
