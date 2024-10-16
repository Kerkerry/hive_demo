import 'package:flutter/cupertino.dart';

class LoadingColumnWidget extends StatelessWidget {
  const LoadingColumnWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CupertinoActivityIndicator(),
          const SizedBox(
            height: 10,
          ),
          Text(message)
        ],
      ),
    );
  }
}
