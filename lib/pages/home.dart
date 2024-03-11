import 'package:api_call/pages/product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var products;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio().get('https://dummyjson.com/products');
      setState(() {
        products = response.data["products"] as List;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(product: products[index]),
                    ),
                  );
                },
                leading: ClipRect(
                  child: Image.network(
                    products[index]['images'][0],
                    width: 80,
                  ),
                ),
                title: Text(products[index]['title']),
                subtitle: Text(products[index]['description']),
              ),
            );
          },
          itemCount: products == null ? 0 : products.length,
        ),
      ),
    );
  }
}
