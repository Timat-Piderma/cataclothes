import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class CustomSearchBar extends StatefulWidget {
  final Function func;

  const CustomSearchBar({Key? key, required this.func}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      hint: 'Cerca...',
      openAxisAlignment: 0.0,
      height: 40.0,
      width: 600,
      margins: EdgeInsets.fromLTRB(16, 5, 16, 0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      backdropColor: Colors.transparent,
      physics: BouncingScrollPhysics(),
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      debounceDelay: Duration(milliseconds: 500),
      onQueryChanged: (query) {
        widget.func(query);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: true,
          child: CircularButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
          ),
        );
      },
    );
  }
}
