import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:intl/intl.dart';
import 'package:sql_demo/utils/constant.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({super.key});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTimeRange? selectDateRange;

  void _showDate() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      // initialDateRange: selectDateRange,
      firstDate: DateTime(2022, 10, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      print(result.start.toString());

      setState(() {
        selectDateRange = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final dateStart = selectDateRange?.start;
    //final dateEnd = selectDateRange?.end;
    // final datelineResult = selectDateRange?.duration;
    //final txtStart = DateFormat('dd/MM/yyyy').format(dateStart!);
    // final txtEnd = DateFormat('dd/MM/yyyy').format(dateEnd!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Date Range Picker',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: selectDateRange == null
          ? const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Press the button to show the choice picker!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primaryColor, fontSize: 24),
                ),
              ),
            )
          : SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Start date: ${DateFormat('dd/MM/yyyy').format(selectDateRange!.start)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "End date: ${DateFormat('dd/MM/yyyy').format(selectDateRange!.end)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Dateline: ${selectDateRange!.duration.inDays} days',
                    style: const TextStyle(
                        color: primaryColor, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectDateRange = null;
                      });
                    },
                    child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.delete,
                            color: Colors.white,
                            size: 28,
                          ),
                        )),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDate();
        },
        child: const Icon(Icons.date_range),
      ),
    );
  }
}
