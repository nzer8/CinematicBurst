import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    Key? key,
    this.onSubmitted,
    required this.onChanged,
  }) : super(key: key);
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'search',
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: const Opacity(
            opacity: .8,
            child: Icon(
              Icons.search_sharp,
              size: 22,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(15),
    );
  }
}
