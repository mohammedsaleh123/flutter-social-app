import 'package:flutter/material.dart';
import 'package:socialapp/core/widgets/custom_text.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Search'),
      ),
      body: const Column(),
    );
  }
}
