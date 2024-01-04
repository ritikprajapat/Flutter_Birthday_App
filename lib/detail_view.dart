import 'package:birthday_app/birthday.dart';
import 'package:birthday_app/timer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final nameTextEditingController = TextEditingController();
  final dobTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: nameTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: dobTextEditingController,
                keyboardType: TextInputType.datetime,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                ],
                decoration: InputDecoration(
                  counterText: '',
                  hintText: 'DOB',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your DOB';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Birthday birthday = Birthday(
                        name: nameTextEditingController.text,
                        dob: dobTextEditingController.text,
                      );
                      Navigator.popUntil(context, (route) => true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerView(
                            birthday: birthday,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
