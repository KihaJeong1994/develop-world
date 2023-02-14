import 'package:develop_world/model/lecture/lecture.dart';
import 'package:flutter/material.dart';

class LectureSearch extends StatefulWidget {
  Function({String? titleSearch, Site? selectedSite, num? selectedRate})
      onSearchPressed;
  LectureSearch({
    Key? key,
    required this.onSearchPressed,
  }) : super(key: key);

  @override
  State<LectureSearch> createState() => _LectureSearchState();
}

class _LectureSearchState extends State<LectureSearch> {
  String? title;
  Site? site;
  num? rate;
  final titleSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var searchList = [
      SizedBox(
        width: 200,
        height: 30,
        child: TextField(
          controller: titleSearchController,
          onChanged: (text) {
            setState(() {
              title = text;
            });
          },
          decoration: InputDecoration(
            label: Icon(
              Icons.search,
              color: Colors.black.withOpacity(0.1),
            ),
            // labelText: '검색',
          ),
        ),
      ),
      const SizedBox(
        width: 30,
      ),
      DropdownButton(
        value: site,
        items: [
          const DropdownMenuItem(
            value: null,
            child: Text('사이트'),
          ),
          for (var site in Site.values)
            DropdownMenuItem(
              value: site,
              child: Text(site.name),
            ),
        ],
        onChanged: ((value) {
          setState(() {
            site = value;
          });
        }),
        borderRadius: BorderRadius.circular(15),
      ),
      const SizedBox(
        width: 30,
      ),
      DropdownButton(
        value: rate,
        items: [
          const DropdownMenuItem(
            value: null,
            child: Text('별점'),
          ),
          for (var rate in [1, 2, 3, 4, 5])
            DropdownMenuItem(
              value: rate,
              child: Text('$rate 점대'),
            ),
        ],
        onChanged: ((value) {
          setState(() {
            rate = value;
          });
        }),
        borderRadius: BorderRadius.circular(15),
      ),
      const SizedBox(
        width: 30,
      ),
      ElevatedButton(
        onPressed: () {
          widget.onSearchPressed(
            titleSearch: title,
            selectedSite: site,
            selectedRate: rate,
          );
        },
        child: const Text('검색'),
      ),
    ];
    if (MediaQuery.of(context).size.width >= 800) {
      return Row(
        children: searchList,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: searchList.sublist(0, 1),
          ),
          Row(
            children: searchList.sublist(2),
          ),
        ],
      );
    }
  }
}
