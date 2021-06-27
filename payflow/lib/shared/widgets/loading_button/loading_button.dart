import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({ 
    Key? key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 50.0,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed, 
          child: isLoading ? Center(
          child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ) : child,
        ),
      ),
    );
  }
}