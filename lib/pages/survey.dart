import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:survey_kit/survey_kit.dart';

class SurveyView extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              FutureBuilder<dynamic>(
                future: getJsonTask(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data != null) {
                    final task = snapshot.data!;
                    List<Widget> questionList = [];
                    print(task);
                    for (var question in task['steps']) {
                      print(question);
                      questionList.add(FormSection(
                        title: question['section'],
                        message: question['title'],
                        question: question['text'],
                        options: const [
                          'Not a Priority',
                          'Low Priority',
                          'Priority',
                          'High Priority',
                          'Critical',
                        ],
                      ));
                    }

                    return Expanded(child: ListView(
                      children: [...questionList],
                    ));
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    // Process the form data
                    print(_formKey.currentState!.value);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getJsonTask() async {
    final String taskJson = await rootBundle.loadString('en.json');
    final Map<String, dynamic> taskMap = json.decode(taskJson);
    return taskMap;
  }
}

class FormSection extends StatefulWidget {
  final String title;
  final String message;
  final String question;
  final List<String> options;

  const FormSection({
    required this.title,
    required this.message,
    required this.question,
    required this.options,
  });

  @override
  _FormSectionState createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.message,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          widget.question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200, // Adjust the height as needed
          child: ListView.builder(
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              final option = widget.options[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedOption = option;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: selectedOption == option
                      ? Colors.blue.withOpacity(0.5)
                      : null,
                  child: Text(option),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
