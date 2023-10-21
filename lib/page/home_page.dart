import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_contatos/models/contact_model.dart';
import 'package:lista_contatos/page/buscar_contato_page.dart';
import 'package:lista_contatos/page/editar_contato_page.dart';
import 'package:lista_contatos/page/perfil_contato_page.dart';
import 'package:lista_contatos/page/salvar_contato_page.dart';
import 'package:lista_contatos/repositories/contact_repository.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  var contatosRepository = ContactRepository();
  var _contatos = ContactModel([]);
  bool carregando = false;

  @override
  void initState() {
    carregandoTela();
    super.initState();
  }

  carregarDados() async {
    _contatos = await contatosRepository.obterContatos();
    setState(() {});
  }

  carregandoTela() async{
    setState(() {
      carregando = true;
    });
    await carregarDados();
    setState(() {
      carregando = false;
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text("Contatos", style: GoogleFonts.dmSerifDisplay(fontSize: 25)),
        actions: [
           IconButton(
            onPressed: () async {
              await showDialog(
                context: context, 
                builder: (_){
                  return const BuscarContatoPage();
                }
              );
              carregarDados();
            }, 
            icon: const Icon(Icons.search)
          ),
        ],
      ),

      body: Container(
        color: Colors.black87,
        child: 
        
        carregando ?

        const Center(child: CircularProgressIndicator())

        :
        
        _contatos.results.isEmpty ? 

        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/telefone.png', height: 200, color: Colors.blue)
            ],
          ),
        )

        :

        ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          itemCount: _contatos.results.length,
          itemBuilder: (_, index){
            var contato = _contatos.results[index];
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      const SizedBox(width: 6),

                      contato.image == "" ?

                      const SizedBox(
                        width: 80,
                        child: Center(child: FaIcon(FontAwesomeIcons.user, size: 50, color: Colors.white,))
                      )

                      :

                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          File(contato.image!),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 10),
                      Expanded(
                        child: ListTile(
                          onTap: () async {
                            await Navigator.push(context, MaterialPageRoute(builder: (_) => PerfilContatoPage(id: contato.objectId!)));
                            carregarDados();
                          },
                          titleAlignment: ListTileTitleAlignment.center,
                          contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(contato.nome!, style: GoogleFonts.montserrat(color: Colors.lightBlueAccent, fontSize: 20, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)
                              ),
                              const SizedBox(height: 9),
                            ],
                          ),
                          
                          subtitle: Row(
                            children: [
                              const FaIcon(FontAwesomeIcons.phone, size: 18, color: Colors.greenAccent),
                              const SizedBox(width: 10),
                              Text(contato.telefone!, style: GoogleFonts.almarai(color: Colors.white, fontSize: 17)),
                            ],
                          ),
                          
                          trailing: PopupMenuButton<String>(
                            color: Colors.white,
                            onSelected: (menu) async{
                              if(menu == "Editar") {
                                await showDialog(
                                  context: context, 
                                  builder: (_){
                                    return EditarContatoPage(id: contato.objectId!);
                                  }
                                );
                                carregarDados();

                              } else if(menu == "Excluir"){
                                showDialog(
                                  context: context, 
                                  builder: (_){
                                    return AlertDialog(
                                      title: const Text("Excluir contato?"),
                                      content: Text("Deseja excluir ${contato.nome} da sua lista de contatos?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await contatosRepository.deletarContato(contato.objectId!);
                                            carregarDados();
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                          }, 
                                          child: const Text("Sim")
                                        ),
                                        TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          }, 
                                          child: const Text("Não")
                                        ),
                                      ],
                                    );
                                  }
                                );
                              }
                            },
                            itemBuilder: (context) {
                              return <PopupMenuEntry<String>>[
                                // ignore: sort_child_properties_last
                                const PopupMenuItem<String>(child: Text("Editar"), value: "Editar"),
                                // ignore: sort_child_properties_last
                                const PopupMenuItem<String>(child: Text("Excluir"), value: "Excluir"),
                              ];
                            },
                          )
                          
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(color: Colors.white)

              ],
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const SalvarContatoPage()));
          carregarDados();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}