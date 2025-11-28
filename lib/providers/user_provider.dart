// lib/providers/user_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

// State untuk menyimpan nama pengguna yang sudah login
final userNameProvider = StateProvider<String?>((ref) => null);

// State untuk view mode (grid atau list) - Dipindahkan dari recipe_providers.dart
enum ViewMode { grid, list }
final viewModeProvider = StateProvider<ViewMode>((ref) => ViewMode.grid);

// State untuk filter favorit (Set ID) - Dipindahkan dari recipe_providers.dart
final favoritesProvider = StateProvider<Set<String>>((ref) => {});