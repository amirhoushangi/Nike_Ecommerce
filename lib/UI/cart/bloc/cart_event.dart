part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;

  const CartStarted(this.authInfo);
}

class CartDeleteButton extends CartEvent {
  final int cartItemId;

  const CartDeleteButton(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}

class CartAuthInfoChanged extends CartEvent {
  final AuthInfo? authInfo;

  const CartAuthInfoChanged(this.authInfo);
}
