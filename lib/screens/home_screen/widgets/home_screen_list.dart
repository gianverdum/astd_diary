import 'package:flutter/material.dart';
import '../../../models/journal.dart';
import 'journal_card.dart';

List<JournalCard> generateListJournalCards(
    {required int windowPage,
    required DateTime currentDay,
    required Map<String, Journal> database,
    VoidCallback? onRefresh,
    required int? userId,}) {
  // Cria uma lista de Cards vazios
  List<JournalCard> list = List.generate(
    windowPage + 1,
    (index) => JournalCard(
      showedDate: currentDay.subtract(Duration(days: (windowPage) - index)),
      onRefresh: onRefresh,
      userId: userId ?? 0,
    ),
  );

  //Preenche os espaços que possuem entradas no banco
  database.forEach((key, value) {
    // Normalize dates to midnight for accurate day comparison
    DateTime normalizedCreatedAt = DateTime(
      value.createdAt.year,
      value.createdAt.month,
      value.createdAt.day,
    );
    
    DateTime normalizedStart = DateTime(
      currentDay.year,
      currentDay.month,
      currentDay.day,
    ).subtract(Duration(days: windowPage));
    
    if (normalizedCreatedAt.isAfter(normalizedStart) || 
        normalizedCreatedAt.isAtSameMomentAs(normalizedStart)) {
      int difference = normalizedCreatedAt
          .difference(normalizedStart)
          .inDays;

      list[difference] = JournalCard(
        showedDate: list[difference].showedDate,
        journal: value,
        onRefresh: onRefresh,
        userId: value.userId,
      );
    }
  });
  return list;
}
