//
//  EmailAndPasswordView.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/16/26.
//

import SwiftUI

//MARK: Email & Password Enum
enum EmailAndPasswordEnumType {
    case email
    case password
    case confirmPassword

    var viewType: (String, String) {
        switch self {
        case .email:
            return ("Email", "Enter your email")
        case .password:
            return ("Password", "Enter your password")
        case .confirmPassword:
            return ("Confirm Password", "Confirm your password")
        }
    }
}

//MARK: Email & Password View
struct EmailAndPasswordView: View {
    @State var emailAndPasswordViewModel: EmailAndPasswordViewModel
    //    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        //        NavigationStack {
        VStack(alignment: .leading) {
            //MARK: Email Field
            emailView(.email)

            //MARK: Email Error Message Field
            emailErrorView()

            //MARK: Password Field
            PasswordView(
                .password,
                bindingType: $emailAndPasswordViewModel.password,
                type: emailAndPasswordViewModel.password
            )

            //MARK: Password Error Message Field
            PasswordErrorView()

            //MARK: Confirm Password Field
            if emailAndPasswordViewModel.isSignUpScreen {
                ConfirmPasswordView(
                    .confirmPassword,
                    bindingType: $emailAndPasswordViewModel.confirmPassword,
                    type: emailAndPasswordViewModel.confirmPassword
                )
            }

            //MARK: Email & Password Save Toggle Field
            ToggleSwitchView()

            //MARK: LogIn/SignUp Button
            LogInSignUpButtonView()

            //MARK: //MARK: Go To SignUp Or Back To LogIn Field
            goToSignUpOrBackToLogInView()
        }
        .foregroundStyle(.primary)
        //        }
    }

    //MARK: Email View
    fileprivate func emailView(
        _ emailAndPasswordEnumType: EmailAndPasswordEnumType
    ) -> some View {
        return
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Label(
                        emailAndPasswordEnumType.viewType.0,
                        systemImage: "envelope"
                    )
                    Text("*")
                        .foregroundStyle(Color(.systemRed))
                        .bold()
                }
                TextField(
                    emailAndPasswordEnumType.viewType.1,
                    text: $emailAndPasswordViewModel.email
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onChange(
                    of: emailAndPasswordViewModel.email,
                    { _, _ in
                        emailAndPasswordViewModel
                            .shouldDisplayInvalidEmailOrPasswordWarningMessages =
                            emailAndPasswordViewModel.isSignUpScreen
                            ? true : false
                    }
                )
            }
            .padding(.bottom, 10)
    }

    //MARK: Email Error View
    fileprivate func emailErrorView() -> some View {
        return
            VStack(alignment: .leading) {
                if emailAndPasswordViewModel.isSignUpScreen,
                    !emailAndPasswordViewModel.email.isEmpty,
                    !emailAndPasswordViewModel.isValidEmail()
                {
                    Text("Invalid email address")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }
    }

    //FIXME: Password View
    fileprivate func PasswordView(
        _ emailAndPasswordEnumType: EmailAndPasswordEnumType,
        bindingType: Binding<String>,
        type: String
    ) -> some View {
        return
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Label(
                        emailAndPasswordEnumType.viewType.0,
                        systemImage: "lock"
                    )
                    Text("*")
                        .foregroundStyle(Color(.systemRed))
                        .bold()
                }
                ZStack(alignment: .trailing) {
                    if emailAndPasswordViewModel.isPasswordVisible {
                        TextField(
                            emailAndPasswordEnumType.viewType.1,
                            text: bindingType
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        SecureField(
                            emailAndPasswordEnumType.viewType.1,
                            text: bindingType
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button {
                        emailAndPasswordViewModel.isPasswordVisible.toggle()
                    } label: {
                        Image(
                            systemName: emailAndPasswordViewModel
                                .isPasswordVisible
                                ? "eye.slash.fill" : "eye.fill"
                        )
                        .foregroundColor(.gray)
                    }
                }
                .onChange(
                    of: type,
                    { _, _ in
                        emailAndPasswordViewModel
                            .shouldDisplayInvalidEmailOrPasswordWarningMessages =
                            emailAndPasswordViewModel.isSignUpScreen
                            ? true : false
                    }
                )
            }
            .padding(.bottom, 10)
    }

    //MARK: Password Error View
    fileprivate func PasswordErrorView() -> some View {
        return
            VStack(alignment: .leading) {
                if emailAndPasswordViewModel.isSignUpScreen,
                    !emailAndPasswordViewModel.password.isEmpty,
                    !emailAndPasswordViewModel.isValidPassword()
                {
                    Text(
                        "Password must contain 8 characters, uppercase, lowercase, number and special character"
                    )
                    .foregroundStyle(.red)
                    .font(.caption)
                } else if !emailAndPasswordViewModel.isSignUpScreen,
                    emailAndPasswordViewModel
                        .shouldDisplayInvalidEmailOrPasswordWarningMessages,
                    !emailAndPasswordViewModel.email.isEmpty,
                    !emailAndPasswordViewModel.password.isEmpty,
                    !emailAndPasswordViewModel.isValidEmailAndPassword()
                {
                    Text("Invalid username or password")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }
    }

    //MARK: Confirm Password View
    fileprivate func ConfirmPasswordView(
        _ emailAndPasswordEnumType: EmailAndPasswordEnumType,
        bindingType: Binding<String>,
        type: String
    ) -> some View {
        return PasswordView(
            .confirmPassword,
            bindingType: bindingType,
            type: type
        )
    }

    //MARK: Toggle Switch View
    fileprivate func ToggleSwitchView() -> some View {
        return
            HStack {
                Spacer(minLength: 150)
                Toggle(
                    "Save email & password:",
                    isOn: $emailAndPasswordViewModel
                        .isEmailAndPasswordToggleChecked
                )
                .toggleStyle(.automatic)
                .font(Font.system(size: 13, weight: Font.Weight.light))
            }
            .padding(.bottom, 5)
    }

    //MARK: LogIn/SignUp Button View

    fileprivate func LogInSignUpButtonView() -> some View {
        return
            Button {
                emailAndPasswordViewModel.performAction {
                    if !emailAndPasswordViewModel
                        .isEmailAndPasswordToggleChecked
                    {
                        emailAndPasswordViewModel.clearEmailAndPasswordFields()
                    }
                }
            } label: {
                Text(
                    emailAndPasswordViewModel.isSignUpScreen
                        ? "Sign Up" : "Login"
                )
                .font(.default.bold())
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
            }
            .fullScreenCover(
                isPresented: $emailAndPasswordViewModel.isAuthenticated,
                content: {
                    MainView()
                }
            )
            .disabled(
                emailAndPasswordViewModel.isSignUpScreen
                    && !emailAndPasswordViewModel.isValidEmail()
                    && !emailAndPasswordViewModel.isValidPassword()
            )
            .buttonStyle(.borderedProminent)
    }

    //MARK: Go To SignUp Or Back To LogIn View

    fileprivate func goToSignUpOrBackToLogInView() -> some View {
        return
            HStack {
                Text(
                    emailAndPasswordViewModel.isSignUpScreen
                        ? "Go back to" : "Don't have an account?"
                )
                Text(
                    emailAndPasswordViewModel.isSignUpScreen
                        ? "Sign in" : "Sign Up"
                )
                .foregroundStyle(.blue)
                .underline()
                .onTapGesture {
                    if !emailAndPasswordViewModel.isSignUpScreen {
                        emailAndPasswordViewModel.shouldDisplaySignUpScreen.toggle()
                    } else {
                        emailAndPasswordViewModel.signUpDelegate?.shouldDisplaySignUpScreen.toggle()
                        print(emailAndPasswordViewModel.signUpDelegate?.shouldDisplaySignUpScreen)
                    }
//                    switch emailAndPasswordViewModel.isSignUpScreen {
//                    case true:
//                        print("Before: \(emailAndPasswordViewModel.signUpDelegate?.shouldDisplaySignUpScreen)")
//                        emailAndPasswordViewModel.signUpDelegate?.shouldDisplaySignUpScreen.toggle()
//                        print("After: \(emailAndPasswordViewModel.signUpDelegate?.shouldDisplaySignUpScreen)")
//                    case false:
//                    }

                }

                //                    emailAndPasswordViewModel.isSignUpScreen
                //                        ? "Go back to [Sign in](myappurl://action)"
                //                        : "Don't have an account? [Sign Up](myappurl://action)"
                //                )
            }
            .tint(.primary)
            .frame(maxWidth: .infinity, alignment: .center)
            .fullScreenCover(
                isPresented: $emailAndPasswordViewModel
                    .shouldDisplaySignUpScreen
            ) {
//                switch emailAndPasswordViewModel.shouldNavigateToSignUpScreen {
//                case true:
                    SignUpView()
//                case false:
//                }
            }
    }
}

#Preview {
    EmailAndPasswordView(
        emailAndPasswordViewModel: EmailAndPasswordViewModel(
            isSignUpScreen: false
        )
    )
}
