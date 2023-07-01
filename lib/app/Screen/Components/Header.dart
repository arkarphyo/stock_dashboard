import 'package:flutter/material.dart';

import 'SearchField.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SearchField(
          onSearch: (value) {},
        )),
      ],
    );
  }
}
