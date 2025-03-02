 
 import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
 
 final fetchprovider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final data = await http.get(Uri.parse('https://fakestoreapi.com/products/'));
  if (data.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(data.body));
  } else {
    throw Exception('failed data fetch');
  }
});