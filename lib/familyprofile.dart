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

class FamilyCompleteForm extends StatefulWidget {
  const FamilyCompleteForm({Key? key}) : super(key: key);

  @override
  State<FamilyCompleteForm> createState() {
    return _FamilyCompleteFormState();
  }
}

class _FamilyCompleteFormState extends State<FamilyCompleteForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _emailHasError = false;
  bool _nameHasError = false;

  String viewfamily = ' ';
  String viewmembers = ' ';
  String viewowner = 'terry ';
  String viewfammood = 'normal';

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('패밀리 설정')),
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
                            Text('family'),
                          ]),
                      Row(children: <Widget>[
                        Text('owner'),
                      ]),
                      Row(children: <Widget>[
                        Text('members'),
                      ]),
                    ]),
                SizedBox(width: 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(viewfamily),
                          ]),
                      Row(children: <Widget>[
                        Text(viewowner),
                      ]),
                      Row(children: <Widget>[
                        Text(viewmembers),
                      ]),
                    ])
              ]),
              SizedBox(height: 30),
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                  debugPrint('there');
                  viewfamily =
                      _formKey.currentState!.fields['family']!.value.toString();
                  //    viewowner =
                  //       _formKey.currentState!.fields['owner']!.value.toString();
                  viewmembers = _formKey.currentState!.fields['members']!.value
                      .toString();

                  debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,
                // ignore: prefer_const_literals_to_create_immutables
                initialValue: const <String, dynamic>{
                  'family': '',
                  'owner': 'terry',
                  'members': '',
                },
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'family',
                      decoration: InputDecoration(
                        labelText: 'Name',
                        suffixIcon: _nameHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _nameHasError = !(_formKey
                                  .currentState?.fields['family']
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
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'members',
                      decoration: InputDecoration(
                        labelText: 'Members',
                        suffixIcon: _emailHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _emailHasError = !(_formKey
                                  .currentState?.fields['members']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.emailAddress,
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
                          addMessageToFamilyBook(
                              viewfamily, viewmembers, viewowner);
                        } else {
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('validation failed');
                        }
                      },
                      child: const Text(
                        'Add Family',
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

Future<DocumentReference> addMessageToFamilyBook(
    String family, String member, String owner) {
  return FirebaseFirestore.instance
      .collection('familybook')
      .add(<String, dynamic>{
    'family': family,
    'owner': owner,
    'member': member,
    'fammood': 'normal',
  });
}
