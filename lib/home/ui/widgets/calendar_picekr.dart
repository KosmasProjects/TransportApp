import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarPicker extends StatefulWidget {
  final TextEditingController controller;
  final DateTime dateTime;
  const CalendarPicker(
      {super.key, required this.controller, required this.dateTime});

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: TextField(
                controller: widget.controller,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    size: 20,
                  ), //icon of text field
                  labelText: "Head Out Date",
                  //label text of field
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat.yMMMMd('en_US').format(pickedDate);

                    // dateTime = pickedDate;
                    //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      widget.controller.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                })),
      ),
    );
  }
}
