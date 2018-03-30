class Menu {
  final List<MenuItem> items;

  Menu({
    this.items,
  });
}

class MenuItem {
  final String id;
  final String title;

  MenuItem({
    this.id,
    this.title,
  });
}