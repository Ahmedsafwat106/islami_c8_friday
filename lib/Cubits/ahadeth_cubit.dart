import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:islami_c8_friday/hadethModel.dart';

abstract class AhadethState {}

class AhadethInitial extends AhadethState {}

class AhadethLoading extends AhadethState {}

class AhadethLoaded extends AhadethState {
  final List<HadethModel> ahadeth;
  AhadethLoaded(this.ahadeth);
}

class AhadethError extends AhadethState {
  final String message;
  AhadethError(this.message);
}

class AhadethCubit extends Cubit<AhadethState> {
  static const _cacheKey = 'ahadeth_cache';
  AhadethCubit() : super(AhadethInitial());

  Future<void> loadAhadeth() async {
    emit(AhadethLoading());
    try {
      final prefs = await SharedPreferences.getInstance();

      // 1️⃣ محاولة قراءة الأحاديث من الكاش أولاً
      if (prefs.containsKey(_cacheKey)) {
        final cached = prefs.getStringList(_cacheKey);
        if (cached != null && cached.isNotEmpty) {
          final list = cached.map((s) {
            final m = jsonDecode(s) as Map<String, dynamic>;
            return HadethModel(
              m['title']?.toString() ?? '',
              m['content']?.toString() ?? '',
            );
          }).toList();
          emit(AhadethLoaded(list));
          return;
        }
      }

      // 2️⃣ لو الكاش فاضي، نقرأ من ملف الأصول
      final raw = await rootBundle.loadString('assets/files/ahadeth.txt');
      final parts = raw.split('#'); // يفصل بين كل حديث والآخر
      final List<HadethModel> list = [];

      for (var part in parts) {
        final trimmed = part.trim();
        if (trimmed.isEmpty) continue;

        final firstNewline = trimmed.indexOf('\n');
        if (firstNewline <= 0) continue;

        final title = trimmed.substring(0, firstNewline).trim();
        final content = trimmed.substring(firstNewline + 1).trim();

        if (title.isNotEmpty && content.isNotEmpty) {
          list.add(HadethModel(title, content));
        }
      }

      // 3️⃣ تخزين الأحاديث في الكاش
      final toCache = list
          .map((h) => jsonEncode({'title': h.title, 'content': h.content}))
          .toList();
      await prefs.setStringList(_cacheKey, toCache);

      emit(AhadethLoaded(list));
    } catch (e) {
      emit(AhadethError("حدث خطأ أثناء تحميل الأحاديث: ${e.toString()}"));
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
