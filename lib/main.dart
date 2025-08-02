// ver 0.0.2

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart'; // 自動生成されたファイル
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await MobileAds.instance.initialize();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BouzuHomePage(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ja'),
      ],
    );
  }
}

class BouzuHomePage extends StatefulWidget {
  const BouzuHomePage({super.key});

  @override
  State<BouzuHomePage> createState() => _BouzuHomePageState();
}

class _BouzuHomePageState extends State<BouzuHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _goal = '';
  int _level = 1;
  int _day = 1;
  List<String> _continuedDates = [];
  DateTime? _lastPressedDate; 
  late BannerAd _bannerAd;
  bool _isBannerReady = false;


  @override
  void initState() {
    super.initState();
    _loadData();
    _initBannerAd();
  }

  void _initBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // ← テスト用（本番は差し替え）
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerReady = true;
          });
          debugPrint('✅ Ad loaded');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('❌ Ad failed to load: ${error.code} - ${error.message}');
       },
     ),
   )..load();
 }


  Future<void> _loadData() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _goal = prefs.getString('goal') ?? '';
    _level = prefs.getInt('level') ?? 1;
    _day = prefs.getInt('day') ?? 1;
    _continuedDates = prefs.getStringList('dates') ?? []; // ← keyを確認！
    final lastDateStr = prefs.getString('lastPressedDate');
    if (lastDateStr != null) {
      _lastPressedDate = DateTime.tryParse(lastDateStr);
    }
  });
  debugPrint('ロードされた: Lv $_level, Day $_day,最終達成日 $_lastPressedDate');
  }


  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('goal', _goal);
    await prefs.setInt('level', _level);
    await prefs.setInt('day', _day);
    await prefs.setStringList('dates', _continuedDates.toList());
    await prefs.setString('lastPressedDate', _lastPressedDate?.toIso8601String() ?? '');
  }

  Future<void> _shareImageWithText() async {
    final loc = AppLocalizations.of(context)!;
    try {
      // 1. アセット画像（Lv画像）を読み込み
      final byteData = await rootBundle.load('assets/images/Lv$_level.png');

      // 2. 一時ディレクトリにファイルとして保存
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/Lv$_level.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // 3. 画像＋テキストを共有
      await Share.shareXFiles(
        [XFile(file.path)],
        text: loc.shareMessage(_goal, _level, _day),
      );
   } catch (e) {
     debugPrint('❌ 共有失敗: $e');
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text("共有に失敗しました")),
      );
    }
  }


  void _setGoal() {
    setState(() {
      _goal = _controller.text;
      _level = 1;
      _day = 1;
      _continuedDates = [];
    });
    _saveData();
  }

  void _continue() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  // 同じ日に2回押せないようにする
  if (_lastPressedDate != null) {
    final lastDate = DateTime(
        _lastPressedDate!.year, _lastPressedDate!.month, _lastPressedDate!.day);

    if (lastDate == today) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.alreadyPressedToday)),
      );
      return;
    }

    if (today.difference(lastDate).inDays > 1) {
      _reset(auto: true); // 念のためここでも1日空きチェック
      return;
    }
  }

  setState(() {
    if (_day < 3) {
      _day++;
    } else {
      _day = 1;
      _level++;
    }

    debugPrint('続けた: Lv $_level, Day $_day');

    final todayStr =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    if (!_continuedDates.contains(todayStr)) {
      _continuedDates.add(todayStr);
    }

    _lastPressedDate = today; // ← ここで更新！
  });

  _saveData();
  }


  Future<void> _reset({bool auto = false}) async {
  if (!auto) {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirmTitle),
        content: Text(AppLocalizations.of(context)!.confirmReset),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.doReset),
          ),
        ],
      ),
    );

    if (confirm != true) return;
  }

  setState(() {
    _goal = '';
    _level = 1;
    _day = 1;
    _continuedDates = [];
    _controller.clear();
    _lastPressedDate = null; // ここも忘れずリセット
  });

  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  if (auto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.autoResetMessage)),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.appTitle)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_goal.isNotEmpty) ...[
                        Text(loc.yourGoal(_goal), style: const TextStyle(fontSize: 24)),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/Lv$_level.png',
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        Text(loc.levelAndDay(_level, _day), style: const TextStyle(fontSize: 24)),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _continue,
                          child: Text(loc.todayDone),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalendarPage(continuedDates: _continuedDates),
                              ),
                            );
                          },
                          child: Text(loc.seeCalendar),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _shareImageWithText,
                          child: Text(loc.shareProgressButton),
                        ),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: loc.goalHint,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _setGoal,
                          child: Text(loc.setGoal),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: _reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[200],
              ),
              child: Text(loc.reset),
            ),
          ),
        ],
      ),
    bottomNavigationBar: _isBannerReady
      ? SizedBox(
          height: _bannerAd.size.height.toDouble(),
          width: _bannerAd.size.width.toDouble(),
          child: AdWidget(ad: _bannerAd),
        )
      : const SizedBox.shrink(),
    );
  }
}

class CalendarPage extends StatelessWidget {
  final List<String> continuedDates;
  const CalendarPage({super.key, required this.continuedDates});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final markedDates = continuedDates.map((e) => DateTime.parse(e)).toSet();

    return Scaffold(
      appBar: AppBar(title: Text(loc.calendarTitle)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: DateTime.now(),
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (markedDates.contains(DateTime(date.year, date.month, date.day))) {
                return const Center(
                  child: Icon(Icons.check_circle, size: 16, color: Colors.green),
                );
              }
              return null;
            },
          ),
          selectedDayPredicate: (day) => false,
          onDaySelected: (selectedDay, focusedDay) {},
        ),
      ),
    );
  }
}
