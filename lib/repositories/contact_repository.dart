// import 'package:lista_contatos/models/user.dart';
import 'package:lista_contatos/models/contact_model.dart';
import 'package:lista_contatos/repositories/dio_repository.dart';

class ContactRepository {
  var api = DioRepository();

  Future<ContactModel> obterContatos() async{
    var contatos = await api.dio.get("/Usuario");
    return ContactModel.fromJson(contatos.data); 
  }

  Future<Results> obterContatoPorId(String id) async{
    var contato = await api.dio.get('/Usuario/$id');
    return Results.fromJson(contato.data);
  }

  Future<void> salvarContato(Results contato) async{
    try {
      await api.dio.post("/Usuario", data: {
        "nome": contato.nome,
        "telefone": contato.telefone,
        "email": contato.email,
        "path_image": contato.image
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editarContato(Results contato) async{
    try {
      await api.dio.put("/Usuario/${contato.objectId}", data: contato.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletarContato(String id) async{
    try {
      await api.dio.delete("/Contato/$id");
    } catch (e) {
      rethrow;
    }
  }
}
