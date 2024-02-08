import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_using_bloc/sign_in_bloc/sigin_bloc.dart';
import 'package:form_validation_using_bloc/sign_in_bloc/sign_in_event.dart';
import 'package:form_validation_using_bloc/sign_in_bloc/signin_state.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign in")),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                  if (state is SignInErrorState) {
                    return Text(
                      state.ErrorMsg,
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return Container();
                  }
                }),
                TextFormField(
                  controller: _emailController,
                  onChanged: (value) {
                    BlocProvider.of<SignInBloc>(context).add(
                        SignInTextChangedEvent(
                            _emailController.text, _passwordController.text));
                  },
                  decoration: InputDecoration(hintText: "Enter Email Address"),
                ),
                TextFormField(
                  controller: _passwordController,
                  onChanged: (value) {
                    BlocProvider.of<SignInBloc>(context).add(
                        SignInTextChangedEvent(
                            _emailController.text, _passwordController.text));
                  },
                  decoration: InputDecoration(hintText: "Password"),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    if (state is SignInLoadingState) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: (state is SignInValidState)
                                ? Colors.blue
                                : Colors.grey,
                            maximumSize: Size(200, 45),
                            minimumSize: Size(200, 45)),
                        onPressed: () {
                          if (state is SignInValidState) {
                            BlocProvider.of<SignInBloc>(context).add(
                                SignInSubmittedEvent(_emailController.text,
                                    _passwordController.text));
                          }
                        },
                        child: Text("Sign in "));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
