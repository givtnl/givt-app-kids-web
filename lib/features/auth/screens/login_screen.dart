// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/auth/cubit/auth_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/quiz/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/shared/widgets/givt_continue_button.dart';
import 'package:givt_app_kids_web/shared/widgets/givt_tertiary_elevated_button.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';
import 'package:go_router/go_router.dart';

import 'package:givt_app_kids_web/shared/widgets/back_button.dart'
    as givt_widgets;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";

  bool _isPasswordVisible = false;

  static const double _inputFieldsMaxWidth = 500;

  Future<void> _login() async {
    context.read<AuthCubit>().login(_email, _password);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final anchorSize = size.aspectRatio > 1 ? size.width : size.height;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        log('auth state changed on $state');
        if (state is ExternalErrorState) {
          log(state.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Cannot login. Please try again later.",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        } else if (state is LoggedInState) {
          // context.pushReplacementNamed(Pages.profileSelection.name);
          context.read<QuizCubit>().startQuiz();
          context.pushReplacementNamed(Pages.quizWhere.name);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: const Color(0xFFEEEDE4),
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      SvgPicture.asset(
                        height: anchorSize * 0.12,
                        "images/transparent_logo.svg",
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        "Log in to your account with your Givt-app credentials",
                        style: TextStyle(
                          color: Color(0xFF3B3240),
                          fontSize: FontUtils.getScaledFontSize(
                              inputFontSize: 18, size: size),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                              color: Color(0xFF3B3240),
                              fontSize: FontUtils.getScaledFontSize(
                                  inputFontSize: 18, size: size),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: size.width < _inputFieldsMaxWidth
                                ? size.width
                                : _inputFieldsMaxWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFBFDBFC),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            child: TextField(
                              key: ValueKey("email"),
                              style: TextStyle(
                                fontSize: FontUtils.getScaledFontSize(
                                    inputFontSize: 18, size: size),
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: state is InputFieldErrorState
                                    ? state.emailErrorMessage
                                    : null,
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => _email = value,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                              color: Color(0xFF3B3240),
                              fontSize: FontUtils.getScaledFontSize(
                                  inputFontSize: 18, size: size),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: size.width < _inputFieldsMaxWidth
                                ? size.width
                                : _inputFieldsMaxWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFBFDBFC),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                      fontSize: FontUtils.getScaledFontSize(
                                          inputFontSize: 18, size: size),
                                    ),
                                    key: ValueKey("password"),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorText: state is InputFieldErrorState
                                          ? state.passwordErrorMessage
                                          : null,
                                    ),
                                    obscureText: !_isPasswordVisible,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.visiblePassword,
                                    onChanged: (value) => _password = value,
                                    onSubmitted: (value) => _login(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      _isPasswordVisible
                                          ? "images/password_hide.svg"
                                          : "images/password_show.svg",
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 120,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 30,
              child: givt_widgets.BackButton(
                pageName: Pages.login.name,
              ),
            ),
            Positioned(
              right: 30,
              bottom: 30,
              child: GivtContinueButton(
                onPressed: () {
                  AnalyticsHelper.logEvent(
                      eventName: AmplitudeEvent.buttonPressed,
                      eventProperties: {
                        'button_name': 'continue as guest',
                        'formatted_date': DateTime.now().toIso8601String(),
                        'screen_name': Pages.login.name,
                      });

                  context.read<QuizCubit>().startQuiz();
                  context.pushReplacementNamed(Pages.quizWhere.name);
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: GivtTertiaryElevatedButton(
            text: 'Sign in',
            onPressed: _login,
            isLoading: state is LoadingState,
          ),
        ),
      ),
    );
  }
}
