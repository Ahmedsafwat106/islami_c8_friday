import 'package:flutter/material.dart';
import 'package:islami_c8_friday/hadethModel.dart';

class HadethContent extends StatelessWidget {
  static const String routeName = "hadethContent";

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as HadethModel;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? Colors.grey[900] : Colors.white;
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: 18,
      color: isDark ? Colors.white : Colors.black87,
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            isDark
                ? "assets/images/dark_main_bg.png"
                : "assets/images/main_bg.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            args.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              elevation: 12,
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  args.content,
                  textDirection: TextDirection.rtl,
                  style: textStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
