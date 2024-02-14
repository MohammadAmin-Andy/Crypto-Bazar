import 'package:flutter/material.dart';
import 'package:network_project/data/model/crypto.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, this.cryptoList});
  List<Crypto>? cryptoList;
  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;
  @override
  void initState() {
    //String username = '';
    // TODO: implement initState
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: cryptoList!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                color: Colors.red,
                child: Center(
                  child: Text(
                    cryptoList![index].name,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
