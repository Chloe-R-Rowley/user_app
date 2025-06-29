import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../models/user_model.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _streetController = TextEditingController();
  final _suiteController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _companyCatchPhraseController = TextEditingController();
  final _companyBsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _streetController.dispose();
    _suiteController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _companyNameController.dispose();
    _companyCatchPhraseController.dispose();
    _companyBsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newUser = User(
        id: 0,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        website: _websiteController.text,
        address: Address(
          street: _streetController.text,
          suite: _suiteController.text,
          city: _cityController.text,
          zipcode: _zipController.text,
          geo: Geo(lat: '0.0', lng: '0.0'),
        ),
        company: Company(
          name: _companyNameController.text,
          catchPhrase: _companyCatchPhraseController.text,
          bs: _companyBsController.text,
        ),
      );

      context.read<UserBloc>().add(AddUser(newUser));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User ${newUser.name} added successfully!',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontFamily: 'Spectral',
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create New User',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Fill in the details below to add a new user',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                    fontWeight: FontWeight.w300,
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter full name',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    if (value.length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter email address',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    if (value.length < 10) {
                      return 'Phone number must be at least 10 digits';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                Text(
                  'Website',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _websiteController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: 'Enter website URL',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.web_outlined,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'Address Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Street',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _streetController,
                  decoration: InputDecoration(
                    hintText: 'Enter street address',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Suite',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _suiteController,
                  decoration: InputDecoration(
                    hintText: 'Enter suite',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'City',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: 'Enter city',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.location_city_outlined,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Zip Code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _zipController,
                  decoration: InputDecoration(
                    hintText: 'Enter zip code',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.pin_drop_outlined,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'Company Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Company Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _companyNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter company name',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.business_outlined,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Company Catch Phrase',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _companyCatchPhraseController,
                  decoration: InputDecoration(
                    hintText: 'Enter company catch phrase',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.tag_outlined,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Company Business',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontFamily: 'Spectral',
                  ),
                ),

                const SizedBox(height: 4),

                TextFormField(
                  controller: _companyBsController,
                  decoration: InputDecoration(
                    hintText: 'Enter company business description',
                    hintStyle: TextStyle(
                      color: colorScheme.secondary,
                      fontFamily: 'Spectral',
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.work_outline,
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Spectral',
                      ),
                    ),
                    child: const Text('Add User'),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      side: BorderSide(color: colorScheme.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Spectral',
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
