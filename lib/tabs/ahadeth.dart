import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami_c8_friday/hadethModel.dart';
import 'package:islami_c8_friday/hadeth_content.dart';
import 'package:islami_c8_friday/Cubits/ahadeth_cubit.dart';
import '../l10n/app_localizations.dart';

class AhadethTab extends StatefulWidget {
  const AhadethTab({Key? key}) : super(key: key);

  @override
  State<AhadethTab> createState() => _AhadethTabState();
}

class _AhadethTabState extends State<AhadethTab> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AhadethCubit>().loadAhadeth();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<HadethModel> _filter(List<HadethModel> all) {
    if (_query.trim().isEmpty) return all;
    final q = _query.trim().toLowerCase();
    return all.where((h) {
      return h.title.toLowerCase().contains(q) ||
          h.content.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;

    return BlocBuilder<AhadethCubit, AhadethState>(
      builder: (context, state) {
        Widget body;

        if (state is AhadethLoading || state is AhadethInitial) {
          body = const Center(child: CircularProgressIndicator());
        } else if (state is AhadethError) {
          body = Center(child: Text('Error: ${state.message}'));
        } else if (state is AhadethLoaded) {
          final filtered = _filter(state.ahadeth);

          body = Column(
            children: [
              // 🟢 صورة الأحاديث
              Image.asset(
                "assets/images/ahadeth.png",
                height: 180,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 10),
              Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.onBackground),
              Text(
                AppLocalizations.of(context)!.ahadeth,
                style: GoogleFonts.elMessiri(
                    fontSize: 26, fontWeight: FontWeight.w600),
              ),
              Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.onBackground),

              // 🟢 مربع البحث
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() {
                    _query = v;
                  }),
                  decoration: InputDecoration(
                    hintText: lang == 'ar'
                        ? 'ابحث عن حديث...'
                        : 'Search hadith...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              // 🟢 قائمة الأحاديث
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                  child: Text(
                    lang == 'ar' ? "لا توجد نتائج" : "No results found",
                    style: const TextStyle(fontSize: 18),
                  ),
                )
                    : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    endIndent: 35,
                    indent: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final hadeth = filtered[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          HadethContent.routeName,
                          arguments: hadeth,
                        );
                      },
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          hadeth.title,
                          style: GoogleFonts.quicksand(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          body = const SizedBox.shrink();
        }

        return body;
      },
    );
  }
}
