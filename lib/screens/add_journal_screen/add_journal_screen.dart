import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';

class AddJournalScreen extends StatelessWidget {
  final Journal journal;
  AddJournalScreen({Key? key, required this.journal}) : super(key: key);
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${WeekDay(journal.createdAt.weekday).long.toLowerCase()}, ${journal.createdAt.day} | ${journal.createdAt.month} | ${journal.createdAt.year}"),
        actions: [
          IconButton(onPressed: () {
            registerJournal(context);
          }, icon: const Icon(Icons.check)),
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

  registerJournal(BuildContext context) async {
    String content = _contentController.text;

    journal.content = content;

    JournalService service = JournalService();
    await service.register(journal);

    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Journal added successfully!")),
      );
      Navigator.pop(context);
    }
  }
}
