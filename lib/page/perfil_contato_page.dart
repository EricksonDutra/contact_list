import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_contatos/models/contact_model.dart';
import 'package:lista_contatos/page/editar_contato_page.dart';
import 'package:lista_contatos/repositories/contact_repository.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class PerfilContatoPage extends StatefulWidget {
  String id;
  PerfilContatoPage({super.key, required this.id});

  @override
  State<PerfilContatoPage> createState() => _PerfilContatoPageState();
}

class _PerfilContatoPageState extends State<PerfilContatoPage> {

  var contatoPorId = Results.vazio();
  var contatoRepository = ContactRepository();

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async{
    contatoPorId = await contatoRepository.obterContatoPorId(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black87,
        child: contatoPorId.objectId == "" ?

        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator()
          ]
        )

        :
        
        ListView(
          padding: const EdgeInsets.symmetric(vertical: 0),
          children: [
            Container(
              height: 380,
              color: contatoPorId.image == "" ? Colors.grey : Colors.transparent,
              child: contatoPorId.image == "" 
              ? 
              const SizedBox(
                width: double.infinity,
                child: Center(child: FaIcon(FontAwesomeIcons.user, size: 100, color: Colors.white,))
              )
              :
              Image.file(File(contatoPorId.image!), fit: BoxFit.cover)
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    color: Colors.white,
                    alignment: Alignment.topRight,
                    onPressed: () async {
                      await showDialog(
                        barrierColor: Colors.black,
                        context: context, 
                        builder: (_){
                          return EditarContatoPage(id: contatoPorId.objectId!);
                        }
                      );
                      carregarDados();
                    }, 
                    icon: const Icon(Icons.edit)
                  ),
                  IconButton(
                    color: Colors.white,
                    alignment: Alignment.topRight,
                    onPressed: (){
                      showDialog(
                        context: context, 
                        builder: (_){
                          return AlertDialog(
                            title: const Text("Excluir contato?"),
                            content: Text("Excluir ${contatoPorId.nome} da sua lista de contatos?"),
                            actions: [
                              TextButton(
                                onPressed: () async{
                                  await contatoRepository.deletarContato(contatoPorId.objectId!);
                                  carregarDados();
                                  // ignore: use_build_context_synchronously
                                  Navigator.popUntil(context, ModalRoute.withName("Home_Page"));
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
                    }, 
                    icon: const Icon(Icons.delete)
                  ),
                  IconButton(
                    color: Colors.white,
                    alignment: Alignment.topRight,
                    onPressed: (){
                      Share.share("${contatoPorId.nome}\n${contatoPorId.telefone}\n${contatoPorId.email}", );
                    }, 
                    icon: const Icon(Icons.share)
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
              title: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.user, color: Colors.blue, size: 35),
                  const SizedBox(width: 20),
                  Expanded(
                       child: Text(contatoPorId.nome!, style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(color: Colors.grey,),
            ),

            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
              title: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.phone, color: Colors.green, size: 35,),
                  const SizedBox(width: 20),
                  Text(contatoPorId.telefone!, style: GoogleFonts.almarai(fontSize: 20, color: Colors.white))
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(color: Colors.grey,),
            ),

            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
              title: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(contatoPorId.email!.isEmpty ? "email não informado" : contatoPorId.email!, style: GoogleFonts.almarai(fontSize: 20, color: Colors.white))
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}