import 'package:flutter/material.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/services/logger.dart';
import 'package:resonate/utils/time.dart';

class LoggingComponent extends StatefulWidget {
  /* Logging Component 

    Shows the application logs (at least my ones) 
    to the user, used for debugging. 
  */
  const LoggingComponent({super.key});

  @override
  State<LoggingComponent> createState() => _LoggingComponentState();
}

class _LoggingComponentState extends State<LoggingComponent> {
  String levelFilter = 'ALL';

  @override
  Widget build(BuildContext context) {
    print('build');
    var logger = AppLogger.instance;
    var entries = logger.entries;
    if (levelFilter != 'ALL') {
      entries = logger.entries.where((e) => e.level == levelFilter).toList();
    }
    var len = entries.length;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Logging'),
          actions: [
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  logger.clear();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.sync),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),

        body: Column(
          children: [
            DropdownButton<String>(
              items:
                  logger.levels.map((level) {
                    return DropdownMenuItem(value: level, child: Text(level));
                  }).toList(),
              value: levelFilter,
              onChanged: (value) {
                setState(() {
                  levelFilter = value ?? 'ALL';
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: len,
                itemBuilder: (context, index) {
                  var entry = entries[len - 1 - index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Text(entry.level),
                        title: Text('${entry.loggerName}: ${entry.timestamp}'),
                        subtitle: ExpandableTextComponent(text: entry.message),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
