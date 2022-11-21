import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextFormFieldStyle extends StatefulWidget {
  const TextFormFieldStyle({
    super.key,
    required this.obscure,
    required this.onChanged,
    required this.label,
    this.focusNode,
    this.validator,
    this.errorTxt,
    this.readOnly = false,
    this.suffixIcon,
  });

  final bool obscure;
  final FocusNode? focusNode;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final String label;
  final String? errorTxt;
  final bool readOnly;
  final Widget? suffixIcon;

  @override
  State<TextFormFieldStyle> createState() => _TextFormFieldStyleState();
}

class _TextFormFieldStyleState extends State<TextFormFieldStyle> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      obscureText: widget.obscure,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        enabled: !widget.readOnly,
        border: OutlineInputBorder(),
        labelText: widget.label,
        errorText: widget.errorTxt,
        suffixIcon: widget.suffixIcon,
      ),
      style: TextStyle(
        fontStyle: widget.readOnly ? FontStyle.italic : FontStyle.normal,
      ),
      validator: widget.validator,
    );
  }
}

class SignUpPadding extends StatelessWidget {
  const SignUpPadding({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: child,
    );
  }
}

class AlertDialogCustom extends StatelessWidget {
  const AlertDialogCustom({
    super.key,
    required this.content,
  });
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.check),
        )
      ],
    );
  }
}

class RowWithHeight extends StatelessWidget {
  const RowWithHeight({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: children,
      ),
    );
  }
}
