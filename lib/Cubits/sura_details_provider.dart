import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;

// الحالة (States)
abstract class SuraDetailsState {}

class SuraDetailsInitial extends SuraDetailsState {}

class SuraDetailsLoading extends SuraDetailsState {}

class SuraDetailsLoaded extends SuraDetailsState {
  final List<String> verses;
  SuraDetailsLoaded(this.verses);
}

class SuraDetailsError extends SuraDetailsState {
  final String message;
  SuraDetailsError(this.message);
}

// الكيوبت
class SuraDetailsCubit extends Cubit<SuraDetailsState> {
  SuraDetailsCubit() : super(SuraDetailsInitial());

  Future<void> loadFile(int index) async {
    emit(SuraDetailsLoading());
    try {
      String content =
      await rootBundle.loadString("assets/files/${index + 1}.txt");

      List<String> verses = content.split("\n");

      emit(SuraDetailsLoaded(verses));
    } catch (e) {
      emit(SuraDetailsError("Error loading file: $e"));
    }
  }
}
