import 'package:flutter/material.dart';

class WidgetFooter extends StatefulWidget {
  const WidgetFooter({super.key});

  @override
  State<WidgetFooter> createState() => _WidgetFooterState();
}

class _WidgetFooterState extends State<WidgetFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Center(
        child: Text(
          '© 2024 Fantasy League. Todos os direitos reservados.',
          style: TextStyle(color: Colors.grey[900], fontSize: 14),
        ),
      ),
    );
  }
}
