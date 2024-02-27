import 'package:bloc/bloc.dart';
import 'package:ecommerce/Common/dio_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../Common/constant.dart';

part 'payment_state.dart';
@injectable
class PaymentCubit extends Cubit<PaymentState> {

  @factoryMethod PaymentCubit() : super(intialPayment());

  Future<void> getAuth() async {
    try {
      emit(LoadingAuthenticationPayment());
      var value = await DioHelper.postData("auth/tokens", {
        "api_key": api_key
      });
      AUTH_TOKEN = value.data["token"];
    await  getOrderId();
      emit(SuccssesAuthPayment());
    }
    catch (e) {
      emit(ErrorAuthPayment());
    }
  }


 Future<void> getOrderId() async {
    try {
      emit(LoadingOrderId());
      var value = await DioHelper.postData("ecommerce/orders", {
        "auth_token": AUTH_TOKEN,
        "delivery_needed": "false",
        "amount_cents": "10000",
        "currency": "EGP",
        "items": []
      });
      ORDER_ID = value.data["id"];
      emit(SuccssesOrderId());
    }
    catch (e) {
      emit(ErrorOrderId());
    }
  }
 // userName.text, lastNameController.text, emailController.text, phoneNumber.text, widget.amount.toString()
  Future<void> getRequestTokenCard(String name, String lastName, String email,
      String amount,String phone) async {
    try {
      emit(LoadingTokenPaymentCard());
      var value = await DioHelper.postData("acceptance/payment_keys", {
        "auth_token": AUTH_TOKEN,
        "amount_cents": amount,
        "expiration": "3600",
        "order_id": ORDER_ID.toString(),
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": name,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "cairo",
          "country": "EG",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": INTEGRATION_CARD_ID.toInt(),
        "lock_order_when_paid": "false"
      });
      REQUEST_TOKEN_CARD = value.data["token"];
      emit(SuccssesTokenPaymentCard());
    }
    catch (e) {
      emit(ErrorTokenPaymentCard());
    }
  }

  Future<void> getRequestTokenKiosk(String name, String lastName, String email,
      String amount,String phone) async {
    try {
      emit(LoadingTokenPaymentKiosk());
      var value = await DioHelper.postData("acceptance/payment_keys", {
        "auth_token": AUTH_TOKEN,
        "amount_cents": amount,
        "expiration": 3600,
        "order_id": ORDER_ID.toString(),
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": name,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": INTEGRATION_KIOSK_ID,
        "lock_order_when_paid": "false"
      });
      REQUEST_TOKEN_KIOSK = value.data["token"];
      emit(SuccssesKiosk());
    }
    catch (e) {
      emit(ErrorTokenKiosk());
    }
  }

  Future<void> getRefernceCode() async {
    try {
      emit(LoadingReferenceCode());
      var value = await DioHelper.postData("acceptance/payments/pay", {
        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR"
        },
        "payment_token": REQUEST_TOKEN_KIOSK
      }
      );
      REFERENCE_CODE = value.data["id"].toString();
      emit(SuccssesReferenceCode());
    }
    catch (e) {
      emit(ErrorReferenceCode());
    }
  }
}
