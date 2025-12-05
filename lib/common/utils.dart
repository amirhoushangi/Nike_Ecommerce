import 'package:flutter/material.dart';

const defaultScrollPhysics = BouncingScrollPhysics();

extension PriceLable on int {
  String get withPriceLable => '$this تومان ';
}
