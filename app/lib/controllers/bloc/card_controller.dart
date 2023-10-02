import 'package:app/repositories/cards_repository.dart';
import 'package:app/services/requests/post_requests/create_virtual_card_request.dart';
import 'package:app/services/requests/post_requests/fund_virtual_card.dart';
import 'package:app/services/requests/put_requests/change_pin_request.dart';
import 'package:app/services/responses/card_details_response.dart';
import 'package:app/services/responses/create_virtual_card_response.dart';
import 'package:app/services/responses/fund_virtual_card_response.dart';

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
      return Future.error(e);
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
      return Future.error(e);
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
      return Future.error(e);
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
      return Future.error(e);
    }
  }
}
