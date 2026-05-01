import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_life_modeler/features/commute/domain/entities/commute_profile.dart';
import 'package:urban_life_modeler/features/commute/presentation/cubit/commute_cubit.dart';
import 'package:urban_life_modeler/features/commute/presentation/cubit/commute_cubit_state.dart';

class CommutePage extends StatefulWidget {
  const CommutePage({super.key});

  @override
  State<CommutePage> createState() => _CommutePageState();
}

class _CommutePageState extends State<CommutePage> {
  final _durationController = TextEditingController();
  final _transitModeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CommuteCubit, CommuteCubitState>(
        builder: (context, state) {
          if (state is CommuteSaving) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(label: Text('Duration(minutes)')),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _transitModeController,
                  decoration: InputDecoration(
                    label: Text('Transit Mode(eg. Bus, Subway'),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final commuteProfile = CommuteProfile(
                      id: 'userId_i',
                      departureTime: DateTime.now(),
                      durationMinutes:
                          int.tryParse(_durationController.text) ?? 0,
                      transitMode: _transitModeController.text,
                    );
                    context.read<CommuteCubit>().saveCommuteData(
                      commuteProfile,
                    );
                  },
                  child: Text('Saving dummy data'),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is CommuteError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is CommuteSaveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Saved successfully!'),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _transitModeController.dispose();
    _durationController.dispose();
    super.dispose();
  }
}
