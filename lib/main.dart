import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_c8_friday/screens/bookmarks_screen.dart';
import 'package:islami_c8_friday/widgets/azkar_content.dart';

import 'home_screen.dart';
import 'my_theme.dart';
import 'Cubits/MyCubit.dart';
import 'Cubits/ahadeth_cubit.dart';
import 'Cubits/BookmarkCubit.dart';
import 'Cubits/sura_details_provider.dart';

import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/azkar_screen.dart';
import 'screens/radio_screen.dart';
import 'package:islami_c8_friday/hadeth_content.dart';
import 'package:islami_c8_friday/sura_content.dart';
import 'l10n/app_localizations.dart';
import 'services/notification_service.dart';

// ✅ استيراد صفحة محتوى الأذكار الجديدة


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MyCubit()),
        BlocProvider(create: (context) => SuraDetailsCubit()),
        BlocProvider(create: (context) => BookmarkCubit()),
        BlocProvider(create: (context) => AhadethCubit()),
      ],
      child: const MyApplication(),
    ),
  );
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCubit, MyState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("en"),
            Locale("ar"),
          ],
          locale: Locale(state.languageCode),
          theme: MyThemeData.lightTheme,
          darkTheme: MyThemeData.darkTheme,
          themeMode: state.themeMode,
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            OnboardingScreen.routeName: (context) => const OnboardingScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            SuraContent.routeName: (context) => const SuraContent(),
            HadethContent.routeName: (context) => HadethContent(),
            AzkarScreen.routeName: (context) => AzkarScreen(),
            RadioScreen.routeName: (context) => RadioScreen(),
            BookmarksScreen.routeName: (context) => const BookmarksScreen(),

            // ✅ صفحة الأذكار الجديدة
            AzkarContent.routeName: (context) => AzkarContent(),
          },
        );
      },
    );
  }
}
