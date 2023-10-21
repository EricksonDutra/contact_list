import 'package:flutter/material.dart';
import 'package:lista_contatos/service/crop_image_service.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class CustomIconButton extends StatefulWidget {
  String imagemPath;
  Function() carregarImagem;
  Function (XFile) updateImage;
  CustomIconButton({super.key, required this.imagemPath, required this.carregarImagem, required this.updateImage});

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add_box_rounded, color: Colors.white, size: 60),
      onPressed: () {
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              content: const Text("O que deseja fazer?"),
              actions: [
                TextButton(
                  onPressed: () {
                    if(widget.imagemPath == ""){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.indigo,
                          content: Row(
                            children: [
                              Icon(Icons.warning, color: Colors.red),
                              SizedBox(width: 10),
                              Text("Nenhuma foto selecionada!")
                            ],
                          )
                        )
                      );
                      Navigator.pop(context);
                    } else {
                      CropImageService.cropImage(XFile(widget.imagemPath), widget.imagemPath, widget.updateImage);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  }, 
                  child: const Text('Editar')
                ),
                TextButton(
                  onPressed: (){
                    widget.carregarImagem();
                    Navigator.pop(context);
                  }, 
                  child: const Text('Nova Foto')
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: const Text('Sair')
                ),
              ],
            );
          }
        );
      },
    );
  }
}