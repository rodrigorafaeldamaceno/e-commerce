import 'package:ecommerce/tabs/CategoryTab.dart';
import 'package:ecommerce/tabs/HomeTab.dart';
import 'package:ecommerce/tabs/OrdersTab.dart';
import 'package:ecommerce/tabs/PlacesTab.dart';
import 'package:ecommerce/widgets/CartButton.dart';
import 'package:ecommerce/widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics:
          //evita que o usuario possa arrastar para o lado
          NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CategoryTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Lojas'),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Meus pedidos'),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
