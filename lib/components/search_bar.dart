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
        boxShadow: [
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
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onSubmitted: (String input) {
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
