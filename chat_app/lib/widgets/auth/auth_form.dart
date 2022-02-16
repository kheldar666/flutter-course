import 'dart:io';

import 'package:chat_app/models/auth_mode.dart';
import 'package:chat_app/widgets/pickers/user_image_pickers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function({
    required String email,
    required String? username,
    required String password,
    required File? image,
    required AuthMode mode,
  }) onSubmitForm;

  const AuthForm(this.onSubmitForm, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  String? _userEmail;
  String? _userPassword;
  String? _userUsername;
  File? _userImageFile;

  var _authMode = AuthMode.login;
  var _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_authMode != AuthMode.login)
                    UserImagePicker(_pickImageCallback),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (email) =>
                        email == null || !EmailValidator.validate(email.trim())
                            ? 'Please enter a valid email.'
                            : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (email) {
                      _userEmail = email!.trim();
                    },
                  ),
                  if (_authMode == AuthMode.signup)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (username) => username == null ||
                              username.isEmpty ||
                              username.length < 4
                          ? 'Username must be at least 4 character long'
                          : null,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (username) {
                        _userUsername = username!.trim();
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (password) => password == null ||
                            password.isEmpty ||
                            password.length < 7
                        ? 'Password must be at least 7 character long'
                        : null,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (password) {
                      _userPassword = password;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (!_isSubmitting)
                    ElevatedButton(
                      onPressed: _submit,
                      child: _authMode == AuthMode.login
                          ? const Text('Login')
                          : const Text('Signup'),
                    ),
                  if (!_isSubmitting)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.login
                              ? AuthMode.signup
                              : AuthMode.login;
                        });
                      },
                      child: _authMode == AuthMode.login
                          ? const Text('Create a new account')
                          : const Text('Switch to login'),
                    ),
                  if (_isSubmitting) const CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pickImageCallback(File _pickedImage) {
    _userImageFile = _pickedImage;
  }

  void _submit() async {
    setState(() {
      _isSubmitting = true;
    });
    final isValid = _formKey.currentState!.validate();
    //Closes the keyboard
    FocusScope.of(context).unfocus();

    if (_authMode == AuthMode.signup && _userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please pick an Image'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
          textColor: Colors.white,
        ),
      ));
      setState(() {
        _isSubmitting = false;
      });
      return;
    }
    if (isValid) {
      setState(() {
        _isSubmitting = false;
      });
      _formKey.currentState!.save();
      await widget.onSubmitForm(
        email: _userEmail!,
        password: _userPassword!,
        username: _userUsername,
        mode: _authMode,
        image: _userImageFile,
      );
    } else {
      setState(() {
        _isSubmitting = false;
      });
    }
  }
}
