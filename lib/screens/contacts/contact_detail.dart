import 'package:develop_world/model/contacts/contact.dart';
import 'package:develop_world/services/contact/contact_api_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class ContactDetail extends StatefulWidget {
  String id;

  ContactDetail({
    super.key,
    required this.id,
  });

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  late Future<Contact> contactFuture;
  @override
  void initState() {
    super.initState();
    contactFuture = ContactApiService.getContactDetailById(widget.id);
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
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
          FutureBuilder(
              future: contactFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Contact contact = snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.3))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                contact.createdBy,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                timeago.format(contact.updatedAt, locale: 'kr'),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 0,
                            thickness: 0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            contact.description,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
