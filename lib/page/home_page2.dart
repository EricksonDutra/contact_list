// import 'package:flutter/material.dart';
// import 'package:lista_contatos/models/contact_model.dart';
// import 'package:lista_contatos/repositories/contact_repository.dart';
// // import 'package:lista_contatos/repositories/user_repository.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var contactRepo = ContactRepository();
//   var _contactModel = ContactModel([]);

//   @override
//   void initState() {
//     chargeData();
//     super.initState();
//   }

//   void chargeData() async {
//     _contactModel = await contactRepo.obterContatos();
//     setState(() {});
//     print(_contactModel.results);
//   }

//   // void imprimeDado() async{
//   //   userModel = await contactRepo.fetchContact();

//   // //   var teste = userModel.map((e) => e);
//   // //  return userModel
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('LISTA DE CONTATOS'),
//           backgroundColor: const Color.fromRGBO(255, 255, 215, 80)),
//       body: Container(
//         child: _contactModel.results.isNotEmpty
//             ? ListView.builder(
//                 itemCount: _contactModel.results.length,
//                 itemBuilder: (_, i) {
//                   var contact = _contactModel.results[i];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       elevation: 5,
//                       child: (ListTile(
//                         leading: const CircleAvatar(
//                             child:  Icon(
//                           Icons.person,
//                           size: 40,
//                         )),
//                         title: Text('Nome: ${contact.nome!}'),
//                         subtitle: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Text('Telefone: ${contact.telefone}'),
//                           ],
//                         ),
//                       )),
//                     ),
//                   );
//                 })
//             : SizedBox(
//                 width: double.infinity,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset('assets/telefone.png',
//                         height: 200, color: Colors.blue)
//                   ],
//                 ),
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: chargeData,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
