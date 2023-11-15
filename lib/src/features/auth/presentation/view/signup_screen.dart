import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../blocs/signup/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Spacer(flex: 3),
              _Username(),
              SizedBox(height: 10),
              _Email(),
              SizedBox(height: 10),
              _Password(),
              SizedBox(height: 10),
              _SignupButton(),
              Spacer(flex: 2),
              _LoginRedirect(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginRedirect extends StatelessWidget {
  const _LoginRedirect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('login');
      },
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(text: 'Already have an account? '),
            TextSpan(
              text: 'Login',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? const CircularProgressIndicator(color: Colors.white)
            : ElevatedButton(
                onPressed: () {
                  if (state.status == FormzStatus.valid) {
                    context.read<SignupCubit>().signupWithCredentials();
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Check your username, email and password: ${state.status}',
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Signup',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ),
              );
      },
    );
  }
}

class _Password extends StatelessWidget {
  const _Password({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Password',
          errorText: state.password.invalid ? 'The password is invalid' : null,
          textInputType: TextInputType.text,
          obscureText: true,
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Username',
          errorText: state.username.invalid ? 'The username is invalid' : null,
          textInputType: TextInputType.name,
          onChanged: (username) {
            context.read<SignupCubit>().usernameChanged(username);
          },
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Email',
          errorText: state.email.invalid ? 'The email is invalid' : null,
          textInputType: TextInputType.emailAddress,
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
        );
      },
    );
  }
}
