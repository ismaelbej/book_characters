import 'package:uuid/uuid.dart';

import '../entities/author.dart';

class NewAuthorUseCase {
  static const uuid = Uuid();

  NewAuthorUseCase();

  Author call() {
    return Author(id: uuid.v4(), name: "", image: "");
  }
}
