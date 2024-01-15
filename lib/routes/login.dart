import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:reskolae/utils/logging.dart';
import 'package:reskolae/utils/myges.dart';

class LoginScreen extends StatefulWidget
{
  const LoginScreen({ super.key });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  final _formKey = GlobalKey<FormBuilderState>();
  final _usernameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('LOGIN WITH MYGES', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'EDD', fontSize: Theme.of(context).textTheme.displaySmall?.fontSize)),
              const SizedBox(height: 24),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      key: _usernameFieldKey,
                      name: 'username',
                      decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(2),
                      ]),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      key: _passwordFieldKey,
                      name: 'password',
                      decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(2),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    (_isLoading)
                    ? const CircularProgressIndicator()
                    : FilledButton(
                      onPressed:
                      () async
                      {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.saveAndValidate())
                        {
                          setState(() { _isLoading = true; });

                          MyGES myges = MyGES();

                          dynamic result;
                          try
                          {
                            Logging.log(this, _formKey.currentState?.value);
                            result = await myges.authenticate(_formKey.currentState?.value['username'], _formKey.currentState?.value['password']);
                          }
                          catch (e)
                          {
                            String errorMessage = 'An error occured.';
                            if (e.runtimeType == DioException) { errorMessage = 'Couldn\'t reach auth services. Please check your network.'; }

                            if (context.mounted)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
                            }

                            Logging.log(this, e.runtimeType == DioException);
                            setState(() { _isLoading = false; });
                          }

                          Logging.log(this, result);
                        }
                      },
                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                      child: const Text('Login', style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              )
            ],
          )
        )
      )
    );
  }
}