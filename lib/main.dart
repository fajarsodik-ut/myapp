import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comic E-commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> comics = [
    {
      'title': 'One Thousand Eternity Woman',
      'price': 149000,
      'imageAsset': 'assets/images/image-1.jpg',
    },
    {
      'title': 'OnePiece Bootleg Vertion',
      'price': 135000,
      'imageAsset': 'assets/images/image-2.jpg',
    },
    {
      'title': 'Moon Goddes & Mulyono Family',
      'price': 120000,
      'imageAsset': 'assets/images/image-3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comic Shop Bootleg Version',
          textAlign: TextAlign.center, // Align text to center horizontally
        ),
        centerTitle: true, // Center the title within the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: comics.length,
          itemBuilder: (context, index) {
            return ComicItem(
              title: comics[index]['title'],
              price: comics[index]['price'],
              imageAsset: comics[index]['imageAsset'],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: const Icon(Icons.shopping_cart),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ComicItem extends StatelessWidget {
  final String title;
  final int price;
  final String imageAsset;

  const ComicItem({
    required this.title,
    required this.price,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Image.asset(
          imageAsset,
          width: 50,
          height: 75,
          fit: BoxFit.cover,
        ),
        title: Text(title),
        subtitle: Text(currencyFormat.format(price)),
        trailing: AddToCartButton(),
      ),
    );
  }
}

class AddToCartButton extends StatefulWidget {
  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isInCart = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isInCart ? Icons.check : Icons.add_shopping_cart,
        color: _isInCart ? Colors.green : Colors.blue,
      ),
      onPressed: () {
        setState(() {
          _isInCart = !_isInCart;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isInCart ? 'Ditambahkan ke keranjang' : 'Dihapus dari keranjang',
            ),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.blue,
          ),
        );
      },
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: const Center(
        child: Text('Keranjang belanja Anda kosong'),
      ),
    );
  }
}
