import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  Function searchItem;
  TextEditingController searchController;
  SearchBarWidget(this.searchItem,this.searchController);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SearchBar(
        controller: widget.searchController,
        hintText: "Search Entry",
        onSubmitted: (value){

          widget.searchItem();
        },
        leading: IconButton(icon: Icon(Icons.search),onPressed: (){

          widget.searchItem();
        },),
      ),
    );
  }
}
