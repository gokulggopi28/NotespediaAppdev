class LocalCartModel {
  LocalCartModel({
    required this.index,
    required this.title,
    required this.author,
    required this.hardCopyPrice,
    required this.softCopyPrice,
    required this.imageUrl,
    required this.categories,
  });

  final int index;
  final String title;
  final String author;
  final double hardCopyPrice;
  final double softCopyPrice;
  final String imageUrl;
  final List<String> categories;
}

List<LocalCartModel> localCartItemsList = [
  LocalCartModel(
    index: 1,
    title: 'Elite Anatomy',
    author: 'Tony Stark',
    softCopyPrice: 649.0,
    hardCopyPrice: 549.0,
    imageUrl:
        "https://marketplace.canva.com/EAFPHUaBrFc/1/0/1003w/canva-black-and-white-modern-alone-story-book-cover-QHBKwQnsgzs.jpg",
    categories: ['Anatomy', 'High-Yield', 'Last Minute Revision'],
  ),
  LocalCartModel(
    index: 2,
    title: 'Elite Anatomy',
    author: 'Tony Stark',
    softCopyPrice: 799.0,
    hardCopyPrice: 549.0,
    imageUrl:
        "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/yellow-business-leadership-book-cover-design-template-dce2f5568638ad4643ccb9e725e5d6ff_screen.jpg?ts=1637017516",
    categories: ['Anatomy', 'High-Yield', 'Last Minute Revision'],
  ),
  // CartModel(
  //   index: 3,
  //   title: 'Elite Anatomy',
  //   author: 'Tony Stark',
  //   softCopyPrice: 649.0,
  //   hardCopyPrice: 549.0,
  //   imageUrl:
  //       "https://www.adobe.com/express/create/cover/media_19d5e212dbe8553614c3a9fbabd4d7f219ab01c85.png?width=750&format=png&optimize=medium",
  //   categories: ['Anatomy', 'High-Yield', 'Last Minute Revision'],
  // ),
  // CartModel(
  //   index: 4,
  //   title: 'Elite Anatomy',
  //   author: 'Tony Stark',
  //   softCopyPrice: 500.0,
  //   hardCopyPrice: 549.0,
  //   imageUrl:
  //       "https://i.pinimg.com/564x/01/ba/52/01ba5280ed11b9c00fc9a909374401bc.jpg",
  //   categories: ['Anatomy', 'High-Yield', 'Last Minute Revision'],
  // ),
  // CartModel(
  //   index: 5,
  //   title: 'Elite Anatomy',
  //   author: 'Tony Stark',
  //   softCopyPrice: 400.0,
  //   hardCopyPrice: 549.0,
  //   imageUrl:
  //       "https://marketplace.canva.com/EAFPHUaBrFc/1/0/1003w/canva-black-and-white-modern-alone-story-book-cover-QHBKwQnsgzs.jpg",
  //   categories: ['Anatomy', 'High-Yield', 'Last Minute Revision'],
  // ),
];
