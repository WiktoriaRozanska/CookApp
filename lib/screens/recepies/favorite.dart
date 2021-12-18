import 'package:cook_app/components/categories_drawer.dart';
import 'package:cook_app/components/recipe/recipe_icon.dart';
import 'package:cook_app/models/recipe_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/recipe.dart' as RecipeProvider;

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  static const _pageSize = 5;
  final PagingController<int, RecipeItem> _pagingController =
      PagingController(firstPageKey: 0);
  RecipeProvider.Recipe? _recipeProvider;

  @override
  void initState() {
    _recipeProvider =
        Provider.of<RecipeProvider.Recipe>(context, listen: false);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await _recipeProvider!.fetchFavoriteRecipes(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: PagedListView<int, RecipeItem>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<RecipeItem>(
          itemBuilder: (context, item, index) => RecipeIcon(recipeItem: item),
        ),
      ),
    );
  }
}
