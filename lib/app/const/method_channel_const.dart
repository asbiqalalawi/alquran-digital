import 'package:flutter/services.dart';

/// The platform channel used to communicate with the native code.
/// The  of the method channel MUST match the name of the channel
/// defined on the native side.
const platform = MethodChannel('samples.invertase.io/biometrics');