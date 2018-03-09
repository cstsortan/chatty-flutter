import 'package:flutter/material.dart';

typedef Widget ViewModelBuilder<T>(BuildContext context, T model);
typedef Widget ViewModelBuilderWithAction<T>(BuildContext context, T model, Function function);