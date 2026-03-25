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

            //MARK: Password Field
            passwordView(
                .password,
                bindingType: $emailAndPasswordViewModel.password,
                type: emailAndPasswordViewModel.password
            )

            //MARK: Confirm Password Field
            if !emailAndPasswordViewModel.isSignInScreen {
                confirmPasswordView(
                    .confirmPassword,
                    bindingType: $emailAndPasswordViewModel.confirmPassword,
                    type: emailAndPasswordViewModel.confirmPassword
                )
            }

            //MARK: Email & Password Save Toggle Field
            if emailAndPasswordViewModel.isSignInScreen {
                ToggleSwitchView()
            }

            //MARK: LogIn/SignUp Button
            logInSignUpButtonView()

            //MARK: Go To SignUp / Back To LogIn Field
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
                            emailAndPasswordViewModel.isSignInScreen
                            ? false : true
                    }
                )

                //MARK: Email Error Message Field
                emailErrorView()
            }
            .padding(.bottom, 10)
    }

    //MARK: Email Error View
    fileprivate func emailErrorView() -> some View {
        return
            Group {
                if !emailAndPasswordViewModel.isSignInScreen,
                    !emailAndPasswordViewModel.email.isEmpty,
                    !emailAndPasswordViewModel.isValidEmail(
                        email: emailAndPasswordViewModel.email
                    )
                {
                    Text("Invalid email address")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }
    }

    //FIXME: Password View
    fileprivate func passwordView(
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
                            emailAndPasswordViewModel.isSignInScreen
                            ? false : true
                    }
                )

                //MARK: Password Error Message Field
                if emailAndPasswordEnumType == .password {
                    passwordErrorView()
                } else {
                    confirmPasswordErrorView()
                }
            }
            .padding(.bottom, 10)
    }

    //MARK: Password Error View
    fileprivate func passwordErrorView() -> some View {
        return
            Group {
                if !emailAndPasswordViewModel.isSignInScreen,
                    !emailAndPasswordViewModel.password.isEmpty,
                    !emailAndPasswordViewModel.isValidPassword(
                        password: emailAndPasswordViewModel.password
                    )
                {
                    Text(
                        "⚠️ Password must contain 8 characters, uppercase, lowercase, number and special character"
                    )
                    .foregroundStyle(.red)
                    .font(.caption)
                } else if emailAndPasswordViewModel.isSignInScreen,
                    emailAndPasswordViewModel
                        .shouldDisplayInvalidEmailOrPasswordWarningMessages,
                    !emailAndPasswordViewModel.email.isEmpty,
                    !emailAndPasswordViewModel.password.isEmpty,
                    !emailAndPasswordViewModel.isValidEmailAndPassword(
                        email: emailAndPasswordViewModel.email,
                        password: emailAndPasswordViewModel.password
                    )
                {
                    Text("Invalid username or password")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }
    }

    //MARK: Confirm Password View
    fileprivate func confirmPasswordView(
        _ emailAndPasswordEnumType: EmailAndPasswordEnumType,
        bindingType: Binding<String>,
        type: String
    ) -> some View {
        return passwordView(
            .confirmPassword,
            bindingType: bindingType,
            type: type
        )
    }

    fileprivate func confirmPasswordErrorView() -> some View {
        return
            Group {
                if !emailAndPasswordViewModel.isSignInScreen,
                    !emailAndPasswordViewModel.confirmPassword.isEmpty,
                    emailAndPasswordViewModel.passwordsDoNotMatch(
                        password: emailAndPasswordViewModel.password,
                        confirmPassword: emailAndPasswordViewModel
                            .confirmPassword
                    )
                {
                    Text(
                        "⚠️ Passwords do not match"
                    )
                    .foregroundStyle(.red)
                    .font(.caption)
                }
            }
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

    fileprivate func logInSignUpButtonView() -> some View {
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
                    emailAndPasswordViewModel.isSignInScreen
                        ? "Login" : "Sign Up"
                )
                .font(.default.bold())
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
            }
            .disabled(
                !emailAndPasswordViewModel.isSignInScreen
                    && (!emailAndPasswordViewModel.isValidEmailAndPassword(
                        email: emailAndPasswordViewModel.email,
                        password: emailAndPasswordViewModel.password
                    )
                    || emailAndPasswordViewModel.passwordsDoNotMatch(
                        password: emailAndPasswordViewModel.password,
                        confirmPassword: emailAndPasswordViewModel
                            .confirmPassword
                    ))
            )
            .buttonStyle(.borderedProminent)
    }

    //MARK: Go To SignUp Or Back To LogIn View

    fileprivate func goToSignUpOrBackToLogInView() -> some View {
        return
            HStack {
                Text(
                    emailAndPasswordViewModel.isSignInScreen
                        ? "Don't have an account?" : "Go back to"
                )
                Text(
                    emailAndPasswordViewModel.isSignInScreen
                        ? "Sign Up" : "Sign in"
                )
                .foregroundStyle(.blue)
                .underline()
                .onTapGesture {
                    if emailAndPasswordViewModel.isSignInScreen {
                        emailAndPasswordViewModel.signInDelegate?
                            .shouldDisplaySignUpScreenToggle()
                    } else {
                        emailAndPasswordViewModel.signUpDelegate?
                            .shouldDisplaySignUpScreenToggle()
                    }
                }

            }
            .tint(.primary)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    EmailAndPasswordView(
        emailAndPasswordViewModel: EmailAndPasswordViewModel(
            isSignInScreen: true
        )
    )
}
