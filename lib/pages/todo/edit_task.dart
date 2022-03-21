import 'package:demo_hive_flutter/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class TaskEditScreen extends StatefulWidget {
  static const routeName = '/TaskEditScreen';
  const TaskEditScreen({ Key? key }) : super(key: key);

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        child: CustomAppbar(
          leadingIcon: 'assets/images/ic_callBack.png', 
          title: 'Task Editing',
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
          )
        ),
      ),
    );
  }
}