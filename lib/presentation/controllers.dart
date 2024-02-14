import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controllers/authors_page_controller.dart';
import 'controllers/authors_page_state.dart';

final authorsPageController =
    AsyncNotifierProvider<AuthorsPageController, AuthorsPageState>(() {
  return AuthorsPageController();
});
