import 'package:develop_world/config/event_bus.dart';
import 'package:develop_world/model/contacts/contact.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/screens/screen_frame.dart';
import 'package:develop_world/services/contact/contact_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactWrite extends StatefulWidget {
  const ContactWrite({super.key});

  @override
  State<ContactWrite> createState() => _ContactWriteState();
}

class _ContactWriteState extends State<ContactWrite> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final descController = TextEditingController();

  late SharedPreferences prefs;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  onSubmitPressed() {
    var contactInstance = Contact(
      id: null,
      title: titleController.text,
      description: descController.text,
      createdBy: prefs.getString('id') ?? '익명',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    ContactApiService.insertContact(contactInstance).then((value) {
      navKey.currentState!.pushNamed(routeContacts);
    }).onError((error, stackTrace) {
      SingleEventBus.singleEventBus.fire(SignOutEvent());
      askToLogin();
    });
  }

  Future<String?> askToLogin() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('로그인을 해주세요'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => navKey.currentState!.pushNamed(routeSignIn),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '문의 작성',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      validator: (val) {
                        if (val == null || val.length < 4) {
                          return "4글자 이상 입력해주세요";
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '제목',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      maxLines: 7,
                      validator: (val) {
                        if (val == null || val.length < 4) {
                          return "4글자 이상 입력해주세요";
                        }
                        return null;
                      },
                      controller: descController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '글',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: onSubmitPressed,
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text(
                          '작성',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
