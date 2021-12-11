import 'dart:convert';

String getSuranArabicName(int num) {
  final jsonExtractedList = json.decode(surahList);
  final List<dynamic> suarhListData =
      jsonExtractedList['surat'] as List<dynamic>;
  Map surahMap =
      suarhListData.firstWhere((element) => element['surah'] == num.toString());
  if (surahMap.isNotEmpty) {
    return surahMap['name'];
  }

  return '';
}

const String surahList =
    "{\"surat\":[\n\t{\"surah\":\"1\", \"name\": \"\u0627\u0644\u0641\u0627\u062a\u062d\u0629\"},\n\t{\"surah\":\"2\", \"name\": \"\u0627\u0644\u0628\u0642\u0631\u0629\"},\n\t{\"surah\":\"3\", \"name\": \"\u0622\u0644 \u0639\u0645\u0631\u0627\u0646\"},\n\t{\"surah\":\"4\", \"name\": \"\u0627\u0644\u0646\u0633\u0627\u0621\"},\n\t{\"surah\":\"5\", \"name\": \"\u0627\u0644\u0645\u0627\u0626\u062f\u0629\"},\n\t{\"surah\":\"6\", \"name\": \"\u0627\u0644\u0623\u0646\u0639\u0627\u0645\"},\n\t{\"surah\":\"7\", \"name\": \"\u0627\u0644\u0623\u0639\u0631\u0627\u0641\"},\n\t{\"surah\":\"8\", \"name\": \"\u0627\u0644\u0623\u0646\u0641\u0627\u0644\"},\n\t{\"surah\":\"9\", \"name\": \"\u0627\u0644\u062a\u0648\u0628\u0629\"},\n\t{\"surah\":\"10\", \"name\": \"\u064a\u0648\u0646\u0633\"},\n\t{\"surah\":\"11\", \"name\": \"\u0647\u0648\u062f\"},\n\t{\"surah\":\"12\", \"name\": \"\u064a\u0648\u0633\u0641\"},\n\t{\"surah\":\"13\", \"name\": \"\u0627\u0644\u0631\u0639\u062f\"},\n\t{\"surah\":\"14\", \"name\": \"\u0627\u0628\u0631\u0627\u0647\u064a\u0645\"},\n\t{\"surah\":\"15\", \"name\": \"\u0627\u0644\u062d\u062c\u0631\"},\n\t{\"surah\":\"16\", \"name\": \"\u0627\u0644\u0646\u062d\u0644\"},\n\t{\"surah\":\"17\", \"name\": \"\u0627\u0644\u0625\u0633\u0631\u0627\u0621\"},\n\t{\"surah\":\"18\", \"name\": \"\u0627\u0644\u0643\u0647\u0641\"},\n\t{\"surah\":\"19\", \"name\": \"\u0645\u0631\u064a\u0645\"},\n\t{\"surah\":\"20\", \"name\": \"\u0637\u0647\"},\n\t{\"surah\":\"21\", \"name\": \"\u0627\u0644\u0623\u0646\u0628\u064a\u0627\u0621\"},\n\t{\"surah\":\"22\", \"name\": \"\u0627\u0644\u062d\u062c\"},\n\t{\"surah\":\"23\", \"name\": \"\u0627\u0644\u0645\u0624\u0645\u0646\u0648\u0646\"},\n\t{\"surah\":\"24\", \"name\": \"\u0627\u0644\u0646\u0648\u0631\"},\n\t{\"surah\":\"25\", \"name\": \"\u0627\u0644\u0641\u0631\u0642\u0627\u0646\"},\n\t{\"surah\":\"26\", \"name\": \"\u0627\u0644\u0634\u0639\u0631\u0627\u0621\"},\n\t{\"surah\":\"27\", \"name\": \"\u0627\u0644\u0646\u0645\u0644\"},\n\t{\"surah\":\"28\", \"name\": \"\u0627\u0644\u0642\u0635\u0635\"},\n\t{\"surah\":\"29\", \"name\": \"\u0627\u0644\u0639\u0646\u0643\u0628\u0648\u062a\"},\n\t{\"surah\":\"30\", \"name\": \"\u0627\u0644\u0631\u0648\u0645\"},\n\t{\"surah\":\"31\", \"name\": \"\u0644\u0642\u0645\u0627\u0646\"},\n\t{\"surah\":\"32\", \"name\": \"\u0627\u0644\u0633\u062c\u062f\u0629\"},\n\t{\"surah\":\"33\", \"name\": \"\u0627\u0644\u0623\u062d\u0632\u0627\u0628\"},\n\t{\"surah\":\"34\", \"name\": \"\u0633\u0628\u0625\"},\n\t{\"surah\":\"35\", \"name\": \"\u0641\u0627\u0637\u0631\"},\n\t{\"surah\":\"36\", \"name\": \"\u064a\u0633\"},\n\t{\"surah\":\"37\", \"name\": \"\u0627\u0644\u0635\u0627\u0641\u0627\u062a\"},\n\t{\"surah\":\"38\", \"name\": \"\u0635\"},\n\t{\"surah\":\"39\", \"name\": \"\u0627\u0644\u0632\u0645\u0631\"},\n\t{\"surah\":\"40\", \"name\": \"\u063a\u0627\u0641\u0631\"},\n\t{\"surah\":\"41\", \"name\": \"\u0641\u0635\u0644\u062a\"},\n\t{\"surah\":\"42\", \"name\": \"\u0627\u0644\u0634\u0648\u0631\u0649\"},\n\t{\"surah\":\"43\", \"name\": \"\u0627\u0644\u0632\u062e\u0631\u0641\"},\n\t{\"surah\":\"44\", \"name\": \"\u0627\u0644\u062f\u062e\u0627\u0646\"},\n\t{\"surah\":\"45\", \"name\": \"\u0627\u0644\u062c\u0627\u062b\u064a\u0629\"},\n\t{\"surah\":\"46\", \"name\": \"\u0627\u0644\u0623\u062d\u0642\u0627\u0641\"},\n\t{\"surah\":\"47\", \"name\": \"\u0645\u062d\u0645\u062f\"},\n\t{\"surah\":\"48\", \"name\": \"\u0627\u0644\u0641\u062a\u062d\"},\n\t{\"surah\":\"49\", \"name\": \"\u0627\u0644\u062d\u062c\u0631\u0627\u062a\"},\n\t{\"surah\":\"50\", \"name\": \"\u0642\"},\n\t{\"surah\":\"51\", \"name\": \"\u0627\u0644\u0630\u0627\u0631\u064a\u0627\u062a\"},\n\t{\"surah\":\"52\", \"name\": \"\u0627\u0644\u0637\u0648\u0631\"},\n\t{\"surah\":\"53\", \"name\": \"\u0627\u0644\u0646\u062c\u0645\"},\n\t{\"surah\":\"54\", \"name\": \"\u0627\u0644\u0642\u0645\u0631\"},\n\t{\"surah\":\"55\", \"name\": \"\u0627\u0644\u0631\u062d\u0645\u0646\"},\n\t{\"surah\":\"56\", \"name\": \"\u0627\u0644\u0648\u0627\u0642\u0639\u0629\"},\n\t{\"surah\":\"57\", \"name\": \"\u0627\u0644\u062d\u062f\u064a\u062f\"},\n\t{\"surah\":\"58\", \"name\": \"\u0627\u0644\u0645\u062c\u0627\u062f\u0644\u0629\"},\n\t{\"surah\":\"59\", \"name\": \"\u0627\u0644\u062d\u0634\u0631\"},\n\t{\"surah\":\"60\", \"name\": \"\u0627\u0644\u0645\u0645\u062a\u062d\u0646\u0629\"},\n\t{\"surah\":\"61\", \"name\": \"\u0627\u0644\u0635\u0641\"},\n\t{\"surah\":\"62\", \"name\": \"\u0627\u0644\u062c\u0645\u0639\u0629\"},\n\t{\"surah\":\"63\", \"name\": \"\u0627\u0644\u0645\u0646\u0627\u0641\u0642\u0648\u0646\"},\n\t{\"surah\":\"64\", \"name\": \"\u0627\u0644\u062a\u063a\u0627\u0628\u0646\"},\n\t{\"surah\":\"65\", \"name\": \"\u0627\u0644\u0637\u0644\u0627\u0642\"},\n\t{\"surah\":\"66\", \"name\": \"\u0627\u0644\u062a\u062d\u0631\u064a\u0645\"},\n\t{\"surah\":\"67\", \"name\": \"\u0627\u0644\u0645\u0644\u0643\"},\n\t{\"surah\":\"68\", \"name\": \"\u0627\u0644\u0642\u0644\u0645\"},\n\t{\"surah\":\"69\", \"name\": \"\u0627\u0644\u062d\u0627\u0642\u0629\"},\n\t{\"surah\":\"70\", \"name\": \"\u0627\u0644\u0645\u0639\u0627\u0631\u062c\"},\n\t{\"surah\":\"71\", \"name\": \"\u0646\u0648\u062d\"},\n\t{\"surah\":\"72\", \"name\": \"\u0627\u0644\u062c\u0646\"},\n\t{\"surah\":\"73\", \"name\": \"\u0627\u0644\u0645\u0632\u0645\u0644\"},\n\t{\"surah\":\"74\", \"name\": \"\u0627\u0644\u0645\u062f\u062b\u0631\"},\n\t{\"surah\":\"75\", \"name\": \"\u0627\u0644\u0642\u064a\u0627\u0645\u0629\"},\n\t{\"surah\":\"76\", \"name\": \"\u0627\u0644\u0627\u0646\u0633\u0627\u0646\"},\n\t{\"surah\":\"77\", \"name\": \"\u0627\u0644\u0645\u0631\u0633\u0644\u0627\u062a\"},\n\t{\"surah\":\"78\", \"name\": \"\u0627\u0644\u0646\u0628\u0625\"},\n\t{\"surah\":\"79\", \"name\": \"\u0627\u0644\u0646\u0627\u0632\u0639\u0627\u062a\"},\n\t{\"surah\":\"80\", \"name\": \"\u0639\u0628\u0633\"},\n\t{\"surah\":\"81\", \"name\": \"\u0627\u0644\u062a\u0643\u0648\u064a\u0631\"},\n\t{\"surah\":\"82\", \"name\": \"\u0627\u0644\u0625\u0646\u0641\u0637\u0627\u0631\"},\n\t{\"surah\":\"83\", \"name\": \"\u0627\u0644\u0645\u0637\u0641\u0641\u064a\u0646\"},\n\t{\"surah\":\"84\", \"name\": \"\u0627\u0644\u0625\u0646\u0634\u0642\u0627\u0642\"},\n\t{\"surah\":\"85\", \"name\": \"\u0627\u0644\u0628\u0631\u0648\u062c\"},\n\t{\"surah\":\"86\", \"name\": \"\u0627\u0644\u0637\u0627\u0631\u0642\"},\n\t{\"surah\":\"87\", \"name\": \"\u0627\u0644\u0623\u0639\u0644\u0649\"},\n\t{\"surah\":\"88\", \"name\": \"\u0627\u0644\u063a\u0627\u0634\u064a\u0629\"},\n\t{\"surah\":\"89\", \"name\": \"\u0627\u0644\u0641\u062c\u0631\"},\n\t{\"surah\":\"90\", \"name\": \"\u0627\u0644\u0628\u0644\u062f\"},\n\t{\"surah\":\"91\", \"name\": \"\u0627\u0644\u0634\u0645\u0633\"},\n\t{\"surah\":\"92\", \"name\": \"\u0627\u0644\u0644\u064a\u0644\"},\n\t{\"surah\":\"93\", \"name\": \"\u0627\u0644\u0636\u062d\u0649\"},\n\t{\"surah\":\"94\", \"name\": \"\u0627\u0644\u0634\u0631\u062d\"},\n\t{\"surah\":\"95\", \"name\": \"\u0627\u0644\u062a\u064a\u0646\"},\n\t{\"surah\":\"96\", \"name\": \"\u0627\u0644\u0639\u0644\u0642\"},\n\t{\"surah\":\"97\", \"name\": \"\u0627\u0644\u0642\u062f\u0631\"},\n\t{\"surah\":\"98\", \"name\": \"\u0627\u0644\u0628\u064a\u0646\u0629\"},\n\t{\"surah\":\"99\", \"name\": \"\u0627\u0644\u0632\u0644\u0632\u0644\u0629\"},\n\t{\"surah\":\"100\", \"name\": \"\u0627\u0644\u0639\u0627\u062f\u064a\u0627\u062a\"},\n\t{\"surah\":\"101\", \"name\": \"\u0627\u0644\u0642\u0627\u0631\u0639\u0629\"},\n\t{\"surah\":\"102\", \"name\": \"\u0627\u0644\u062a\u0643\u0627\u062b\u0631\"},\n\t{\"surah\":\"103\", \"name\": \"\u0627\u0644\u0639\u0635\u0631\"},\n\t{\"surah\":\"104\", \"name\": \"\u0627\u0644\u0647\u0645\u0632\u0629\"},\n\t{\"surah\":\"105\", \"name\": \"\u0627\u0644\u0641\u064a\u0644\"},\n\t{\"surah\":\"106\", \"name\": \"\u0642\u0631\u064a\u0634\"},\n\t{\"surah\":\"107\", \"name\": \"\u0627\u0644\u0645\u0627\u0639\u0648\u0646\"},\n\t{\"surah\":\"108\", \"name\": \"\u0627\u0644\u0643\u0648\u062b\u0631\"},\n\t{\"surah\":\"109\", \"name\": \"\u0627\u0644\u0643\u0627\u0641\u0631\u0648\u0646\"},\n\t{\"surah\":\"110\", \"name\": \"\u0627\u0644\u0646\u0635\u0631\"},\n\t{\"surah\":\"111\", \"name\": \"\u0627\u0644\u0645\u0633\u062f\"},\n\t{\"surah\":\"112\", \"name\": \"\u0627\u0644\u0625\u062e\u0644\u0627\u0635\"},\n\t{\"surah\":\"113\", \"name\": \"\u0627\u0644\u0641\u0644\u0642\"},\n\t{\"surah\":\"114\", \"name\": \"\u0627\u0644\u0646\u0627\u0633\"}\n]}";
