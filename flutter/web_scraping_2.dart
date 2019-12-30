import 'package:html/parser.dart';

import 'dart:io';
import 'dart:convert';

void transCode(String x) async {
    var req = await _client
        .getUrl(Uri.parse(x));
    var resp = await req.close();
    var pge = await resp.toList();
    var bdy = parse(utf8.decode(pge[0])).body;

    print('${bdy.querySelector('issuerName').text} ${bdy.querySelector('issuerTradingSymbol').text}');
    bdy.querySelectorAll('nonDerivativeTransaction')
        .forEach((transactions) {
      print(' ${transactions
          .querySelector('transactionCode')
          .text} ${transactions
          .querySelector('transactionShares')
          .text
          .trim()}');
    });

  }

  void reportList(String x) async {

      var req = await _client
          .getUrl(Uri.parse(x));
      var resp = await req.close();
      var pge = await resp.toList();
      var bdy = parse(utf8.decode(pge[0])).body;
      
      bdy.querySelectorAll('entry').forEach((entries){
        if (entries.querySelector('title').text.contains(('(Issuer)'))) {
          print('${entries
              .querySelector('title')
              .text}');
          xmlFileAddress('${entries.querySelector('link').attributes['href']}');

        }
      });
    }

  void xmlFileAddress(String x) async{
    var req = await _client
        .getUrl(Uri.parse(x));
    var resp = await req.close();
    var pge = await resp.toList();

    var bdy = parse(utf8.decode(pge[1])).body;
    
    //print('https://abc.com${bdy.querySelectorAll('a')[1].attributes['href']}');
    transCode('https://abc.com${bdy.querySelectorAll('a')[1].attributes['href']}');

  }

//**********************************************************************************


  void transCode(String x) async {
    var req = await _client
        .getUrl(Uri.parse(x));
    var resp = await req.close();
    var pge = await resp.toList();
    var bdy = parse(utf8.decode(pge[0])).body;

    print('${bdy.querySelector('issuerName').text} ${bdy.querySelector('issuerTradingSymbol').text}');
    bdy.querySelectorAll('nonDerivativeTransaction')
        .forEach((transactions) {
      if (transactions
          .querySelector('transactionCode')
          .text == tranCode)
      print(' ${transactions
          .querySelector('transactionCode')
          .text} ${transactions
          .querySelector('transactionShares')
          .text
          .trim()}');
    });

  }

  void reportList(String x) async {

      var req = await _client
          .getUrl(Uri.parse(x));
      var resp = await req.close();
      var pge = await resp.toList();
      var bdy = parse(utf8.decode(pge[0])).body;
      
      bdy.querySelectorAll('entry').forEach((entries){
        if (entries.querySelector('title').text.contains(('(Issuer)'))) {
          print('${entries
              .querySelector('title')
              .text}');
          xmlFileAddress('${entries.querySelector('link').attributes['href']}');

        }
      });
    }

  void xmlFileAddress(String x) async{
    var req = await _client
        .getUrl(Uri.parse(x));
    var resp = await req.close();
    var pge = await resp.toList();

    var bdy = parse(utf8.decode(pge[1])).body;
    //print('https://abc.com${bdy.querySelectorAll('a')[1].attributes['href']}');  
    transCode('https://abc.com${bdy.querySelectorAll('a')[1].attributes['href']}');

  }
