import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubits/BookmarkCubit.dart';
import '../sura_content.dart';

class BookmarksScreen extends StatelessWidget {
  static const routeName = "bookmarks";

  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المفضلة")),
      body: BlocBuilder<BookmarkCubit, BookmarkState>(
        builder: (context, state) {
          if (state.bookmarks.isEmpty) {
            return const Center(child: Text("لا يوجد مفضلة حتى الآن"));
          }
          return ListView.builder(
            itemCount: state.bookmarks.length,
            itemBuilder: (context, index) {
              final suraName = state.bookmarks[index];
              return ListTile(
                title: Text(suraName),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<BookmarkCubit>().removeBookmark(suraName);
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    SuraContent.routeName,
                    arguments: suraName,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
