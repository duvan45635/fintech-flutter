
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  // Aquí debes registrar los adaptadores de Hive si usas modelos personalizados.
  // Ejemplo:
  // Hive.registerAdapter(TransactionModelAdapter());

  await Hive.openBox('user'); // Box para datos del usuario autenticado
  await Hive.openBox('transactions'); // Ingresos/gastos
}
