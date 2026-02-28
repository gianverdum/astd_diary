import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddJournalScreen extends StatelessWidget {
  final Journal journal;
  final bool isEditing;
  AddJournalScreen({Key? key, required this.journal, required this.isEditing})
      : super(key: key);
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _contentController.text = journal.content;
    return Scaffold(
      appBar: AppBar(
        title: Text(WeekDay(journal.createdAt).toString()),
        actions: [
          IconButton(
              onPressed: () {
                registerJournal(context);
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: TextField(
        controller: _contentController,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(fontSize: 24),
        expands: true,
        maxLines: null,
        decoration: const InputDecoration(
          hintText: "What is on your mind?",
          contentPadding: EdgeInsets.all(20),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<void> registerJournal(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    
    if (token != null) {
      String content = _contentController.text;
      journal.content = content;

      JournalService service = JournalService();
      if (isEditing) {
        await service.register(journal, token: token);
      } else {
        await service.edit(journal.id, journal, token: token);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Journal recorded successfully!")),
        );
        Navigator.pop(context, true);
      }
    }
  }
}
