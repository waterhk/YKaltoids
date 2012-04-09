//
//
// lcl_config_components.h
//
//
// Copyright (c) 2008-2011 Arne Harren <ah@0xc0.de>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//
// lcl_config_components.h template.
//


//
// The lcl_config_components.h file is used to define the application's log
// components.
//
// Use the code
//
//   _lcl_component(<identifier>, <header>, <name>)
//
// for defining a log component, where
//
// - <identifier> is the unique name of a log component which is used in calls
//   to lcl_log etc. A symbol 'lcl_c<identifier>' is automatically created for
//   each log component.
//
// - <header> is a C string in UTF-8 which should be used by a logging back-end
//   when writing a log message for the log component. The header is a technical
//   key for identifying a log component's messages. It is recommended to use
//   a 'Reverse ICANN' naming scheme when the header contains grouping
//   information, e.g. 'example.main.component1'.
//
// - <name> is a C string in UTF-8 which contains the name of the log component
//   and its grouping information in a non-technical, human-readable way
//   which could be used by a user interface. Groups should be separated by the
//   path separator '/', e.g. 'Example/Main/Component 1'.
// 


//
// Components
//

#pragma mark -
#pragma mark Component definitions

_lcl_component(Default,     "application",      "Application")
_lcl_component(Conversation,     "conversation",      "Conversation")
_lcl_component(ConversationUI, "conversation.ui", "Conversation/UI")
_lcl_component(ConversationUINavigation, "conversation.ui.navigation", "Conversation/UI/Navigation")
_lcl_component(ConversationCommand, "conversation.command", "Conversation/Command")
_lcl_component(ConversationRepository, "conversation.repository", "Conversation/Repository")
_lcl_component(Message,     "message",      "Message")
_lcl_component(MessageUI, "message.ui", "Message/UI")
_lcl_component(MessageCommand, "message.command", "Message/Command")
_lcl_component(MessageRepository, "message.repository", "Message/Repository")
_lcl_component(Participant, "participant", "Participant")
_lcl_component(ParticipantUI, "participant.ui", "Participant/UI")
_lcl_component(ParticipantCommand, "participant.command", "Participant/Command")
_lcl_component(ParticipantRepository, "participant.repository", "Participant/Repository")
_lcl_component(Address, "address", "Address")
_lcl_component(AddressRepository, "address.repository", "Address/Repository")
_lcl_component(Settings, "settings", "Settings")
_lcl_component(Profile, "settings.profile", "Settings/Profile")
_lcl_component(ProfileUI, "settings.profile.ui", "Settings/Profile/UI")
_lcl_component(ProfileCommand, "settings.profile.command", "Settings/Profile/Command")
_lcl_component(ProfileRepository, "settings.profile.repository", "Settings/Profile/Repository")
_lcl_component(Contact, "contact", "Contact")
_lcl_component(ContactUI, "contact.ui", "Contact/UI")
_lcl_component(Authentication, "authentication", "Authentication")
_lcl_component(AuthenticationUI, "authentication.ui", "Authentication/UI")
_lcl_component(AuthenticationCommand, "authentication.command", "Authentication/Command")
_lcl_component(AuthenticationRepository, "authentication.repository", "Authentication/Repository")
_lcl_component(Registration, "registration", "Registration")
_lcl_component(RegistrationUI, "registration.ui", "Registration/UI")
_lcl_component(RegistrationCommand, "registration.command", "Registration/Command")
_lcl_component(RegistrationRepository, "registration.repository", "Registration/Repository")
_lcl_component(RegistrationStep, "registration.step", "Registration/Step")
_lcl_component(Command, "command", "Command")
_lcl_component(Transport, "transport", "Transport")
_lcl_component(TransportServer, "transport.server", "Transport/Server")
_lcl_component(TransportInMemory, "transport.inmemory", "Transport/InMemory")
_lcl_component(AddressBook, "addressbook", "AddressBook")
