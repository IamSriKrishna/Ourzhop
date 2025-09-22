class ProductVariant {
  final String id;
  final String weight;
  final String price;
  final String originalPrice;
  final String? discount;

  ProductVariant({
    required this.id,
    required this.weight,
    required this.price,
    required this.originalPrice,
    this.discount,
  });
}

class Product {
  final String id;
  final String name;
  final String image;
  final List<ProductVariant> variants;
  final bool hasDiscount;
  final String? discountPercentage;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.variants,
    this.hasDiscount = false,
    this.discountPercentage,
  });
}

final List<Product> products = [
  Product(
    id: 'country_delight_1',
    name: 'Country Delight\nGhar Jaisa Cup C...',
    image: '🥛',
    hasDiscount: true,
    discountPercentage: '50% Off',
    variants: [
      ProductVariant(
        id: 'country_delight_250g',
        weight: '250g',
        price: '₹35',
        originalPrice: '₹70',
        discount: '50% Off',
      ),
      ProductVariant(
        id: 'country_delight_500g',
        weight: '500g',
        price: '₹70',
        originalPrice: '₹140',
        discount: '50% Off',
      ),
      ProductVariant(
        id: 'country_delight_1kg',
        weight: '1kg',
        price: '₹130',
        originalPrice: '₹260',
        discount: '50% Off',
      ),
    ],
  ),
  Product(
    id: 'amul_masti_pouch',
    name: 'Amul Masti Pouch\nCurd',
    image: '🥛',
    variants: [
      ProductVariant(
        id: 'amul_pouch_500g',
        weight: '500g',
        price: '₹70',
        originalPrice: '₹140',
      ),
    ],
  ),
  Product(
    id: 'mother_dairy_1',
    name: 'Mother Dairy\nClassic Cup Curd',
    image: '🥛',
    hasDiscount: true,
    discountPercentage: '50% Off',
    variants: [
      ProductVariant(
        id: 'mother_dairy_200g',
        weight: '200g',
        price: '₹25',
        originalPrice: '₹50',
        discount: '50% Off',
      ),
      ProductVariant(
        id: 'mother_dairy_500g',
        weight: '500g',
        price: '₹30',
        originalPrice: '₹60',
        discount: '50% Off',
      ),
      ProductVariant(
        id: 'mother_dairy_1kg',
        weight: '1kg',
        price: '₹55',
        originalPrice: '₹110',
        discount: '50% Off',
      ),
    ],
  ),
  Product(
    id: 'amul_masti_cup',
    name: 'Amul Masti Cup\nCurd',
    image: '🥛',
    variants: [
      ProductVariant(
        id: 'amul_cup_500ml',
        weight: '500ml',
        price: '₹190',
        originalPrice: '₹190',
      ),
      ProductVariant(
        id: 'amul_cup_1ltr',
        weight: '1 ltr (Pack of 2)',
        price: '₹385',
        originalPrice: '₹385',
      ),
    ],
  ),
  Product(
    id: 'nestle_a_plus',
    name: 'Nestle a+\nUnsweetened Gre...',
    image: '🥛',
    variants: [
      ProductVariant(
        id: 'nestle_500g',
        weight: '500g',
        price: '₹385',
        originalPrice: '₹385',
      ),
    ],
  ),
  Product(
    id: 'epigamia_natural',
    name: 'epigamia Natural\nGreek Yogurt',
    image: '🥛',
    variants: [
      ProductVariant(
        id: 'epigamia_500ml',
        weight: '500ml',
        price: '₹190',
        originalPrice: '₹190',
      ),
      ProductVariant(
        id: 'epigamia_1ltr',
        weight: '1 ltr (Pack of 2)',
        price: '₹385',
        originalPrice: '₹385',
      ),
    ],
  ),
];
