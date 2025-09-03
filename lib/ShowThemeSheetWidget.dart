import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_c8_friday/my_theme.dart';
import 'Cubits/MyCubit.dart';


class ShowThemeSheetWidget extends StatelessWidget {
  const ShowThemeSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCubit, MyState>(
      builder: (context, state) {
        return Container(
          color: state.themeMode == ThemeMode.light
              ? Colors.white
              : Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    context.read<MyCubit>().changeTheme(ThemeMode.light);
                  },
                  child: Row(
                    children: [
                      Text("Light",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: state.themeMode == ThemeMode.light
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          )),
                      const Spacer(),
                      Icon(Icons.done,
                          color: state.themeMode == ThemeMode.light
                              ? Theme.of(context).primaryColor
                              : Colors.white,
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
                    context.read<MyCubit>().changeTheme(ThemeMode.dark);
                  },
                  child: Row(
                    children: [
                      Text("Dark",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: state.themeMode == ThemeMode.dark
                                  ? MyThemeData.yellowColor
                                  : Colors.black54)),
                      const Spacer(),
                      Icon(Icons.done,
                          color: state.themeMode == ThemeMode.dark
                              ? MyThemeData.yellowColor
                              : Colors.black54,
                          size: 30)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
