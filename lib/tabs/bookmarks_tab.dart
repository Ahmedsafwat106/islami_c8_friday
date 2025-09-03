import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubits/BookmarkCubit.dart';
import '../sura_model.dart';
import '../sura_content.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        final bookmarks = state.bookmarks;
        if (bookmarks.isEmpty) {
          return const Center(
            child: Text(
              "لم تضف أي مفضلة بعد",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final id = bookmarks[index];
            final parts = id.split(':');

            String title = '';
            String subtitle = '';
            VoidCallback? onTap;

            if (parts[0] == 'sura') {
              final suraIndex = int.tryParse(parts[1]) ?? 0;
              final verseIndex = int.tryParse(parts[2]) ?? 0;
              title = "سورة ${suraIndex + 1}";
              subtitle = "الآية ${verseIndex + 1}";
              onTap = () {
                Navigator.pushNamed(
                  context,
                  SuraContent.routeName,
                  arguments: SuraModel("سورة ${suraIndex + 1}", suraIndex),
                );
              };
            } else if (parts[0] == 'hadeth') {
              final hadethIndex = int.tryParse(parts[1]) ?? 0;
              title = "حديث رقم ${hadethIndex + 1}";
              subtitle = "";
              // هنا ممكن تضيف التنقل للحديث إذا عندك صفحة HadethContent
            }

            return ListTile(
              title: Text(title),
              subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<BookmarkCubit>().removeBookmark(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم الحذف من المفضلة")),
                  );
                },
              ),
              onTap: onTap,
            );
          },
        );
      },
    );
  }
}
