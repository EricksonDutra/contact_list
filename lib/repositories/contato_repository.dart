// import 'package:lista_de_contatos/model/contato_model.dart';
// import 'package:lista_de_contatos/repository/dio_repository.dart';

// class ContatoRepository{
//   var api = DioRepository();

//   Future<ContatoModel> obterContatos() async{
//     var contatos = await api.dio.get("/Contato");
//     return ContatoModel.fromJson(contatos.data); 
//   }

//   Future<Results> obterContatoPorId(String id) async{
//     var contato = await api.dio.get('/Contato/$id');
//     return Results.fromJson(contato.data);
//   }

//   Future<void> salvarContato(Results contato) async{
//     try {
//       await api.dio.post("/Contato", data: {
//         "nome": contato.nome,
//         "telefone": contato.telefone,
//         "email": contato.email,
//         "path_image": contato.pathImage
//       });
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> editarContato(Results contato) async{
//     try {
//       await api.dio.put("/Contato/${contato.objectId}", data: contato.toJsonEndpoint());
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> deletarContato(String id) async{
//     try {
//       await api.dio.delete("/Contato/$id");
//     } catch (e) {
//       rethrow;
//     }
//   }
// }