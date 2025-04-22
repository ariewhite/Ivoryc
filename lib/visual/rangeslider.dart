import 'package:flutter/material.dart';

class RamRangeSlider extends StatefulWidget {
  const RamRangeSlider({super.key});

  @override
  State<RamRangeSlider> createState() => _RamRangeSliderState();
}

class _RamRangeSliderState extends State<RamRangeSlider> {
  double minRam = 2;
  double maxRam = 16;
  RangeValues _currentRangeValues = const RangeValues(4, 8);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Min: ${_currentRangeValues.start.toInt()} GB",
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "Max: ${_currentRangeValues.end.toInt()} GB",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: minRam,
          max: maxRam,
          divisions: (maxRam - minRam).toInt(),
          labels: RangeLabels(
            "${_currentRangeValues.start.toInt()} GB",
            "${_currentRangeValues.end.toInt()} GB",
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
      ],
    );
  }
}