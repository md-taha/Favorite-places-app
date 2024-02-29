// import 'package:favorite_places_app/models/place.dart';
// import 'package:flutter/material.dart';

// class AddPlace extends StatefulWidget {
//   const AddPlace({super.key});
//   @override
//   State<AddPlace> createState() => _AddPlaceState();
// }

// class _AddPlaceState extends State<AddPlace> {
//   var _enteredTitle = '';

//   void _savePlace (){
//     Navigator.of(context).pop(
//       Place(title: _enteredTitle,),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add a new item'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Form(
//             child: Column(
//           children: [
//             TextFormField(
//               maxLength: 50,
//               decoration: const InputDecoration(
//                 label: Text('Name'),
//               ),
//               validator: (value) {
//                 if (value == null ||
//                     value.isEmpty ||
//                     value.trim().length <= 1 ||
//                     value.trim().length > 50) {
//                   return 'Must be between 1 and 50 characters.';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 // if (value == null) {
//                 //   return;
//                 // }
//                 _enteredTitle = value!;
//               },
//             ),
//             ElevatedButton(
//               onPressed: _savePlace,
//               child: const Text("Add place"),
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }

import 'package:favorite_places_app/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places_app/providers/user_places.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 10),
            ImageInput(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
