import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/datas/CartProduct.dart';
import 'package:ecommerce/datas/ProductData.dart';
import 'package:ecommerce/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];
  bool isLoading = false;
  String couponCode;
  int discountPercentage = 0;

  // retorno um objeto do tipo CartModel
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  CartModel(this.user) {
    if (user.isLoggedIn()) _loadCarItems();
  }

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.id = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.id)
        .delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct product) {
    product.quantity--;

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(product.id)
        .updateData(product.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct product) {
    product.quantity++;

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(product.id)
        .updateData(product.toMap());

    notifyListeners();
  }

  void _loadCarItems() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();

    products = querySnapshot.documents
        .map((doc) => CartProduct.fromDocument(doc))
        .toList();

    notifyListeners();
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discocunt = getDiscount();

    DocumentReference refOrder =
        await Firestore.instance.collection('orders').add({
      'clientId': user.firebaseUser.uid,
      'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
      'shipPrice': shipPrice,
      'productsPrice': productsPrice,
      'discount': discocunt,
      'totalPrice': productsPrice - discocunt + shipPrice,
      'status': 1
    });

    // salvando o orderId no user
    await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('orders')
        .document(refOrder.documentID)
        .setData({'orderId': refOrder.documentID});

    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();

    for (DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }

    products.clear();
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }

  void setCoupon(String couponCode, int percentage) {
    this.couponCode = couponCode;
    this.discountPercentage = percentage;
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct p in products) {
      if (p.productData != null) price += p.quantity * p.productData.price;
    }

    return price;
  }

  double getShipPrice() {
    // rever essa implementação quando o maps estiver funcionando
    return 9.99;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  void updatePrices() => notifyListeners();
}
