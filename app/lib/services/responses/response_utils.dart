// // Function to parse the phone number from the response message
// String extractPhoneNumberFromResponse(String responseMessage) {
//   // Assuming the response message format is consistent
//   RegExp phoneNumberRegExp = RegExp(r'\d+');  // Extracts all digits
//   Match phoneNumberMatch = phoneNumberRegExp.firstMatch(responseMessage) as Match;
//   if (phoneNumberMatch != null) {
//     return phoneNumberMatch.group(0)!;  // Extracted phone number
//   } else {
//     return '';  // Return an empty string or handle as needed
//   }
// }

// // Usage
// String responseMessage = "User created successfully. Otp sent to 07056833529 for account verification.";
// String phoneNumber = extractPhoneNumberFromResponse(responseMessage);

// if (phoneNumber.isNotEmpty) {
//   // Initiate OTP verification using the extracted phone number
//   initiateOtpVerificationUsingPhoneNumber(phoneNumber);
// } else {
//   // Handle case where phone number extraction failed
// }
