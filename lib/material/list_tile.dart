import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart' as tflApiClient;
import 'package:tfl_api_explorer/pages/line_page.dart';

import '../widgets/text.dart';

class LineListTile extends ListTile {
  LineListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.Line line,
  }) : super(
          key: key,
          title: NullableText(
            line.id,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            line.name,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              LinePage.route,
              arguments: line.id,
            );
          },
        );
}

class StopPointListTile extends ListTile {
  StopPointListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.StopPoint stopPoint,
  }) : super(
          key: key,
          title: NullableText(
            stopPoint.id,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            stopPoint.commonName,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            /*Navigator.of(context).pushNamed(
              StopPointPage.route,
              arguments: stopPoint.id,
            );*/
          },
        );
}
