import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkState {
  final List<String> bookmarks; // e.g. ['sura:2:5', 'hadeth:10']
  final Map<String, dynamic>? lastRead; // e.g. {'type':'sura','index':2,'verse':5}

  BookmarkState({required this.bookmarks, this.lastRead});

  BookmarkState copyWith({
    List<String>? bookmarks,
    Map<String, dynamic>? lastRead,
  }) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      lastRead: lastRead ?? this.lastRead,
    );
  }
}

class BookmarkCubit extends Cubit<BookmarkState> {
  static const _bookmarksKey = 'bookmarks';
  static const _lastReadKey = 'last_read';

  BookmarkCubit() : super(BookmarkState(bookmarks: []));

  // تحميل المفضلة من SharedPreferences
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_bookmarksKey) ?? [];
    final lastRaw = prefs.getString(_lastReadKey);
    Map<String, dynamic>? last;
    if (lastRaw != null) {
      try {
        last = jsonDecode(lastRaw) as Map<String, dynamic>;
      } catch (_) {}
    }
    emit(BookmarkState(bookmarks: saved, lastRead: last));
  }

  bool isBookmarked(String id) {
    return state.bookmarks.contains(id);
  }

  Future<void> addBookmark(String id) async {
    if (state.bookmarks.contains(id)) return;
    final updated = List<String>.from(state.bookmarks)..add(id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_bookmarksKey, updated);
    emit(state.copyWith(bookmarks: updated));
  }

  Future<void> removeBookmark(String id) async {
    final updated = List<String>.from(state.bookmarks)..removeWhere((e) => e == id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_bookmarksKey, updated);
    emit(state.copyWith(bookmarks: updated));
  }

  Future<void> setLastRead(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastReadKey, jsonEncode(data));
    emit(state.copyWith(lastRead: data));
  }
}
