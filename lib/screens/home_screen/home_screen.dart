import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/home_screen/widgets/home_screen_list.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/journal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // O último dia apresentado na lista
  DateTime currentDay = DateTime.now();

  // Tamanho da lista
  int windowPage = 10;

  // A base de dados mostrada na lista
  Map<String, Journal> database = {};

  int? userId;

  final ScrollController _listScrollController = ScrollController();

  JournalService service = JournalService();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título basado no dia atual
        title: Text(
          "${currentDay.day}  |  ${currentDay.month}  |  ${currentDay.year}",
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                refresh();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                logout();
              },
              title: const Text("Logout"),
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            controller: _listScrollController,
            children: generateListJournalCards(
              windowPage: windowPage,
              currentDay: currentDay,
              database: database,
              onRefresh: refresh,
              userId: userId,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    String? token = prefs.getString("accessToken");
    String? email = prefs.getString("email");
    int? id = prefs.getInt("id");

    if (token != null && email != null && id != null) {
      try {
        final listJournal = await service.getAll(
          id: id.toString(),
          token: token,
        );

        if (!mounted) return;

        setState(() {
          userId = id;
          database = {};
          for (Journal journal in listJournal) {
            database[journal.id] = journal;
          }
        });
      } catch (e) {
        // token expirado ou inválido
        await prefs.clear();

        if (!mounted) return;
        Navigator.pushReplacementNamed(context, "login");
      }
    } else {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "login");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, "login");
  }
}
