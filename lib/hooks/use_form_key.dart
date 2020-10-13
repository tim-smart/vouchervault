import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<FormBuilderState> useFormKey() =>
    useMemoized(() => GlobalKey<FormBuilderState>());
