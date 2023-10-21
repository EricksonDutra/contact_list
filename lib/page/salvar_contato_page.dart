import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_contatos/repositories/contact_repository.dart';
import 'package:lista_contatos/shared/widgets/custom_iconbutton.dart';

class SalvarContatoPage extends StatefulWidget {
  const SalvarContatoPage({super.key});

  @override
  State<SalvarContatoPage> createState() => _SalvarContatoPageState();
}

class _SalvarContatoPageState extends State<SalvarContatoPage> {
  var telefoneController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var nomeController = TextEditingController(text: "");
  var contatoRepository = ContactRepository();
  var imagemPath = "";

  XFile? photo;
  carregarImagem() async{
    final ImagePicker picker = ImagePicker();
    photo = await picker.pickImage(source: ImageSource.gallery);
    imagemPath = photo!.path;
    setState(() {});
  }

  updateImage(XFile croppedFile){
    setState(() {
      imagemPath = croppedFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87, 
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 0),
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: 380,
              child: DecoratedBox(
                decoration: imagemPath == "" ? const BoxDecoration(image: DecorationImage(image: AssetImage("assets/addContato.png"), fit: BoxFit.cover)) :  BoxDecoration(image: DecorationImage(image: FileImage(File(imagemPath)), fit: BoxFit.cover)),
                child: CustomIconButton(imagemPath: imagemPath, carregarImagem: carregarImagem, updateImage: updateImage),
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
                      style: const TextStyle(color: Colors.white),
                      controller: nomeController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        label: Text("Nome"),
                        labelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(borderSide: BorderSide())
                      ),
                      keyboardType: TextInputType.name,
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
                      style: const TextStyle(color: Colors.white),
                      controller: telefoneController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        label: Text("Telefone"),
                        labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(borderSide: BorderSide())
                       ),
                       keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
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
                  const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: emailController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        label: Text("Email"),
                        labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                  if(nomeController.text.trim().isEmpty || telefoneController.text.trim().isEmpty || telefoneController.text.length < 14){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.indigo,
                        animation: AlwaysStoppedAnimation(20),
                        content: Row(
                          children: [
                            Icon(Icons.warning, color: Colors.red,),
                            SizedBox(width: 5),
                            Text("Nome e telefone do contato precisam ser informados!"),
                          ],
                        )
                      )
                    );
                  } else{
                    // await contatoRepository.salvarContato(Results("", nomeController.text.trim(), telefoneController.text, emailController.text.trim(), imagemPath, "", ""));
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                }, 
                child: const Text("Salvar", style: TextStyle(color: Colors.white))
              ),
            ),

            const SizedBox(height: 25)

          ],
        ),
      ),
    );
  }
}