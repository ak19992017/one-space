import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

List<String> listOfMonths = [
  "January",
  "Februrary",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

class OneCalender extends StatefulWidget {
  const OneCalender({super.key});

  @override
  State<OneCalender> createState() => _OneCalenderState();
}

class _OneCalenderState extends State<OneCalender> {
  DateTime selectedDate = DateTime.now();

  int currentMonthSelected = DateTime.now().month;
  int currentDateSelectedIndex = 0;
  int currentDay = DateTime.now().day;
  int currentMonth = DateTime.now().month;
  int currentWeekday = DateTime.now().weekday;
  int currentYear = DateTime.now().year;
  int checkLeapYear(int year) {
    // If a year is multiple of 400,
    // then it is a leap year
    if (year % 400 == 0) {
      return 1;
    }

    // Else If a year is multiple of 100,
    // then it is not a leap year
    if (year % 100 == 0) {
      return 0;
    }

    // Else If a year is multiple of 4,
    // then it is a leap year
    if (year % 4 == 0) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = (currentMonth == 2)
        ? (28 + checkLeapYear(currentYear))
        : 31 - (currentMonth - 1) % 7 % 2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(EvaIcons.minus),
              onPressed: () => setState(() => currentMonthSelected -= 1),
            ),
            Text(
              listOfMonths[(currentMonthSelected - 1) % 12],
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(EvaIcons.plus),
              onPressed: () {
                setState(() {
                  currentMonthSelected += 1;
                  daysInMonth;
                });
              },
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7),
            itemCount: 7,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    listOfDays[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    currentDateSelectedIndex = index;

                    selectedDate = DateTime.now().add(Duration(days: index));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: currentDay - 1 == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
