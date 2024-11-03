part of 'auth_bloc.dart';

// Events -- > // state

/*

This is the event and state for the client signup screen

*/

final class ClinetSignupButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;
  final XFile profilePhoto;
  final String name;

  ClinetSignupButtonPressedEvent({
    required this.email,
    required this.password,
    required this.profilePhoto,
    required this.name,
  });

  /*

  state zero is loading stage 


  ( 
    Then first checking email is verified 

    Second checked that phone is mumber is verified 

    Third check all the validation 


    Note: I make the button as such all the not be validated then no event can be throw 

    so, third case is gone and for second case I remove phone number taken from the signup process 

    at last checking email verify generally happened after the user  registeration 
    so, I will add this is after that ok.

  )

    If UX decided to change it currently I am using the failure state but it will just open the diaglog in UI
    but if we need to change something else then we need to add more state and UI will change according the desire OK.


    For example if we need to show case a animation make it red the textfield and moving verify button to click me first then we will 
    add more state like 

    ```dart

    final class EmailVerificationFailureState extends AuthState {}

    ```

    then change accordingly in the UI

  async process for the to registering the user firebase and creating collections

  then navigate the user to the home screen if all good.

  */
}

final class ClientSignupLoadingState extends AuthState {}

final class ClientSignupSuccessState extends AuthState {}

final class ClientSignupFailureState extends AuthState {
  final String message;

  ClientSignupFailureState(this.message);
}

// Image Picker Event and State
final class ImagePickerButtonPressedEvent extends AuthEvent {}

final class ImagePickerLoadingState extends AuthState {}

final class ImagePickerSuccessState extends AuthState {
  final XFile image;

  ImagePickerSuccessState(this.image);
}

final class ImagePickerFailureState extends AuthState {
  final String message;

  ImagePickerFailureState(this.message);
}
