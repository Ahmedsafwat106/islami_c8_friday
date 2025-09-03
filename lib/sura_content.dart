import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_c8_friday/sura_model.dart';

import '../Cubits/sura_details_provider.dart';
import '../Cubits/BookmarkCubit.dart';

class SuraContent extends StatefulWidget {
  static const String routeName = "suracontent";

  const SuraContent({super.key});

  @override
  State<SuraContent> createState() => _SuraContentState();
}

class _SuraContentState extends State<SuraContent> {
  late SuraModel args;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs = ModalRoute.of(context)!.settings.arguments;
    if (routeArgs is SuraModel) {
      args = routeArgs;
      final suraCubit = context.read<SuraDetailsCubit>();
      suraCubit.loadFile(args.index);
    } else {
      Future.microtask(() => Navigator.pop(context));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _verseId(int verseIndex) => 'sura:${args.index}:$verseIndex';

  TextSpan _highlightTextSpan(String text, String query, TextStyle baseStyle, TextStyle highlightStyle) {
    if (query.trim().isEmpty) {
      return TextSpan(text: text, style: baseStyle);
    }
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final children = <TextSpan>[];
    int start = 0;
    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index < 0) {
        children.add(TextSpan(text: text.substring(start), style: baseStyle));
        break;
      }
      if (index > start) {
        children.add(TextSpan(text: text.substring(start, index), style: baseStyle));
      }
      children.add(TextSpan(text: text.substring(index, index + lowerQuery.length), style: highlightStyle));
      start = index + lowerQuery.length;
    }
    return TextSpan(children: children);
  }

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = Theme.of(context).textTheme.bodySmall ?? const TextStyle(fontSize: 16);
    final highlightStyle = baseTextStyle.copyWith(backgroundColor: Colors.yellow.withOpacity(0.5));

    return BlocBuilder<SuraDetailsCubit, SuraDetailsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Theme.of(context).brightness == Brightness.light
                    ? "assets/images/main_bg.png"
                    : "assets/images/dark_main_bg.png",
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(args.suraName, style: Theme.of(context).textTheme.titleSmall),
              actions: [
                IconButton(
                  tooltip: "الذهاب لآخر قراءة",
                  icon: const Icon(Icons.bookmark_added),
                  onPressed: () {
                    final bookmarkState = context.read<BookmarkCubit>().state;
                    final last = bookmarkState.lastRead;
                    if (last != null && last['type'] == 'sura' && last['index'] == args.index) {
                      final verseIdx = last['verse'] as int? ?? 0;
                      _showJumpToVerseDialog(context, verseIdx);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("لا يوجد آخر قراءة لهذه السورة")),
                      );
                    }
                  },
                )
              ],
            ),
            body: Builder(builder: (_) {
              if (state is SuraDetailsLoading || state is SuraDetailsInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SuraDetailsError) {
                return Center(child: Text("خطأ: ${state.message}"));
              } else if (state is SuraDetailsLoaded) {
                final allEntries = state.verses.asMap().entries.toList();
                final filtered = _query.trim().isEmpty
                    ? allEntries
                    : allEntries.where((e) => e.value.toLowerCase().contains(_query.toLowerCase())).toList();

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  elevation: 12,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    children: [
                      // Search bar
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (v) => setState(() => _query = v),
                          decoration: InputDecoration(
                            hintText: "ابحث داخل السورة...",
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _query.isNotEmpty
                                ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                            )
                                : null,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),

                      if (_query.trim().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("${filtered.length} نتيجة"),
                          ),
                        ),

                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          separatorBuilder: (context, index) => Divider(
                            endIndent: 40,
                            indent: 40,
                            thickness: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, idx) {
                            final entry = filtered[idx];
                            final verseIndex = entry.key;
                            final verseText = entry.value;
                            final id = _verseId(verseIndex);
                            final isBookmarked = context.watch<BookmarkCubit>().isBookmarked(id);

                            return ListTile(
                              title: Directionality(
                                textDirection: TextDirection.rtl,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: _highlightTextSpan(verseText, _query, baseTextStyle, highlightStyle),
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                  color: isBookmarked ? Theme.of(context).primaryColor : null,
                                ),
                                onPressed: () {
                                  final cubit = context.read<BookmarkCubit>();
                                  if (isBookmarked) {
                                    cubit.removeBookmark(id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("أزيلت من المفضلة")),
                                    );
                                  } else {
                                    cubit.addBookmark(id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("أضيفت إلى المفضلة")),
                                    );
                                  }
                                },
                              ),
                              onTap: () {
                                context.read<BookmarkCubit>().setLastRead({
                                  'type': 'sura',
                                  'index': args.index,
                                  'verse': verseIndex,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("تم حفظ آخر قراءة")),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
        );
      },
    );
  }

  void _showJumpToVerseDialog(BuildContext context, int verseIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("آخر قراءة"),
          content: Text("هل تريد الذهاب إلى الآية رقم ${verseIndex + 1}?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("الانتقال إلى الآية ${verseIndex + 1}")),
                );
              },
              child: const Text("اذهب"),
            ),
          ],
        );
      },
    );
  }
}
