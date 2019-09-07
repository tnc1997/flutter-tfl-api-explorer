import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/states/tfl_api_state.dart';

import 'mocks/tfl_api_mock.dart';
import 'mocks/tfl_api_state_mock.dart';

void main() {
  final _bikePoints = <Place>[
    Place(
      id: 'BikePoints_1',
      commonName: 'River Street, Clerkenwell',
      placeType: 'BikePoint',
      lat: 51.529162,
      lon: -0.10997,
    ),
    Place(
      id: 'BikePoints_2',
      commonName: 'Phillimore Gardens, Kensington',
      placeType: 'BikePoint',
      lat: 51.499606,
      lon: -0.197574,
    ),
    Place(
      id: 'BikePoints_3',
      commonName: 'Christopher Street, Liverpool Street',
      placeType: 'BikePoint',
      lat: 51.521283,
      lon: -0.084605,
    ),
  ];

  final _bikePointsResourceApi = BikePointsResourceApiMock();

  final _tflApi = TflApiMock();

  final _tflApiState = TflApiStateMock();

  setUpAll(() {
    when(_bikePointsResourceApi.get()).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _bikePoints,
      );
    });

    when(_tflApi.bikePoints).thenReturn(_bikePointsResourceApi);

    when(_tflApiState.tflApi).thenReturn(_tflApi);
  });

  testWidgets('Bike point search', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: <SingleChildCloneableWidget>[
          Provider<TflApiState>.value(value: _tflApiState),
        ],
        child: MaterialApp(
          home: BikePointsPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    _bikePoints.forEach((bikePoint) {
      expect(
        find.text(bikePoint.commonName),
        findsWidgets,
      );
    });

    await tester.enterText(find.byType(TextField), 'clerkenwell');
    await tester.pumpAndSettle();

    expect(
      find.text(_bikePoints[0].commonName),
      findsWidgets,
    );

    await tester.tap(find.text(_bikePoints[0].commonName));
    await tester.pumpAndSettle();

    expect(
      find.text(_bikePoints[0].id),
      findsWidgets,
    );
    expect(
      find.text(_bikePoints[0].commonName),
      findsWidgets,
    );
  });
}
