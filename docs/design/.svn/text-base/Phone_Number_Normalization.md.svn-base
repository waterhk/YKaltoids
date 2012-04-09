# Phone Number Normalization #


## Normalization Formats ##

[E.164] is an industry standard phone number format. E.164 numbers begin with a `+`, followed by all digits with no formatting, for example: `+14044953456`.

The MMC APIs require phone numbers to be formatted in YE.164 (I'm making that name up), which is the same as E.164 except without the prefixing `+`, for example: `14044953456`.


## Double-Normalization Corruption ##

YE.164 normalization is not [idempotent]. Normalizing a YE.164-normalized number for a non-US locale gives an incorrect result:

	YE.164("+1-408-349-6764", "IN") => 14083496764
	YE.164(YE.164("+1-408-349-6764", "IN"), "IN") => 9114083496764

In Android Hub, we didn't recognize this problem at first, and phone numbers were sometimes stored normalized, sometimes raw. This led to much consternation as numbers were corrupted through double normalization here and there.

Double-normalization corruption is the primary reason we need a systematic way to handle raw and YE.164-formatted phone numbers.


## Approach ##

Phone numbers are just one of Hub's multiple address types. See `Address_Normalization.md` for our overall approach of using YAAddressInfo and AddressInfoCreator to properly handle addresses throughout the codebase.


## Normalization Library ##

For Android Hub, we used Google's [libphonenumber].

I don't see binary distributions of the C++ libphonenumber library, so we probably have to build it from source. We should build it as a static library that we then link into the altoids and altoidsTest targets. Apparently this may not be completely straightforward; see [issue 95], [issue 25].



[E.164]: http://en.wikipedia.org/wiki/E.164
[idempotent]: http://en.wikipedia.org/wiki/Idempotence
[libphonenumber]: http://code.google.com/p/libphonenumber/
[issue 95]: http://code.google.com/p/libphonenumber/issues/detail?id=95
[issue 25]: http://code.google.com/p/libphonenumber/issues/detail?id=25
