import 'package:develop_world/model/page_object.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/services/contact/contact_api_service.dart';
import 'package:develop_world/widgets/contacts/contact_item.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  late Future<PageObject> pageContactFuture;
  final titleController = TextEditingController();
  String? title;
  String? description;
  String? createdBy;
  int page = 0;
  @override
  void initState() {
    super.initState();
    pageContactFuture = ContactApiService.searchContacts(
      title: title,
      description: description,
      createdBy: createdBy,
      page: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '문의',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: (() {
                    navKey.currentState!.pushNamed(routeWriteContact);
                  }),
                  child: const Text('쓰기'),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: pageContactFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            clipBehavior: Clip.hardEdge,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ContactItem(
                                    contact: snapshot.data!.content[index]);
                              },
                              separatorBuilder: (c, i) => const Divider(
                                height: 0,
                                thickness: 0,
                              ),
                              itemCount: snapshot.data!.content.length,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            for (int i = 1; i <= snapshot.data!.totalPages; i++)
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('$i'),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  )
                                ],
                              ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      title = titleController.text;
                      pageContactFuture =
                          ContactApiService.searchContacts(title: title);
                    });
                  },
                  child: const Text('검색'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
