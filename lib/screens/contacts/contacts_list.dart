import 'package:develop_world/model/contacts/contact.dart';
import 'package:develop_world/model/page_object.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/widgets/contacts/contact_item.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  void initState() {
    super.initState();
  }

  final newPage = PageObject.fromJson({
    'content': [
      Contact(
        id: "1",
        title: "니콜라스 형님 강의들도 부탁드립니다.",
        description: "그짝에도 좋은 강의 많아요!",
        createdBy: "test1",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Contact(
        id: "2",
        title: "다른 컨텐츠도 부탁해요",
        description: "강의 리뷰말고 이것저것 부탁",
        createdBy: "test2",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Contact(
        id: "1",
        title: "니콜라스 형님 강의들도 부탁드립니다.",
        description: "그짝에도 좋은 강의 많아요!",
        createdBy: "test1",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Contact(
        id: "1",
        title: "니콜라스 형님 강의들도 부탁드립니다.",
        description: "그짝에도 좋은 강의 많아요!",
        createdBy: "test1",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Contact(
        id: "2",
        title: "다른 컨텐츠도 부탁해요",
        description: "강의 리뷰말고 이것저것 부탁",
        createdBy: "test2",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Contact(
        id: "1",
        title: "니콜라스 형님 강의들도 부탁드립니다.",
        description: "그짝에도 좋은 강의 많아요!",
        createdBy: "test1",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Contact(
        id: "2",
        title: "다른 컨텐츠도 부탁해요",
        description: "강의 리뷰말고 이것저것 부탁",
        createdBy: "test2",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Contact(
        id: "1",
        title: "니콜라스 형님 강의들도 부탁드립니다.",
        description: "그짝에도 좋은 강의 많아요!",
        createdBy: "test1",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Contact(
        id: "2",
        title: "다른 컨텐츠도 부탁해요",
        description: "강의 리뷰말고 이것저것 부탁",
        createdBy: "test2",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Contact(
        id: "2",
        title: "다른 컨텐츠도 부탁해요",
        description: "강의 리뷰말고 이것저것 부탁",
        createdBy: "test2",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ],
    'pageable': {
      'pageNumber': 0,
      'pageSize': 3,
    },
    'first': true,
    'last': false,
    'totalPages': 1,
    'totalElements': 3,
    'size': 3,
  });

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
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black.withOpacity(0.3))),
                clipBehavior: Clip.hardEdge,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ContactItem(contact: newPage.content[index]);
                  },
                  separatorBuilder: (c, i) => const Divider(
                    height: 0,
                    thickness: 0,
                  ),
                  itemCount: newPage.content.length,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                for (int i = 1; i <= 3; i++)
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
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 100,
                  height: 30,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {},
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
