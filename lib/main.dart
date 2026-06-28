import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';
void main() => runApp(const NovaSolveApp());
class NovaSolveApp extends StatelessWidget {
  const NovaSolveApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaSolve AI PRO',debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0A0A0F),primaryColor: const Color(0xFF00F5D4),cardColor: const Color(0xFF1A1A2F),textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
      home: const HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});@override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String lang = 'AR';int tabIndex = 0;
  late final Map<String, Map<String, List<Map<String, String>>>> allData = _generate200Laws();
  Map<String, Map<String, List<Map<String, String>>>> _generate200Laws() {
    final rand = Random();
    Map<String, Map<String, List<Map<String, String>>>> data = {};
    List<String> langs = ['AR','EN','FR','DE','ES','TR'];
    List<String> tabsAR = ['رياضيات','فيزياء','كيمياء','AI'];
    List<String> tabsEN = ['Math','Physics','Chemistry','AI'];
    for(String l in langs){
      data[l] = {};
      List<String> tabs = l=='AR'?tabsAR:tabsEN;
      data[l]![tabs[0]] = List.generate(80, (i) => {l=='AR'?'الاسم':'name':'قانون ${i+1}',l=='AR'?'القانون':'law':'${rand.nextInt(9)+1}x² + ${rand.nextInt(9)+1}x + ${rand.nextInt(9)+1} = 0'});
      data[l]![tabs[1]] = List.generate(60, (i) => {l=='AR'?'الاسم':'name':'قانون فيزياء ${i+1}',l=='AR'?'القانون':'law':'F = m × a + ${rand.nextInt(100)}'});
      data[l]![tabs[2]] = List.generate(50, (i) => {l=='AR'?'الاسم':'name':'مركب ${i+1}',l=='AR'?'القانون':'law':'H${rand.nextInt(5)+1}O${rand.nextInt(5)+1}'});
      data[l]![tabs[3]] = [{'name':l=='AR'?'اسأل نوفا AI':'Ask Nova AI','law':l=='AR'?'200 قاعدة اوفلاين':'200 laws offline'}];
    }
    return data;
  }
  @override
  Widget build(BuildContext context) {
    final tabs = lang == 'AR'? ['رياضيات','فيزياء','كيمياء','AI'] : ['Math','Physics','Chemistry','AI'];
    final data = allData![tabs[tabIndex]]!;
    return Scaffold(
      appBar: AppBar(title: Text('NovaSolve AI PRO ✨ 200+', style: GoogleFonts.orbitron(fontWeight: FontWeight.bold)).animate().fadeIn(),backgroundColor: Colors.transparent,elevation: 0,
        actions: [DropdownButton<String>(value: lang,dropdownColor: const Color(0xFF1A1A2F),underline: const SizedBox(),icon: const Icon(Icons.language, color: Color(0xFF00F5D4)),
            items: ['AR','EN','FR','DE','ES','TR'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white)))).toList(),onChanged: (v) => setState(() => lang = v!),),const SizedBox(width: 12)],
      ),
      body: ListView.builder(padding: const EdgeInsets.all(16),itemCount: data.length,
        itemBuilder: (_, i) => Container(margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),gradient: const LinearGradient(colors: [Color(0xFF1A1A2F), Color(0xFF2A2A4F)]),boxShadow: [BoxShadow(color: const Color(0xFF00F5D4).withOpacity(0.15), blurRadius: 8)],),
          child: ListTile(dense: true,
            title: Text(data[i]['الاسم']?? data[i]['name']!, style: const TextStyle(color: Color(0xFF00F5D4), fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Text(data[i]['القانون']?? data[i]['law']!, style: const TextStyle(fontSize: 14, color: Colors.white70)),
          ),
        ).animate().slideX(duration: 300.ms, delay: (i*30).ms).fadeIn(),
      ),
      bottomNavigationBar: BottomNavigationBar(currentIndex: tabIndex,backgroundColor: const Color(0xFF1A1A2F),selectedItemColor: const Color(0xFF00F5D4),unselectedItemColor: Colors.grey,type: BottomNavigationBarType.fixed,onTap: (i) => setState(() => tabIndex = i),items: tabs.map((t) => BottomNavigationBarItem(icon: const Icon(Icons.science), label: t)).toList(),),
    );
  }
}
