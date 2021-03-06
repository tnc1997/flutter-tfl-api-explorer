import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_park_page.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_parks_page.dart';
import 'package:tfl_api_explorer/src/pages/home_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_disruptions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_routes_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_statuses_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_predictions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_route_sequences_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_stop_points_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/lines_page.dart';
import 'package:tfl_api_explorer/src/pages/roads/road_page.dart';
import 'package:tfl_api_explorer/src/pages/roads/roads_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/about_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/settings_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_points_page.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([
  AuthenticationChangeNotifier,
  BikePointService,
  LineService,
  OccupancyService,
  PlaceService,
  RoadService,
  StopPointService,
  TflApiClient,
])
void main() {
  final authenticationChangeNotifier = MockAuthenticationChangeNotifier();

  final bikePointService = MockBikePointService();

  final bikePoints = <Place>[
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

  final carParkOccupancies = <CarParkOccupancy>[
    CarParkOccupancy(
      id: 'CarParks_800491',
      name: 'Barkingside Stn (LUL)',
    ),
    CarParkOccupancy(
      id: 'CarParks_800468',
      name: 'Buckhurst Hill Stn (LUL)',
    ),
    CarParkOccupancy(
      id: 'CarParks_800475',
      name: 'Fairlop Stn (LUL)',
    ),
  ];

  final carParks = <Place>[
    Place(
      id: 'CarParks_800491',
      commonName: 'Barkingside Stn (LUL)',
    ),
    Place(
      id: 'CarParks_800468',
      commonName: 'Buckhurst Hill Stn (LUL)',
    ),
    Place(
      id: 'CarParks_800475',
      commonName: 'Fairlop Stn (LUL)',
    ),
  ];

  final disruptions = <Disruption>[
    Disruption(
      categoryDescription: 'PlannedWork',
      description: 'This is a planned work disruption.',
      created: DateTime(2020, 1, 1, 0, 0),
    ),
    Disruption(
      categoryDescription: 'RealTime',
      description: 'This is a real time disruption.',
      created: DateTime(2020, 1, 1, 12, 0),
    ),
  ];

  final lineService = MockLineService();

  final lineStatuses = <LineStatus>[
    LineStatus(
      statusSeverityDescription: 'Good Service',
    ),
    LineStatus(
      statusSeverityDescription: 'Part Closure',
    ),
  ];

  final lines = <Line>[
    Line(
      id: '1',
      name: '1',
      modeName: 'bus',
    ),
    Line(
      id: 'bakerloo',
      name: 'Bakerloo',
      modeName: 'tube',
    ),
  ];

  final matchedRoutes = <MatchedRoute>[
    MatchedRoute(
      name: 'Canada Water - Tottenham Court Road',
      serviceType: 'Regular',
    ),
    MatchedRoute(
      name: 'Tottenham Court Road - Canada Water',
      serviceType: 'Regular',
    ),
  ];

  final occupancyService = MockOccupancyService();

  final placeService = MockPlaceService();

  final predictions = <Prediction>[
    Prediction(
      id: '1',
      destinationName: 'Canada Water',
      expectedArrival: DateTime(2020, 1, 1, 0, 0),
    ),
    Prediction(
      id: '2',
      destinationName: 'Tottenham Court Road',
      expectedArrival: DateTime(2020, 1, 1, 12, 0),
    ),
  ];

  final roadCorridors = <RoadCorridor>[
    RoadCorridor(
      id: 'a1',
      displayName: 'A1',
    ),
    RoadCorridor(
      id: 'a2',
      displayName: 'A2',
    ),
  ];

  final roadService = MockRoadService();

  final routeSequences = <RouteSequence>[
    RouteSequence(
      direction: 'Inbound',
      orderedLineRoutes: <OrderedRoute>[
        OrderedRoute(
          name: 'Inbound Route',
        ),
      ],
    ),
    RouteSequence(
      direction: 'Outbound',
      orderedLineRoutes: <OrderedRoute>[
        OrderedRoute(
          name: 'Outbound Route',
        ),
      ],
    ),
  ];

  final stopPointService = MockStopPointService();

  final stopPoints = <StopPoint>[
    StopPoint(
      naptanId: 'HUBZCW',
      modes: ['bus', 'overground', 'tube'],
      icsCode: '1000037',
      sMSCode: '48366',
      stopType: 'TransportInterchange',
      accessibilitySummary: 'Unknown',
      hubNaptanCode: 'HUBZCW',
      id: '490004733C',
      url: 'Unknown',
      commonName: 'Canada Water',
      placeType: 'StopPoint',
      lat: 51.498053,
      lon: -0.049667,
    ),
    StopPoint(
      naptanId: '940GZZLUTCR',
      modes: ['bus', 'tube'],
      icsCode: '1000235',
      sMSCode: '47657',
      stopType: 'NaptanMetroStation',
      accessibilitySummary: 'Unknown',
      hubNaptanCode: 'Unknown',
      id: '490000235N',
      url: 'Unknown',
      commonName: 'Tottenham Court Road',
      placeType: 'StopPoint',
      lat: 51.516426,
      lon: -0.13041,
    ),
  ];

  final tflApi = MockTflApiClient();

  group('pages', () {
    group('bike_points', () {
      group('BikePointPage', () {
        final bikePoint = bikePoints[0];

        testWidgets('Name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: BikePointPage(bikePoint: bikePoint),
            ),
          );

          expect(
            find.text('Name'),
            findsWidgets,
          );
          expect(
            find.text(bikePoint.commonName!),
            findsWidgets,
          );
        });

        testWidgets('Place type', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: BikePointPage(bikePoint: bikePoint),
            ),
          );

          expect(
            find.text('Place type'),
            findsWidgets,
          );
          expect(
            find.text(bikePoint.placeType!),
            findsWidgets,
          );
        });

        testWidgets('Lat', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: BikePointPage(bikePoint: bikePoint),
            ),
          );

          expect(
            find.text('Lat'),
            findsWidgets,
          );
          expect(
            find.text('${bikePoint.lat}'),
            findsWidgets,
          );
        });

        testWidgets('Lon', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: BikePointPage(bikePoint: bikePoint),
            ),
          );

          expect(
            find.text('Lon'),
            findsWidgets,
          );
          expect(
            find.text('${bikePoint.lon}'),
            findsWidgets,
          );
        });
      });

      group('BikePointsPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: BikePointsPage(),
              ),
            ),
          );
          await tester.pumpAndSettle();

          bikePoints.forEach((bikePoint) {
            expect(
              find.text(bikePoint.id!),
              findsWidgets,
            );
            expect(
              find.text(bikePoint.commonName!),
              findsWidgets,
            );
          });
        });
      });
    });

    group('car_parks', () {
      group('CarParkPage', () {
        final carPark = carParks[0];

        testWidgets('Name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: CarParkPage(carPark: carPark),
            ),
          );

          expect(
            find.text('Name'),
            findsWidgets,
          );
          expect(
            find.text(carPark.commonName!),
            findsWidgets,
          );
        });
      });

      group('CarParksPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: CarParksPage(),
              ),
            ),
          );
          await tester.pumpAndSettle();

          carParks.forEach((carPark) {
            expect(
              find.text(carPark.id!),
              findsWidgets,
            );
            expect(
              find.text(carPark.commonName!),
              findsWidgets,
            );
          });
        });
      });
    });

    group('lines', () {
      group('LineLineDisruptionsPage', () {
        final line = lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineLineDisruptionsPage(line: line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          disruptions.forEach((lineDisruption) {
            expect(
              find.text(lineDisruption.categoryDescription!),
              findsWidgets,
            );
            expect(
              find.text(DateFormat.Hm().format(lineDisruption.created!)),
              findsWidgets,
            );
          });
        });
      });

      group('LineLineRoutesPage', () {
        final line = lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<LineLineRouteFiltersChangeNotifier>(
                  create: (context) {
                    return LineLineRouteFiltersChangeNotifier();
                  },
                ),
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineLineRoutesPage(line: line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          matchedRoutes.forEach((lineRoute) {
            expect(
              find.text(lineRoute.name!),
              findsWidgets,
            );
            expect(
              find.text(lineRoute.serviceType!),
              findsWidgets,
            );
          });
        });
      });

      group('LineLineStatusesPage', () {
        final line = lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineLineStatusesPage(line: line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          lineStatuses.forEach((lineStatus) {
            expect(
              find.text(lineStatus.statusSeverityDescription!),
              findsWidgets,
            );
          });
        });
      });

      group('LinePage', () {
        final line = lines[0];

        testWidgets('Mode name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: LinePage(line: line),
            ),
          );

          expect(
            find.text('Mode name'),
            findsWidgets,
          );
          expect(
            find.text(line.modeName!),
            findsWidgets,
          );
        });

        testWidgets('Name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: LinePage(line: line),
            ),
          );

          expect(
            find.text('Name'),
            findsWidgets,
          );
          expect(
            find.text(line.name!),
            findsWidgets,
          );
        });
      });

      group('LinePredictionsPage', () {
        final line = lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<LinePredictionFiltersChangeNotifier>(
                  create: (context) {
                    return LinePredictionFiltersChangeNotifier();
                  },
                ),
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: LinePredictionsPage(line: line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          predictions.forEach((prediction) {
            expect(
              find.text(prediction.id!),
              findsWidgets,
            );
            expect(
              find.text(
                '${DateFormat.Hm().format(prediction.expectedArrival!)} - ${prediction.destinationName}',
              ),
              findsWidgets,
            );
          });
        });
      });

      group('LineRouteSequencesPage', () {
        final line = lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineRouteSequencesPage(line: line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(
            find.text(routeSequences.first.direction!),
            findsWidgets,
          );
          expect(
            find.text(routeSequences.first.orderedLineRoutes!.first.name!),
            findsWidgets,
          );
        });
      });

      group('LineStopPointsPage', () {
        final line = lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineStopPointsPage(line: line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          stopPoints.forEach((stopPoint) {
            expect(
              find.text(stopPoint.id!),
              findsWidgets,
            );
            expect(
              find.text(stopPoint.commonName!),
              findsWidgets,
            );
          });
        });
      });

      group('LinesPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<LineFiltersChangeNotifier>(
                  create: (context) {
                    return LineFiltersChangeNotifier();
                  },
                ),
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: LinesPage(),
              ),
            ),
          );
          await tester.pumpAndSettle();

          lines.forEach((line) {
            expect(
              find.text(line.id!),
              findsWidgets,
            );
            expect(
              find.text(line.name!),
              findsWidgets,
            );
          });
        });
      });
    });

    group('settings', () {
      group('AboutPage', () {
        setUpAll(() {
          MethodChannel(
            'plugins.flutter.io/package_info',
          ).setMockMethodCallHandler((methodCall) async {
            switch (methodCall.method) {
              case 'getAll':
                return <String, dynamic>{
                  'appName': 'TfL API Explorer',
                  'packageName': 'app.thomasclark.tflapiexplorer',
                  'version': '1.0.0',
                  'buildNumber': '10000'
                };
              default:
                return null;
            }
          });
        });

        testWidgets('Package name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: AboutPage(),
            ),
          );
          await tester.pumpAndSettle();

          expect(
            find.text('Package name'),
            findsWidgets,
          );
          expect(
            find.text('app.thomasclark.tflapiexplorer'),
            findsWidgets,
          );
        });

        testWidgets('Version', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: AboutPage(),
            ),
          );
          await tester.pumpAndSettle();

          expect(
            find.text('Version'),
            findsWidgets,
          );
          expect(
            find.text('1.0.0'),
            findsWidgets,
          );
        });
      });

      group('SettingsPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: SettingsPage(),
            ),
          );

          expect(
            find.text('Account'),
            findsWidgets,
          );
          expect(
            find.text('About'),
            findsWidgets,
          );
        });
      });
    });

    group('roads', () {
      group('RoadPage', () {
        final _road = roadCorridors[0];

        testWidgets('Name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: RoadPage(road: _road),
            ),
          );

          expect(
            find.text('Name'),
            findsWidgets,
          );
          expect(
            find.text(_road.displayName!),
            findsWidgets,
          );
        });
      });

      group('RoadsPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: RoadsPage(),
              ),
            ),
          );
          await tester.pumpAndSettle();

          roadCorridors.forEach((bikePoint) {
            expect(
              find.text(bikePoint.id!),
              findsWidgets,
            );
            expect(
              find.text(bikePoint.displayName!),
              findsWidgets,
            );
          });
        });
      });
    });

    group('stop_points', () {
      group('StopPointPage', () {
        final _stopPoint = stopPoints[0];

        testWidgets('Name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Name'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.commonName!),
            findsWidgets,
          );
        });

        testWidgets('ICS code', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('ICS code'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.icsCode!),
            findsWidgets,
          );
        });

        testWidgets('SMS code', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('SMS code'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.sMSCode!),
            findsWidgets,
          );
        });

        testWidgets('Stop type', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Stop type'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.stopType!),
            findsWidgets,
          );
        });

        testWidgets('Accessibility', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Accessibility'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.accessibilitySummary!),
            findsWidgets,
          );
        });

        testWidgets('Hub NaPTAN code', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Hub NaPTAN code'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.hubNaptanCode!),
            findsWidgets,
          );
        });

        testWidgets('URL', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('URL'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.url!),
            findsWidgets,
          );
        });

        testWidgets('Place type', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Place type'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.placeType!),
            findsWidgets,
          );
        });
      });

      group('StopPointsPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<StopPointFiltersChangeNotifier>(
                  create: (context) {
                    return StopPointFiltersChangeNotifier();
                  },
                ),
                Provider<TflApiClient>.value(
                  value: tflApi,
                ),
              ],
              child: MaterialApp(
                home: StopPointsPage(),
              ),
            ),
          );
          await tester.pumpAndSettle();

          stopPoints.forEach((stopPoint) {
            expect(
              find.text(stopPoint.id!),
              findsWidgets,
            );
            expect(
              find.text(stopPoint.commonName!),
              findsWidgets,
            );
          });
        });
      });
    });

    group('HomePage', () {
      testWidgets('Welcome to the TfL API Explorer', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: HomePage(),
          ),
        );

        expect(
          find.text('Welcome to the TfL API Explorer'),
          findsWidgets,
        );
      });
    });
  });

  setUpAll(() {
    when(bikePointService.getAll()).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => bikePoints,
      );
    });

    when(occupancyService.get()).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => carParkOccupancies,
      );
    });

    when(placeService.getByTypeByPathTypesQueryActiveOnly(['CarPark']))
        .thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => carParks,
      );
    });

    when(lineService.getByModeByPathModes(['bus', 'tube']))
        .thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => lines,
      );
    });
    when(lineService.disruptionByPathIds(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => disruptions,
      );
    });
    when(lineService.lineRoutesByIdsByPathIdsQueryServiceTypes(any))
        .thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => [Line(routeSections: matchedRoutes)],
      );
    });
    when(lineService.statusByIdsByPathIdsQueryDetail(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => [Line(lineStatus: lineStatuses)],
      );
    });
    when(lineService.arrivalsByPathIds(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => predictions,
      );
    });
    when(lineService
            .routeSequenceByPathIdPathDirectionQueryServiceTypesQueryExcludeCrowding(
                any, any))
        .thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => routeSequences.first,
      );
    });
    when(lineService
            .stopPointsByPathIdQueryTflOperatedNationalRailStationsOnly(any))
        .thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => stopPoints,
      );
    });

    when(roadService.get()).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => roadCorridors,
      );
    });

    when(stopPointService.getByTypeByPathTypes(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => stopPoints,
      );
    });

    when(tflApi.bikePoints).thenReturn(bikePointService);
    when(tflApi.occupancies).thenReturn(occupancyService);
    when(tflApi.places).thenReturn(placeService);
    when(tflApi.lines).thenReturn(lineService);
    when(tflApi.roads).thenReturn(roadService);
    when(tflApi.stopPoints).thenReturn(stopPointService);

    when(authenticationChangeNotifier.appKey).thenReturn('abc');
  });
}
