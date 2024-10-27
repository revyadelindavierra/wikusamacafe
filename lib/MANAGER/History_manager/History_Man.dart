import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:wikusamacafe/History/Succes.dart';
import 'package:wikusamacafe/History/failed.dart';

class TransactionMan extends StatefulWidget {
  const TransactionMan({super.key});

  @override
  _TransactionManState createState() => _TransactionManState();
}

class _TransactionManState extends State<TransactionMan> {
  String dateFilter = ""; // Variable to store selected date

  Future<void> _selectDate(BuildContext context) async {
    var values = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
      ),
      dialogSize: const Size(325, 400),
      value: [],
      borderRadius: BorderRadius.circular(15),
    );

    if (values != null && values.isNotEmpty && values[0] != null) {
      setState(() {
        dateFilter = "${values[0]?.day}-${values[0]?.month}-${values[0]?.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF016042),
          title: const Center(
            child: Text(
              "Transaction History",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Success',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Tab(
                child: Text(
                  'Failed',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                readOnly: true, // Disable manual input
                onTap: () => _selectDate(context), // Trigger date picker on tap
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Date - Month - Year',
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: dateFilter.isEmpty
                      ? 'e.g. 22-09-2024'
                      : dateFilter, // Show selected date
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF016042)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SuccessTransactions(dateFilter: dateFilter),
                  const FailedTransactions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
