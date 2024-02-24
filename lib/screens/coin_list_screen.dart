import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:network_project/data/constant/constans.dart';
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
      appBar: AppBar(
        backgroundColor: blackColor,
        title: Text(
          'کیریپتو بازار',
          style: TextStyle(
            fontFamily: 'Mh',
            color: grayColor,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: blackColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getSearchBar(),
          Expanded(
            child: RefreshIndicator(
              backgroundColor: greenColor,
              color: blackColor,
              child: ListView.builder(
                itemCount: cryptoList!.length,
                itemBuilder: (context, index) {
                  return _getListTileItem(
                    cryptoList![index],
                  );
                },
              ),
              onRefresh: () async {
                List<Crypto> freshData = await _getData();
                setState(() {
                  cryptoList = freshData;
                });
                // Replace this delay with the code to be executed during refresh
                // and return asynchronous code
                return Future<void>.delayed(
                  const Duration(seconds: 3),
                );
              },
            ),
          )
        ],
      )),
    );
  }

  Widget _getListTileItem(Crypto crypto) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(
          fontFamily: 'Mh',
          color: greenColor,
        ),
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(
          color: grayColor,
        ),
      ),
      leading: SizedBox(
        width: 30,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(
              color: grayColor,
            ),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  crypto.priceUsd.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 18,
                    color: grayColor,
                  ),
                ),
                Text(
                  crypto.changePercent24Hr.toStringAsFixed(2),
                  style: TextStyle(
                    color: _getColorChangeText(crypto.changePercent24Hr),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 30,
              child: Center(
                child: _getIconChangePercent(
                  crypto.changePercent24Hr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconChangePercent(double percentChange) {
    return percentChange <= 0
        ? Icon(
            Icons.trending_down,
            size: 24,
            color: redColor,
          )
        : Icon(
            Icons.trending_up,
            size: 24,
            color: greenColor,
          );
  }

  Color _getColorChangeText(double percentChange) {
    return percentChange <= 0 ? redColor : greenColor;
  }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    return cryptoList;
  }

  Widget _getSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          onChanged: (value) {
            _filterlist(value);
          },
          cursorColor: blackColor,
          //textAlign: TextAlign.end,
          decoration: InputDecoration(
            hintText: 'اسم رمز ارز معتبر را سرچ کنید',
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Mh',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: greenColor,
          ),
        ),
      ),
    );
  }

  Future<void> _filterlist(String enteredKeyword) async {
    List<Crypto> cryptoResultList = [];
    if (enteredKeyword.isEmpty) {
      var result = await _getData();
      setState(() {
        cryptoList = result;
      });
      return;
    }

    cryptoResultList = cryptoList!.where((element) {
      return element.name.toLowerCase().contains(enteredKeyword.toLowerCase());
    }).toList();
    setState(() {
      cryptoList = cryptoResultList;
    });
  }
}
