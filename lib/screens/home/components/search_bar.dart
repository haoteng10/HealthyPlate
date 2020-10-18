import "package:flutter/material.dart";
import "package:nutrition/constants.dart";

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: kShadowColor,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 5),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.search),
                hintText: "Search for recipes",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onChanged: (String input) {
                // Either set the state or bring up search results on separate route
                setState(() {
                  searchText = input;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
