import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:demo_hive_flutter/theme.dart';
import 'package:demo_hive_flutter/widgets/type.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import '../../widgets/widget.dart';

class NewTaskScreen extends StatefulWidget {
  static const routeName = "/NewTaskScreen";
  const NewTaskScreen({ Key? key }) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  int _selectedColor = 0;
  List<String> types = ['Sport', 'Reading', 'Working', 'Sleep', 'Nothing'];
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  // validated() {
  //   if(_keyForm.currentState != null && _keyForm.currentState!.validate()) {
  //     _onFormSubmit();
  //   }
  // }
  
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
                      BuildType(types: types),
                      const BuildTaskDetail(),
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
                const ButtonAction(
                  title: 'Create Task', 
                  bgColor: Colors.black,
                  // call: () {
                  //   validated();
                  // },
                ),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImage() {}
}

class BuildTaskDetail extends StatefulWidget {
  const BuildTaskDetail({ Key? key }) : super(key: key);

  @override
  State<BuildTaskDetail> createState() => _BuildTaskDetailState();
}

class _BuildTaskDetailState extends State<BuildTaskDetail> {
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final formatDate = DateFormat("yyyy-MM-dd");
  final formatTime = DateFormat("HH:mm");
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleField(title: 'Task Detail'),
          MyInputField(
            widget: DateTimeField(
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: formatDate.format(_selectedDate),
                prefixIcon: IconButton(
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
                  widget: DateTimeField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _startTime,
                      prefixIcon: IconButton(
                        onPressed: () => _getTimeFormTask(true), 
                        icon: const Icon(Icons.access_time)
                      )
                    ),
                    controller: _startTimeController,
                    format: formatTime, 
                    onShowPicker: (BuildContext context, DateTime? currentValue) => _getTimeFormTask(true)
                  ),
                ),
              ),
              Expanded(
                child: MyInputField(
                  widget: DateTimeField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _endTime,
                      prefixIcon: IconButton(
                        onPressed: () => _getTimeFormTask(false), 
                        icon: const Icon(Icons.access_time)
                      )
                    ),
                    controller: _endTimeController,
                    format: formatTime, 
                    onShowPicker: (BuildContext context, DateTime? currentValue) => _getTimeFormTask(false)
                  ),
                ),
              ),
            ],
          ),
        ],
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
    ),
  );

  // void _onFormSubmit() {
  //   Box<Task> taskBox = Hive.box<Task>(HiveBoxes.task);
  //   taskBox.add(Task(
  //     title: _titleController.text, 
  //     deadline: formatDate.format(_selectedDate), 
  //     startTime: _startTime, 
  //     endTime: _endTime)
  //   );
  //   Navigator.pushNamed(context, HomeScreen.routeName);
  // }
  _buildTypeDialog() => Container();
}

class BuildType extends StatelessWidget {
  const BuildType({
    Key? key,
    required this.types,
  }) : super(key: key);

  final List<String> types;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleField(title: 'Task Type'),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 10, 
              itemBuilder:(context, index) => Row(
                children: [
                  Expanded(
                    child: TaskType(
                      title: TitleField(title: types.elementAt(index)), 
                      isBgColor: true,
                    ),
                  ),
                ],
              ), 
              itemCount: types.length,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              staggeredTileBuilder: (index) =>const StaggeredTile.count(3, 1.5)
            )
          )
        ],
      ),
    );
  }
}
