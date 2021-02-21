class Destination {
  String image;
  String name;
  String description;
  String countries;

  Destination({
    this.image,
    this.name,
    this.description,
    this.countries,
  });
}

final List<Destination> destinations = [
  Destination(
      image: 'assets/images/asia.jpg',
      name: 'ASIA',
      description:
      'You\'ll have seen a thousand photographs of the Pyramids of Giza by the time you finally get here, but nothing beats getting up-close-and-personal with these ancient monuments. Egypt\'s most famed and feted structures, these ancient tombs of kings guarded by the serene Sphinx have wowed spectators for centuries.',
      countries: 'asia',
  ),
  Destination(
      image: 'assets/images/middleeast.jpg',
      name: 'MIDDLE EAST',
      description:
      'Located just south of the Indian subcontinent, the Maldives are a gorgeous chain of islands in the Indian Ocean-Arabian Sea area consisting of 26 atolls. Travel to the Maldives and see why the islands have become so popular in recent decades (especially as a honeymoon destination) and why Maldives travel is always an unforgettable experience.',
    countries: 'middleeast',
  ),
  Destination(
      image: 'assets/images/europe.jpg',
      name: 'EUROPE',
      description:
      'The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France. It is named after the engineer Gustave Eiffel, whose company designed and built the tower.',
    countries: 'middleeast',
  ),
  Destination(
      image: 'assets/images/australia.jpg',
      name: 'AUSTRALIA',
      description:
      'Venice and its mainland are particularly rich of museums and historical buildings of great artistic and cultural importance. Here you can choose among a wide variety of museums, churches, palaces and villas, Venice historic centre, the famous islands of Murano and Burano, the villas along the Brenta river and the beautiful landscapes the Miranese area, and of course less famous islands in Venice Lagoon.',
    countries: 'middleeast',),
  Destination(
      image: 'assets/images/northamerica.jpg',
      name: 'NORTH AMERICA',
      description:
      'Golden beaches and lush mountains, samba-fueled nightlife and spectacular football matches: welcome to the Cidade Maravilhosa (Marvelous City).',
    countries: 'middleeast',),

  Destination(
      image: 'assets/images/southamerica.jpg',
      name: 'SOUTH AMERICA',
      description:
      'Golden beaches and lush mountains, samba-fueled nightlife and spectacular football matches: welcome to the Cidade Maravilhosa (Marvelous City).'
  , countries: 'middleeast',),

];