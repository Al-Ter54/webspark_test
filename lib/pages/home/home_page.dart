import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/bloc/link/app_cubit.dart';
import 'package:webspark_test/pages/processing/processing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<AppCubit>().loadUrl();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: BlocConsumer<AppCubit, BaseAppState>(
        listener: (context, state) {
          if (state is SuccessAppState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProcessingPage(tasks: state.response.body),
              ),
            );
          }

          if (state is ErrorAppState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error ?? '')));
          }
          if (state is InitAppState) {
            if (state.url != null) {
              controller.text = state.url ?? '';
            } else {
              controller.text = 'https://flutter.webspark.dev/flutter/api';
            }
          }
        },
        builder: (context, state) {
          if (state is LoadingAppState) {
            final percent = (state.progress * 100).toInt();

            return Column(
              children: [
                LinearProgressIndicator(value: state.progress),
                const SizedBox(height: 8),
                Text('$percent%'),
              ],
            );
          }

          return Column(
            children: [
              TextField(controller: controller),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<AppCubit>().saveUrl(controller.text);
                },
                child: const Text('Start'),
              ),
            ],
          );
        },
      ),
    );
  }
}
