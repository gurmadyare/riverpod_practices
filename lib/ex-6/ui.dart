import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/ex-6/film.dart';
import 'package:riverpod_practice/widgets/my_font.dart';

final films = [
  Film(
    id: '1',
    title: "The Shawshank Redemption",
    description: "Description for the Shawshank Redemtion",
    isFavorite: false,
  ),
  Film(
    id: '2',
    title: "The Godfather",
    description: "Description for the Godfather",
    isFavorite: false,
  ),
  Film(
    id: '3',
    title: "The Godfather Part II",
    description: "Description for the Godfather Part II",
    isFavorite: false,
  ),
  Film(
    id: '4',
    title: "The Dark knight",
    description: "Description for the Dark knight",
    isFavorite: false,
  ),
];

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(films);

  void update(Film film, bool isFavorite) {
    state = state
        .map((thisFilm) => thisFilm.id == film.id
            ? thisFilm.copyWith(isFavorite: isFavorite)
            : thisFilm)
        .toList();
  }
}

enum FavoriteStatus {
  all,
  favorites,
  notFavorite,
}

//providers

//FavoriteStatus
final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (ref) => FavoriteStatus.all,
);

//AllFilms
final allFilmsProvider = StateNotifierProvider<FilmsNotifier, List<Film>>(
  (ref) => FilmsNotifier(),
);

//FavoriteFilms
final favoriteFilmProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where((film) => film.isFavorite),
);

//NonFavoriteFilms
final nonFavoriteFilmProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where((film) => !film.isFavorite),
);

final class FilmUI extends StatelessWidget {
  const FilmUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          toolbarHeight: 100,
          title: const Text("Movies"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const FilterWidget(),
              const SizedBox(height: 30),
              
              Consumer(builder: (context, ref, child) {
                final filter = ref.watch(favoriteStatusProvider);

                switch (filter) {
                  case FavoriteStatus.all:
                    return FilmsList(allFilmsProvider);
                  case FavoriteStatus.favorites:
                    return FilmsList(favoriteFilmProvider);
                  case FavoriteStatus.notFavorite:
                    return FilmsList(nonFavoriteFilmProvider);
                }
              })
            ],
          ),
        ));
  }
}

final class FilmsList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsList(this.provider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);

    return Expanded(
      child: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films.elementAt(index);
          final favoriteIcon = film.isFavorite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border);

          return ListTile(
            title: MyFont(text: film.title),
            subtitle: MyFont(text: film.description),
            trailing: IconButton(
              onPressed: () {
                final isFavorite = !film.isFavorite;
                ref.read(allFilmsProvider.notifier).update(film, isFavorite);
              },
              icon: favoriteIcon,
            ),
          );
        },
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return DropdownButton(
        items: FavoriteStatus.values
            .map(
              (fs) => DropdownMenuItem(
                value: fs,
                child: MyFont(text: fs.toString().split('.').last),
              ),
            )
            .toList(),
        onChanged: (FavoriteStatus? fs) {
          ref.read(favoriteStatusProvider.notifier).state = fs!;
        },
        value: ref.watch(favoriteStatusProvider),
      );
    });
  }
}
