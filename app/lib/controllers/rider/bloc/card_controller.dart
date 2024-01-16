import 'package:app/repositories/rider/cards_repository.dart';
import 'package:app/services/requests/rider/post_requests/create_virtual_card_request.dart';
import 'package:app/services/requests/rider/post_requests/fund_virtual_card.dart';
import 'package:app/services/requests/rider/put_requests/change_pin_request.dart';
import 'package:app/services/responses/rider/card_details_response.dart';
import 'package:app/services/responses/rider/create_virtual_card_response.dart';
import 'package:app/services/responses/rider/fund_virtual_card_response.dart';

class CardController {
  final CardsRepository cardRepository = CardsRepository();

  Future<CreateVirtualCardResponse> createVirtualCardAsync(
      CreateVirtualCardRequest request) async {
    try {
      final response = await cardRepository.createVirtualCardAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to create card. Please try again!');
    }
  }

  Future<CardDetailsResponse> getCardDetailsAsync() async {
    try {
      final response = await cardRepository.getCardDetailsAsync();
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to fetch card details. Please try again!');
    }
  }

  Future<FundVirtualCardResponse> fundVirtualCardAsync(
      FundVirtualCardRequest request) async {
    try {
      final response = await cardRepository.fundVirtualCardAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to fund card. Please try again!');
    }
  }

  Future<CreateVirtualCardResponse> changeVirtualCardPinAsync(
      ChangePinRequest request) async {
    try {
      final response = await cardRepository.changeVirtualCardPinAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to change card pin. Please try again!');
    }
  }
}
