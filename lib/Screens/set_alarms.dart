import 'package:alarm_app/services/notification_services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime alarmTime = DateTime.now();
  late TextEditingController _alarmMessage;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _alarmMessage = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Set Alarm"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: DateTimePicker(
                type: DateTimePickerType.dateTime,
                initialValue: DateTime.now().toString(),
                initialDate: DateTime.now(),
                initialTime: TimeOfDay.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Choose Alarm Date & Time',
                onChanged: (val) {
                  print(val);
                  DateTime parseDate = DateTime.parse(val);
                  setState(() {
                    alarmTime = parseDate;
                  });
                  print(parseDate.microsecondsSinceEpoch);
                },
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _alarmMessage,
                decoration: InputDecoration(hintText: "Alarm Message"),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  NotificationService()
                      .sendinfuture(alarmTime, _alarmMessage.text)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        content: new Text("Alarm Set for $alarmTime")));
                  });
                },
                child: Text("Set Alarm"))
          ],
        ),
      ),
    );
  }
}
