import 'package:tfl_api_client/tfl_api_client.dart';

import 'filter_change_notifier.dart';

class LinePredictionsFilterChangeNotifier extends FilterChangeNotifier {
  StopPoint _stopPoint;

  StopPoint _destination;

  StopPoint get stopPoint => _stopPoint;

  set stopPoint(StopPoint value) {
    _stopPoint = value;

    notifyListeners();
  }

  StopPoint get destination => _destination;

  set destination(StopPoint value) {
    _destination = value;

    notifyListeners();
  }

  @override
  void reset() {
    _stopPoint = null;
    _destination = null;

    notifyListeners();
  }
}
