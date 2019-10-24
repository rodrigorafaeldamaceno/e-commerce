import 'package:ecommerce/tabs/CategoryTab.dart';
import 'package:ecommerce/tabs/HomeTab.dart';
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
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Categorias'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CategoryTab(),
        )
      ],
    );
  }
}
