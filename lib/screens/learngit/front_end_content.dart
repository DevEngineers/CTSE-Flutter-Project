import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../model/content_model.dart';
import '../../services/content_api_service.dart';
import 'content_item_frontend.dart';

class FrontEndContent extends StatefulWidget {
  const FrontEndContent({Key? key}) : super(key: key);

  @override
  _FrontEndContentState createState() => _FrontEndContentState();
}

class _FrontEndContentState extends State<FrontEndContent> {
  List<ContentModel> products = List<ContentModel>.empty(growable: true);
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        // child: productList(products),
        child: loadProducts(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

  Widget loadProducts() {
    return FutureBuilder(
      future: APIService.getContent(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ContentModel>?> model,
      ) {
        if (model.hasData) {
          return productList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productList(products) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return FrontEndItem(
                    model: products[index],
                    onDelete: (ContentModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
