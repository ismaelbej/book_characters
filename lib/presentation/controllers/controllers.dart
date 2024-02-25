import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authors/authors_controller.dart';
import 'authors/authors_state.dart';

final authorsPageController =
    AsyncNotifierProvider<AuthorsController, AuthorsState>(() {
  return AuthorsController();
});
