
import 'package:flutter/material.dart';
import 'package:fonttheme/theme_provider.dart';
import 'package:provider/provider.dart';

class FontSlider extends StatefulWidget {
  const FontSlider({super.key});

  @override
  State<FontSlider> createState() => _FontSliderState();
}

class _FontSliderState extends State<FontSlider> {
  double smallFontSize = 14.0;
  double mediumFontSize = 16.0;
  double largeFontSize = 20.0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Example'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Apps that support Dynamic Type will adjust to your preferred reading size below',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: Provider.of<ThemeProvider>(context)
                        .adjustedSmallFontSize,
                  ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.translate(
                  offset: const Offset(0, -15),
                  child: const Text(
                    'A',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value:context.read<ThemeProvider>(). fontSizeDelta,
                    min: 0.0,
                    max: 4.0,
                    divisions: 4,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.blue.withOpacity(0.2),
                    onChanged: (double value) {
                      setState(() {
                        context.read<ThemeProvider>(). fontSizeDelta = value;
                        context.read<ThemeProvider>().saveFontSizeDelta(context.read<ThemeProvider>(). fontSizeDelta);
                        Provider.of<ThemeProvider>(context, listen: false)
                            .updateSmallFontSize(smallFontSize + context.read<ThemeProvider>(). fontSizeDelta);
                        Provider.of<ThemeProvider>(context, listen: false)
                            .updateMediumFontSize(
                                mediumFontSize + context.read<ThemeProvider>(). fontSizeDelta);
                        Provider.of<ThemeProvider>(context, listen: false)
                            .updateLargeFontSize(largeFontSize + context.read<ThemeProvider>(). fontSizeDelta);
                      });
                    },
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Text(
                    'A',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
