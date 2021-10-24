import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;
  int index;
  bool isList;
  bool isGrid;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            // alignment: Alignment.centerRight,
            child: IconButton(
                icon: Image.asset(
                  'assets/icons/listview.png',
                  //color: Colors.purple.shade100,
                  color: selectedIndex == index ? Colors.grey : Colors.orange,
                ),
                onPressed: () {
                  setState(() {});
                }),
          ),
          Align(
            //alignment: Alignment.centerRight,
            child: IconButton(
                icon: Image.asset(
                  'assets/icons/gridview.png',
                  // color: Colors.deepOrange,
                  color: selectedIndex == index ? Colors.grey : Colors.orange,
                ),
                onPressed: () {
                  setState(() {});
                }),
          ),
        ],
      ),
    );
  }
}
