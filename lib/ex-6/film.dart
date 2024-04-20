class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
  });

  Film copyWith({
    required bool isFavorite,
  }) =>
      Film(
        id: id,
        title: title,
        description: description,
        isFavorite: isFavorite,
      );

  @override
  String toString() => ' Film(id: $id, '
      ' title: $title,'
      ' description: $description,'
      ' isFavorite: $isFavorite)';

  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavorite == other.isFavorite;
      
  @override
  int get hashCode => Object.hashAll([id, isFavorite]);     
      
}
