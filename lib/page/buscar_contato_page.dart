import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_contatos/models/contact_model.dart';
import 'package:lista_contatos/page/perfil_contato_page.dart';
import 'package:lista_contatos/repositories/contact_repository.dart';
// import 'package:lista_contatos/repository/contato_repository.dart';

class BuscarContatoPage extends StatefulWidget{
  const BuscarContatoPage({super.key});

  @override
  State<BuscarContatoPage> createState() => _BuscarContatoPage();
}

class _BuscarContatoPage extends State<BuscarContatoPage>{
  var buscaController = TextEditingController(text: "");
  var contatosModel = ContactModel([]);
  var contatoRepository = ContactRepository();
  var resultadoBusca = ContactModel([]);


  @override
  void initState() {
    carregarDados(); 
    super.initState();
  }

  carregarDados() async{
    contatosModel = await contatoRepository.obterContatos();
    setState(() {});
  }

  busca() {
    resultadoBusca.results.clear();
    if (buscaController.text.trim().isEmpty) {
      return;
    }
    for (var element in contatosModel.results) {
      if (element.nome!.trim().toLowerCase() == buscaController.text.trim().toLowerCase()) {
        resultadoBusca.results.add(element);
      } 
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: TextField(
          controller: buscaController, 
          onChanged: (value) {
            buscaController.text = value;
            busca();
            setState(() {});
          },
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text("Digite o nome do contato..."),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async{
              FocusManager.instance.primaryFocus?.unfocus();
              await busca();
              if(resultadoBusca.results.isEmpty){
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.indigo,
                    content: Row(
                      children: [
                        Icon(Icons.search_off, color: Colors.red,),
                        SizedBox(width: 10),
                        Text("Contato não encontrado!"),
                      ],
                    )
                  )
                );
              }
              setState(() {});
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: resultadoBusca.results.isEmpty 
        ?
        const SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, color: Colors.white, size: 150,)
            ],
          ),
        )

        :
        
        ListView.builder(

          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          itemCount: resultadoBusca.results.length,
          itemBuilder: (_, index) {
            var resultado = resultadoBusca.results[index];

            return Column(
              children: [
                InkWell(
                  onTap: () async{
                    await Navigator.push(context, MaterialPageRoute(builder: (_) => PerfilContatoPage(id: resultado.objectId!)));
                    await carregarDados();
                    FocusManager.instance.primaryFocus?.unfocus();
                    busca();
                    setState(() {});
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      resultado.image == "" ?

                      const SizedBox(
                        width: 80,
                        child: Center(child: FaIcon(FontAwesomeIcons.user, size: 50, color: Colors.white,))
                      )

                      :

                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.file(
                          File(resultado.image!),
                          width: 80,
                          height: 80, 
                          fit: BoxFit.cover
                        )
                      ),
          
                      const SizedBox(width: 20),
          
                      Expanded(
                        child: ListTile(
                          
                          title: Text(resultado.nome!, style: GoogleFonts.montserrat(color: Colors.lightBlueAccent, fontSize: 20, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 9),
                              Row(
                                children: [
                                  const FaIcon(FontAwesomeIcons.phone, color: Colors.green,),
                                  const SizedBox(width: 10),
                                  Text(resultado.telefone!, style: GoogleFonts.almarai(color: Colors.white, fontSize: 17)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25)
              ],
            );
        }),
      ),
    );
  }
}
