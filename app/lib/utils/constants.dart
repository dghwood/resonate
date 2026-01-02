import 'package:flutter/foundation.dart';

String get BASE_URL =>
    kReleaseMode
        ? 'https://app.resonates.xyz'
        : (kIsWeb ? 'https://localhost' : 'https://10.0.2.2');
