import 'package:flutter/material.dart';
import '../../../models/journal.dart';
import 'journal_card.dart';

List<JournalCard> generateListJournalCards(
    {required int windowPage,
    required DateTime currentDay,
    required Map<String, Journal> database,
    VoidCallback? onRefresh,}) {
  // Cria uma lista de Cards vazios
  List<JournalCard> list = List.generate(
    windowPage + 1,
    (index) => JournalCard(
      showedDate: currentDay.subtract(Duration(days: (windowPage) - index)),
      onRefresh: onRefresh,
    ),
  );

  //Preenche os espaços que possuem entradas no banco
  database.forEach((key, value) {
    if (value.createdAt
        .isAfter(currentDay.subtract(Duration(days: windowPage)))) {
      int difference = value.createdAt
          .difference(currentDay.subtract(Duration(days: windowPage)))
          .inDays
          .abs();

      list[difference] = JournalCard(
        showedDate: list[difference].showedDate,
        journal: value,
        onRefresh: onRefresh,
      );
    }
  });
  return list;
}
