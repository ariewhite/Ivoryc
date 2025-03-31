import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double minRam = 2;
  double maxRam = 4;
  String resolution = "1280x720";
  String javaPath = "";
  String javaArgs = "";

  // final TextEditingController _javaPathController = TextEditingController();
  final List<String> resolutions = ["800x600", "1280x720", "1920x1080", "2560x1440"];

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    Text(
                      "Мин: ${minRam.toInt()} ГБ",
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Cascadia'),
                    ),
                    Expanded(
                      child: Slider(
                        value: minRam,
                        min: 1,
                        max: 16,
                        divisions: 15,
                        label: "${minRam.toInt()} ГБ",
                        onChanged: (value) => setState(() => minRam = value),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Макс: ${maxRam.toInt()} ГБ",
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Cascadia'),
                    ),
                    Expanded(
                      child: Slider(
                        value: maxRam,
                        min: minRam,
                        max: 32,
                        divisions: 30,
                        label: "${maxRam.toInt()} ГБ",
                        onChanged: (value) => setState(() => maxRam = value),
                      ),
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
    print("ОЗУ: ${minRam.toInt()}ГБ - ${maxRam.toInt()}ГБ");
    print("Разрешение: $resolution");
    print("Путь до Java: $javaPath");
    print("Аргументы: $javaArgs");
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
