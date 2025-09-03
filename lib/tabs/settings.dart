import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami_c8_friday/ShowThemeSheetWidget.dart';
import '../Cubits/MyCubit.dart';
import '../showlanguageSheetWidget.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCubit, MyState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Language",
                  style: GoogleFonts.elMessiri(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              InkWell(
                onTap: () {
                  showLanguageSheet(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Theme.of(context).primaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.languageCode == "en" ? "English" : "عربي",
                      style: GoogleFonts.elMessiri(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Text("Theming",
                  style: GoogleFonts.elMessiri(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              InkWell(
                onTap: () {
                  showThemeSheet(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Theme.of(context).primaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.themeMode == ThemeMode.light ? "Light" : "Dark",
                      style: GoogleFonts.elMessiri(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ShowLanguageSheetWidget(),
    );
  }

  void showThemeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ShowThemeSheetWidget(),
    );
  }
}
