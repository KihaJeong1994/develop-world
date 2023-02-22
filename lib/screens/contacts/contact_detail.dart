import 'package:develop_world/model/contacts/contact.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ContactDetail extends StatelessWidget {
  String id;
  Contact contact = Contact(
    id: "1",
    title: "니콜라스 형님 강의들도 부탁드립니다.",
    description: "그짝에도 좋은 강의 많아요!",
    createdBy: "test1",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  ContactDetail({
    super.key,
    required this.id,
  });

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
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black.withOpacity(0.3))),
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
          ),
        ],
      ),
    );
  }
}
