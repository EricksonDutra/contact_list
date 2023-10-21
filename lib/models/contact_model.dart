class ContactModel {
  List<Results> results = [];

  ContactModel(this.results);

  ContactModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
      data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Results {
  String? objectId = '';
  String? nome = '';
  String? username = '';
  String? image = '';
  String? telefone = '';
  String? email = '';
  String? createdAt = '';
  String? updatedAt = '';
  String? rua = '';
  String? numero = '';
  String? bairro = '';
  String? cidade = '';
  String? estado = '';

  Results({
    this.objectId,
    this.nome,
    this.username,
    this.image,
    this.telefone,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.rua,
    this.numero,
    this.bairro,
    this.cidade,
    this.estado,
  });

  Results.vazio(){
    objectId = "";
    nome = "";
    telefone = "";
    email = "";
    image = "";
    createdAt = "";
    updatedAt = "";
  }

  Results.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nome = json['nome'];
    username = json['username'];
    image = json['image'];
    telefone = json['telefone'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    rua = json['rua'];
    numero = json['numero'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['nome'] = nome;
    data['username'] = username;
    data['image'] = image;
    data['telefone'] = telefone;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['rua'] = rua;
    data['numero'] = numero;
    data['bairro'] = bairro;
    data['cidade'] = cidade;
    data['estado'] = estado;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['image'] = image;
    return data;
  }
}
