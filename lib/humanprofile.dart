import 'dart:async'; // new

import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:intl/intl.dart';

class HumanCompleteForm extends StatefulWidget {
  const HumanCompleteForm({Key? key}) : super(key: key);

  @override
  State<HumanCompleteForm> createState() {
    return _HumanCompleteFormState();
  }
}

class _HumanCompleteFormState extends State<HumanCompleteForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _emailHasError = false;
  bool _nameHasError = false;
  bool _phoneHasError = false;
  bool _birthdayHasError = false;

  String viewname = ' ';
  String viewemail = ' ';
  String viewbirthday = ' ';
  String viewphone = ' ';

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('개인 프로필')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Icon(
                  Icons.face,
                  color: Color.fromARGB(255, 24, 7, 7),
                  size: 100,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('name'),
                          ]),
                      Row(children: <Widget>[
                        Text('birthday'),
                      ]),
                      Row(children: <Widget>[
                        Text('email'),
                      ]),
                      Row(children: <Widget>[
                        Text('phone number'),
                      ])
                    ]),
                SizedBox(width: 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(viewname),
                          ]),
                      Row(children: <Widget>[
                        Text(viewbirthday),
                      ]),
                      Row(children: <Widget>[
                        Text(viewemail),
                      ]),
                      Row(children: <Widget>[
                        Text(viewphone),
                      ])
                    ])
              ]),
              SizedBox(height: 30),
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                  debugPrint('there');
                  viewname =
                      _formKey.currentState!.fields['name']!.value.toString();
                  viewphone =
                      _formKey.currentState!.fields['phone']!.value.toString();
                  viewemail =
                      _formKey.currentState!.fields['email']!.value.toString();
                  viewbirthday = _formKey
                      .currentState!.fields['birthday']!.value
                      .toString();
                 
                  debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,
                // ignore: prefer_const_literals_to_create_immutables
                initialValue: const <String, dynamic>{
                  'name': '',
                  'birthday': '',
                  'email': '',
                  'phone': ''
                },
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'name',
                      decoration: InputDecoration(
                        labelText: 'Name',
                        suffixIcon: _nameHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _nameHasError = !(_formKey
                                  .currentState?.fields['name']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderDateTimePicker(
                      name: 'birthday',
                      initialEntryMode: DatePickerEntryMode.calendar,
                      initialValue: DateTime.now(),
                      inputType: InputType.date,
                      decoration: InputDecoration(
                        labelText: 'BirthDay',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['birthday']
                                ?.didChange(null);
                          },
                        ),
                      ),

                      // locale: const Locale.fromSubtags(languageCode: 'fr'),
                    ),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'email',
                      decoration: InputDecoration(
                        labelText: 'Email',
                        suffixIcon: _emailHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _emailHasError = !(_formKey
                                  .currentState?.fields['email']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email()
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'phone',
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        suffixIcon: _nameHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _nameHasError = !(_formKey
                                  .currentState?.fields['phone']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          debugPrint('here');
                          debugPrint(_formKey.currentState?.value.toString());
                           addMessageToUserListBook(
                              viewname, viewphone, viewemail, viewbirthday);
                        } else {
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('validation failed');
                        }
                      },
                      child: const Text(
                        'Profile Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      // color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<DocumentReference> addMessageToUserListBook(
    String name, String phone, String email, String birthday) {
  return FirebaseFirestore.instance
      .collection('userlist')
      .add(<String, dynamic>{
    'name': name,
    'phone': phone,
    'email': email,
    'birthday': birthday,
  });
}
