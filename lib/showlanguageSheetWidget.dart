import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubits/MyCubit.dart';

class ShowLanguageSheetWidget extends StatelessWidget {
  const ShowLanguageSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCubit, MyState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  if (state.languageCode == "en") return;
                  context.read<MyCubit>().changeLanguage("en");
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Text("English",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: state.languageCode == "en"
                              ? Theme.of(context).primaryColor
                              : Colors.black54,
                        )),
                    const Spacer(),
                    Icon(Icons.done,
                        color: state.languageCode == "en"
                            ? Theme.of(context).primaryColor
                            : Colors.black54,
                        size: 30)
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                endIndent: 50,
                indent: 50,
                color: Theme.of(context).primaryColor,
              ),
              InkWell(
                onTap: () {
                  if (state.languageCode == "ar") return;
                  context.read<MyCubit>().changeLanguage("ar");
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Text("Arabic",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: state.languageCode == "ar"
                                ? Theme.of(context).primaryColor
                                : Colors.black54)),
                    const Spacer(),
                    Icon(Icons.done,
                        color: state.languageCode == "ar"
                            ? Theme.of(context).primaryColor
                            : Colors.black54,
                        size: 30)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
