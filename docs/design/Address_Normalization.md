# Address Normalization #

YAAddressInfo is always used to identify a participant's address when adding a participant to a conversation, whether upon original conversation creation or later editing.

To ensure proper handling of addresses, **YAAddressInfo objects must always contain fully normalized addresses.**

## AddressInfoCreator ##

Always use AddressInfoCreator to create YAAddressInfo objects. It ensures consistent normalization, and its use lays the foundation for supporting multiple transports (SMS, MMC, email). It gives us just one place that we have to get all this address handling correct.

AddressInfoCreator offers methods to create proper YAAddressInfo objects when you have:

   * a YAAddress
   * a YAMMCParticipant
   * a raw (from Contacts or direct user input) phone number
   * a YE.164-formatted phone number (see `Phone_Number_Normalization.md`)

When we add new address type primitives (email addresses, registration info post MMC/email reg), we will add new methods to AddressInfo to accept those primitives, instead of having other classes handle address details.