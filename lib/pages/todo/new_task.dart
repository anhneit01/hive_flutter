import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:demo_hive_flutter/boxes.dart';
import 'package:demo_hive_flutter/pages/home/home_screen.dart';
import 'package:demo_hive_flutter/theme.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../models/task.dart';
import '../../widgets/widget.dart';

class NewTaskScreen extends StatefulWidget {
  static const routeName = "/NewTaskScreen";
  const NewTaskScreen({ Key? key }) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final formatDate = DateFormat("yyyy-MM-dd");
  final formatTime = DateFormat("HH:mm");
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedColor = 0;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  validated() {
    if(_keyForm.currentState != null && _keyForm.currentState!.validate()) {
      _onFormSubmit();
      print('Sucess');
    } else {
      print("Failed");
      return;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        child: CustomAppbar(
          leadingIcon: 'assets/images/ic_callBack.png', 
          title: 'New Task',
          hasRightIcon: false, 
          rightIcon: '',
          leftCallback: () => Navigator.pop(context),
        ), 
        preferredSize: const Size.fromHeight(80.0)
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      MyInputField(
                        title: 'My New Task', 
                        widget: TextFormField(
                          controller: _titleController,
                          textCapitalization: TextCapitalization.words,
                          validator: (String? value) {
                            if(value == null || value.trim().isEmpty) {
                              return 'Required';
                            } 
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter your task',
                          ),
                        )
                      ),
                      MyInputField(
                        title: 'Deadline', 
                        widget: DateTimeField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: formatDate.format(_selectedDate),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _getDateFormTask(context);
                              }, 
                              icon: const AppIcon(
                                iconPath: 'assets/images/ic_calendar.png', 
                                hasText: false
                              )
                            ),
                          ),
                          controller: _dateController,
                          format: formatDate, 
                          onShowPicker: (BuildContext context, DateTime? currentValue) => _getDateFormTask(context)
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyInputField(
                              title: 'Start Time', 
                              widget: DateTimeField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: _startTime,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _getTimeFormTask(true);
                                    }, 
                                    icon: const Icon(Icons.access_alarm)
                                  ),
                                ),
                                controller: _startTimeController,
                                format: formatTime, 
                                onShowPicker: (BuildContext context, DateTime? currentValue) => _getTimeFormTask(true)
                              ),
                              // icon: IconButton(
                              //   onPressed: () {
                              //     _getTimeFormTask(true);
                              //   }, 
                              //   icon: const Icon(Icons.access_alarm)
                              // ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: MyInputField(
                              title: 'End Time', 
                              widget: DateTimeField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: _endTime,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _getTimeFormTask(false);
                                    }, 
                                    icon: const Icon(Icons.access_alarm)
                                  ),
                                ),
                                controller: _endTimeController,
                                format: formatTime, 
                                onShowPicker: (BuildContext context, DateTime? currentValue) => _getTimeFormTask(false)
                              ),
                            ),
                          ),
                        ],
                      ),
                      MyInputField(
                        title: 'Place', 
                        widget: TextFormField(
                          readOnly: true,
                          decoration:  InputDecoration(
                            hintText: 'VietNam',
                            suffixIcon: IconButton(
                              onPressed: () {}, 
                              icon: const AppIcon(
                                iconPath: 'assets/images/ic_place.png', 
                                hasText: false
                              )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Color', style: titleStyle()),
                            const SizedBox(height: 8.0),
                            Wrap(
                              children: List.generate(3, (int index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: index==0 ? Colors.blue : index == 1 ? Colors.green : Colors.red,
                                    child: _selectedColor == index ? const Icon(
                                      Icons.done,
                                      size: 16,
                                      color: Colors.white,
                                    ) : Container()
                                  ),
                                ),
                              ))
                            )
                          ],
                        )
                      ),
                      Expanded(
                        child: ButtonAction(
                          iconData: Icons.file_present_outlined, 
                          title: 'Attach File', 
                          bgColor: Colors.amber,
                          call: () => getImage(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ButtonAction(
                  title: 'Done', 
                  bgColor: Colors.black,
                  call: () {
                    validated();
                  },
                ),
                const Spacer(flex: 2)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getDateFormTask(BuildContext context) async {
    DateTime?  _pickerDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime(2025),
    );
    if(_pickerDate != null && _pickerDate != _selectedDate) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }
  _getTimeFormTask(bool isStartTime) async {
    var pickerTime = await _showTimePicker(context);
    String _formatedTime = pickerTime.format(context);
    if(pickerTime == null) {
      print('Cancel');
    } else if (isStartTime) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }
  _showTimePicker(BuildContext context) => showTimePicker(
    context: context, 
    initialEntryMode: TimePickerEntryMode.input,
    initialTime: TimeOfDay(
      hour: int.parse(_startTime.split(":")[0]), 
      minute: int.parse(_startTime.split(":")[1].split(" ")[0])
    )
  );

  void _onFormSubmit() {
    Box<Task> taskBox = Hive.box<Task>(HiveBoxes.task);
    taskBox.add(Task(
      title: _titleController.text, 
      deadline: formatDate.format(_selectedDate), 
      startTime: _startTime, 
      endTime: _endTime)
    );
    Navigator.pushNamed(context, HomeScreen.routeName);
  }

  getImage() {}
}
