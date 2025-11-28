import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recipe.dart';
import '../data/recipe_data.dart';
import 'user_provider.dart';

// State untuk menyimpan resep 
final recipesProvider = StateProvider<List<Recipe>>((ref) => initialRecipes);

// State untuk kategori yang dipilih
final selectedCategoryProvider = StateProvider<String>((ref) => 'Semua');

// State untuk query pencarian
final searchQueryProvider = StateProvider<String>((ref) => '');


// State untuk filter favorit
final showOnlyFavoritesProvider = StateProvider<bool>((ref) => false);

// State untuk menyimpan resep yang terakhir diedit (History)
  // Menggunakan List<Recipe> untuk menyimpan daftar riwayat
  final historyProvider = StateProvider<List<Recipe>>((ref) => []);

  // State untuk mengelola indeks tab yang aktif di Bottom Nav Bar
  final currentTabIndexProvider = StateProvider<int>((ref) => 0); // 0 = Home
  
// Provider computed untuk resep yang difilter
final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final recipes = ref.watch(recipesProvider);
  final category = ref.watch(selectedCategoryProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
  final favorites = ref.watch(favoritesProvider);
  final showOnlyFavorites = ref.watch(showOnlyFavoritesProvider);
  

  var filteredRecipes = recipes;
  
  // Filter berdasarkan kategori
  if (category != 'Semua') {
    filteredRecipes = filteredRecipes.where((r) => r.category == category).toList();
  }
  
  // Filter berdasarkan pencarian
  if (searchQuery.isNotEmpty) {
    filteredRecipes = filteredRecipes.where((r) => 
      r.name.toLowerCase().contains(searchQuery) ||
      r.description.toLowerCase().contains(searchQuery)
    ).toList();
  }
  
  // Filter hanya favorit
  if (showOnlyFavorites) {
    filteredRecipes = filteredRecipes.where((r) => favorites.contains(r.id)).toList();
  }
  
  return filteredRecipes;
});