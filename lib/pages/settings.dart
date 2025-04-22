import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tester/config.dart';
import 'package:tester/logger_wrapper.dart' show AppLogger;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double minRam = 4;
  double? maxRam;
  double? selectedMaxRam;
  RangeValues _ramValues = const RangeValues(4, 8);
  String resolution = "1280x720";
  String javaPath = "";
  String javaArgs = "";

  // final TextEditingController _javaPathController = TextEditingController();
  final List<String> resolutions = ["800x600", "1280x720", "1920x1080", "2560x1440"];

  
  void _loadMaxRam() async {
    setState(() {
      maxRam = AppConfig.instance.ramSize!.toDouble();
      _ramValues = RangeValues(
        minRam.clamp(1, maxRam!),
        (maxRam! * 0.75).clamp(minRam + 1, maxRam!),
      );
    });
  }

  @override
  void initState() {
    _loadMaxRam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (maxRam == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle("Выбор ОЗУ"),
                RangeSlider(
                  values: _ramValues,
                  min: 1,
                  max: maxRam!,
                  divisions: (maxRam! - 1).toInt(),
                  labels: RangeLabels(
                    "${_ramValues.start.toInt()} GB",
                    "${_ramValues.end.toInt()} GB",
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _ramValues = values;
                      minRam = values.start;
                      selectedMaxRam = values.end;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Мин: ${_ramValues.start.toInt()} ГБ",
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Cascadia'),
                    ),
                    Text(
                      "Макс: ${_ramValues.end.toInt()} ГБ",
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Cascadia'),
                    ),
                  ],
                ),
                _buildTitle("Разрешение экрана"),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.transparent, //background
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: resolution,
                    items: resolutions.map((res) {
                      return DropdownMenuItem(
                        value: res,
                        child: Text(
                          res,
                          style: const TextStyle(color: Colors.white), // text
                        ),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => resolution = value!),
                    dropdownColor: Colors.black54,  // dropdown background
                    underline: const SizedBox(), 
                  ),
                ),
                _buildTitle("Путь до Java"),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: javaPath),
                        style: const TextStyle(color: Colors.white),
                        readOnly: true, 
                        decoration: InputDecoration(
                          hintText: "Например: C:/Program Files/Java/jdk/bin/java.exe",
                          hintStyle: const TextStyle(color: Colors.white38, fontFamily: 'Cascadia'),
                          filled: true, 
                          fillColor: Colors.black45, 
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      onChanged: (value) => setState(() => javaPath = value),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _pickJava, 
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(Colors.black54)
                      ),
                      child: const Text("Обзор", 
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                _buildTitle("Аргументы Java"),
                TextField(
                  style: const TextStyle(color: Colors.white), 
                  decoration: InputDecoration(
                    hintText: "-Xmx4G -Xms2G -XX:+UseG1GC",
                    hintStyle: const TextStyle(color: Colors.white38, fontFamily: 'Cascadia'),
                    filled: true,
                    fillColor: Colors.black45, 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (value) => setState(() => javaArgs = value),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveSettings,
                  child: const Text("Сохранить"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Cascadia',
        ),
      ),
    );
  }

  void _saveSettings() {
    AppLogger().i("ОЗУ: ${minRam.toInt()}ГБ - ${maxRam!.toInt()}ГБ");
    AppLogger().i("Разрешение: $resolution");
    AppLogger().i("Путь до Java: $javaPath");
    AppLogger().i("Аргументы: $javaArgs");
  }

  Future<void> _pickJava() async
  {
    String? path = await FilePicker.platform.pickFiles(
      dialogTitle: "Select java.exe",
      type: FileType.custom,
      allowedExtensions: ["exe"], // only .exe
    ).then((result) => result?.files.single.path);

    if(path != null)
    {
      setState(() => javaPath = path);
    }
  }

}
