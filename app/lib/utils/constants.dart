import 'package:flutter/foundation.dart';

String get BASE_URL =>
    kReleaseMode
        ? 'https://rxyz-app-814908101471.northamerica-northeast1.run.app'
        : (kIsWeb ? 'http://localhost' : 'http://10.0.2.2');
