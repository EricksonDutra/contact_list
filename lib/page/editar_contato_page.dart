import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_contatos/models/contact_model.dart';
import 'package:lista_contatos/repositories/contact_repository.dart';
import 'package:lista_contatos/shared/widgets/custom_iconbutton.dart';

// ignore: must_be_immutable
class EditarContatoPage extends StatefulWidget {
  String id;
  EditarContatoPage({super.key, required this.id});

  @override
  State<EditarContatoPage> createState() => _EditarContatoPageState();
}

class _EditarContatoPageState extends State<EditarContatoPage> {
  var contatoPorId = Results.vazio();
  var contatoRepository = ContactRepository();
  var nomeController = TextEditingController(text: "");
  var telefoneController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var carregando = false;
  var imagemPath = "";
  XFile? photo;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async{
    setState(() {
      carregando = true;
    });
    contatoPorId = await contatoRepository.obterContatoPorId(widget.id);
    nomeController.text = contatoPorId.nome!;
    telefoneController.text = contatoPorId.telefone!;
    emailController.text = contatoPorId.email!;
    imagemPath = contatoPorId.image!;
    setState(() {
      carregando = false;
    });
  }

  setValues(){
    contatoPorId.nome = nomeController.text;
    contatoPorId.telefone = telefoneController.text;
    contatoPorId.email = emailController.text;
    contatoPorId.image = imagemPath;
  }

  carregarImagem() async{
    ImagePicker picker = ImagePicker();
    photo = await picker.pickImage(source: ImageSource.gallery);
    imagemPath = photo!.path;
    setState(() {});
  }

  updateImage(XFile croppedImage){
    setState(() {
      imagemPath = croppedImage.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: 

        carregando ?

        const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          )
        )

        :
        
        ListView(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: 380,
              child: DecoratedBox(
                decoration: imagemPath == "" ? const BoxDecoration(color: Colors.grey) : BoxDecoration(image: DecorationImage(image: FileImage(File(imagemPath)), fit: BoxFit.cover)),
                child: CustomIconButton(imagemPath: imagemPath, carregarImagem: carregarImagem, updateImage: updateImage)
              )
            ),

            const SizedBox(height: 60),
    
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.user, color: Colors.blue),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: nomeController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        label: Text("Nome"),
                        labelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 33),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.phone, color: Colors.green),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: telefoneController,
                      decoration: const InputDecoration(
                        label: Text("Telefone"),
                        labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                    ),
                  ),
                ],
              )
            ),

            const SizedBox(height: 33),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                ],
              ),
            ),
    
            const SizedBox(height: 60),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.indigo),
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15))
                ),
                onPressed: () async {
                  if (telefoneController.text.length < 14){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.indigo,
                        content: Row(
                          children: [
                            Icon(Icons.warning, color: Colors.red,),
                            SizedBox(width: 10),
                            Text("Formato de telefone inválido!")
                          ],
                        )
                      )
                    );
                  } else{
                    await setValues();
                    await contatoRepository.editarContato(contatoPorId);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    await carregarDados();
                  }
                }, 
                child: const Text('Salvar', style: TextStyle(color: Colors.white))
              ),
            ),

            const SizedBox(height: 25),

          ],
        ),
    
      ),
    );
  }
}