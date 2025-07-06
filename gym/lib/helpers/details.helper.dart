import 'package:flutter/material.dart';
import 'package:gym/models/studio/studio.dart';
import 'package:gym/widgets/barchart.dart';

class StudioDetails extends StatelessWidget {
  final Studio studio;
  final String theme;
  final VoidCallback onTap;

  const StudioDetails({
    super.key,
    required this.studio,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = now.weekday - 1;

    makeXList(from, until) {
      final fromTime = int.parse(from.substring(0, 2));
      final untilTime = int.parse(until.substring(0, 2));
      return List.generate(untilTime - fromTime + 1, (index) {
        final hour = fromTime + index;
        return hour.toString().padLeft(2, '0');
      });
    }

    makeYList(List list) =>
        list.map((item) => (item as num).toDouble()).toList();

    List<String> weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              studio.name,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (studio.news != null) Text('${studio.news}'),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        weekdays[index],
                        style: TextStyle(
                          fontWeight: index == today ? FontWeight.bold : null,
                        ),
                      ),
                      Text(
                        studio.openingHours[weekdays[index].toLowerCase()] !=
                                null
                            ? '${studio.openingHours[weekdays[index].toLowerCase()]?.from} - ${studio.openingHours[weekdays[index].toLowerCase()]?.until}'
                            : 'Closed',
                        style: TextStyle(
                          fontWeight: index == today ? FontWeight.bold : null,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            if (studio.openingHours[weekdays[today].toLowerCase()] != null)
              SizedBox(
                height: 110,
                child: DetailsBarChart(
                  xAxisList: makeXList(
                    studio.openingHours[weekdays[today].toLowerCase()]!.from,
                    studio.openingHours[weekdays[today].toLowerCase()]!.until,
                  ),
                  yAxisList: makeYList(
                    studio
                        .openingHours[weekdays[today].toLowerCase()]!
                        .occupancies!,
                  ),
                  theme: theme,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
