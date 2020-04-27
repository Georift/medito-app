/*This file is part of Medito App.

Medito App is free software: you can redistribute it and/or modify
it under the terms of the Affero GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Medito App is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
Affero GNU General Public License for more details.

You should have received a copy of the Affero GNU General Public License
along with Medito App. If not, see <https://www.gnu.org/licenses/>.*/

import 'package:Medito/tracking/tracking.dart';
import 'package:Medito/widgets/pill_utils.dart';
import 'package:flutter/material.dart';

import '../viewmodel/list_item.dart';

class NavPillsWidget extends StatefulWidget {
  const NavPillsWidget({Key key, this.list, this.backPressed}) : super(key: key);

  final List<ListItem> list;
  final ValueChanged<String> backPressed;

  @override
  _NavPillsWidgetState createState() => new _NavPillsWidgetState();
}

class _NavPillsWidgetState extends State<NavPillsWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: getPills(),
      ),
    );
  }

  List<Widget> getPills() {
    List<Widget> columns = new List<Widget>();
    if (widget.list == null) return columns;

    int startNumber = 0;
    if (widget.list.length >= 2) {
      startNumber = widget.list.length - 2;
    }
    for (int i = startNumber; i < widget.list.length; i++) {
      var label = widget.list[i].title;
      if (widget.list.length > 1 && i == startNumber) {
        label = "← " + label;
      }

      columns.add(GestureDetector(
          onTap: () {
            Tracking.trackEvent(Tracking.BREADCRUMB, Tracking.BREADCRUMB_TAPPED,
                widget.list.last?.id);

            if (i == startNumber)
              widget.backPressed(widget.list[i].id);
          },
          child: AnimatedContainer(
            margin: EdgeInsets.only(top: i == startNumber ? 0 : 8),
            padding: getEdgeInsets(i, startNumber),
            decoration: getBoxDecoration(i, startNumber),
            duration: Duration(days: 1),
            child: getTextLabel(label, i, startNumber, context),
          )));
    }

    return columns;
  }
}
