import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  SearchField({this.onSearch, Key? key}) : super(key: key);

  final controller = TextEditingController();
  final Function(String value)? onSearch;
  static final _forKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              child: Ink(
                child: InkWell(
                  onTap: () {
                    //Route to search page!
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                        width: 0.4,
                      ),
                    ),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Search"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // Form(
    //   key: _forKey,
    //   child: TextField(
    //     controller: controller,
    //     decoration: InputDecoration(
    //       filled: true,
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //         borderSide: BorderSide.none,
    //       ),
    //       prefixIcon: const Icon(EvaIcons.search),
    //       hintText: "search..",
    //       isDense: true,
    //       fillColor: Theme.of(context).cardColor,
    //     ),
    //     onEditingComplete: () {
    //       FocusScope.of(context).unfocus();
    //       if (onSearch != null) onSearch!(controller.text);
    //     },
    //     onSubmitted: (value) {
    //       // FocusScope.of(context).unfocus();
    //       // FocusScope.of(context).requestFocus(new FocusNode());
    //     },
    //     textInputAction: TextInputAction.search,
    //     style: TextStyle(color: kFontColorPallets[1]),
    //   ),
    // );
  }
}
