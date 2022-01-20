import 'package:get/get.dart';
import 'package:halloween_stories/app/core/values/languages/en_us.dart';
import 'package:halloween_stories/app/core/values/languages/pt_br.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'pt_BR': ptBr,
      };
}
