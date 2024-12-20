import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('A Simple Contact Form'),
        ),
        body: const ContactForm(),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  ContactFormState createState() => ContactFormState();
}

class ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _selectedGender;
  String? _preferredContactMethod = 'Email';
  bool _isSubscribed = false;

  String? _errorMessage;
  String? _submittedName;
  String? _submittedEmail;
  String? _submittedGender;
  String? _submittedContactMethod;
  String? _submittedMessage;
  bool? _submittedSubscriptionStatus;

  final List<String> _contactMethods = ['Email', 'Phone', 'SMS'];

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    setState(() {
      _selectedGender = null;
      _preferredContactMethod = 'Email';
      _isSubscribed = false;
      _errorMessage = null;

      _submittedName = null;
      _submittedEmail = null;
      _submittedGender = null;
      _submittedContactMethod = null;
      _submittedMessage = null;
      _submittedSubscriptionStatus = null;
    });
  }

  void _submitForm() {
    setState(() {
      _errorMessage = null;
    });

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty ||
        _selectedGender == null) {
      setState(() {
        _errorMessage = 'Please fill out all fields';
      });
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text)) {
      setState(() {
        _errorMessage = 'Please enter a valid email format';
      });
      return;
    }

    setState(() {
      _submittedName = _nameController.text;
      _submittedEmail = _emailController.text;
      _submittedGender = _selectedGender;
      _submittedContactMethod = _preferredContactMethod;
      _submittedMessage = _messageController.text;
      _submittedSubscriptionStatus = _isSubscribed;
    });

    // Clear the form fields
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    setState(() {
      _selectedGender = null;
      _preferredContactMethod = 'Email';
      _isSubscribed = false;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                const Text('Gender', style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Other'),
                        value: 'Other',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _preferredContactMethod,
                  decoration: const InputDecoration(
                      labelText: 'Preferred Contact Method'),
                  items: _contactMethods.map((method) {
                    return DropdownMenuItem(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _preferredContactMethod = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isSubscribed,
                      onChanged: (value) {
                        setState(() {
                          _isSubscribed = value ?? false;
                        });
                      },
                    ),
                    const Text('Subscribe to newsletter'),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(labelText: 'Message'),
                  maxLines: 5,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: _clearForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (_submittedName != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Submitted Information:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Name: $_submittedName'),
                        Text('Email: $_submittedEmail'),
                        Text('Gender: $_submittedGender'),
                        Text(
                            'Preferred Contact Method: $_submittedContactMethod'),
                        Text(
                            'Subscribed to Newsletter: ${_submittedSubscriptionStatus! ? 'Yes' : 'No'}'),
                        Text('Message: $_submittedMessage'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
