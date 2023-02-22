import 'package:aplikasi_mini_facebook/data.dart';
import 'package:aplikasi_mini_facebook/models/postingan_mdl.dart';
import 'package:aplikasi_mini_facebook/providers/postingan_provider.dart';
import 'package:flutter/material.dart';

enum ActionType { create, update }

extension ActionTypeExtension on ActionType {
  bool get isCreate => this == ActionType.create;
  bool get isUpdate => this == ActionType.update;
}

class FormPage extends StatefulWidget {

  const FormPage({super.key, required this.action, this.postingan, this.provider, this.judul, this.index, this.value, this.isVisible = true, this.isVisibleArsip = true});

  final ActionType action;
  final PostinganMdl? postingan;
  final PostinganProvider? provider;
  final String? judul;

  final index;
  final value;
  final isVisible;
  final isVisibleArsip;

  static Future<void> show(
      BuildContext context, {
        required PostinganProvider provider,
        PostinganMdl? postingan,
      }) async {
        await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return FormPage(
              action: postingan != null ? ActionType.update : ActionType.create,
              provider: provider,
              postingan: postingan,
            );
          },
        );
      }

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _gambarController = TextEditingController();

  PostinganMdl? get postingan => widget.postingan;
  PostinganProvider? get provider => widget.provider;

  String get deskripsi => _deskripsiController.text;
  String get gambar => _gambarController.text ?? '-';



  getDataArsip(){
    if(widget.index != null && widget.value != null){
      setState(() {
        _deskripsiController.text = widget.value['deskripsi'];
        _gambarController.text = widget.value['gambar'];
      });
    }
  }

  saveDataArsip() async {
    var postingan = {
      'deskripsi': _deskripsiController.text,
      'gambar': _gambarController.text,
    };

    var savedData = await Data.getData();

    if(widget.index == null){
      savedData.insert(0, postingan);
    }else{
      savedData[widget.index] = postingan;
    }
    await Data.saveData(savedData);
    Navigator.pop(context);
  }



  @override
  void initState() {
    super.initState();

    getDataArsip();

    if (postingan != null) {
      _deskripsiController.text = postingan!.deskripsi;
      _gambarController.text = postingan!.gambar;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.judul.toString()),
        // centerTitle: true,
        actions: [
          Visibility(
            visible: widget.isVisibleArsip,
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                saveDataArsip();

              },
              child: const Text('Simpan Ke Arsip', style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),

      body: Column(
        children: <Widget>[
          Container(
              width: size.width,
              height: size.height - MediaQuery.of(context).viewInsets.bottom - 80,
              child: Padding(
                padding: const EdgeInsets.only(right:14.0,left:10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiGLrYWwdFQRl8A_-51kRrcDCZxSHuQVy-8GUSkbYxCsI3h8SA1rg1bGCfNJx9YZ_bn9R51ySSNbqtfkKWevmzpG-qR9jYp1mvVssgZjbVzlFOnbm45tf0rd8BX7pAwXGNoo6L8RSkKGk00my9rawO8gu00WZSAgi8iSMCWXfsYPauizntQ1UG869K0Zg/s673/foto-profil-medsos.JPG"),
                            radius: 25.0,
                          ),
                        ),
                        Text("Fauzein Mulya Warman", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                      ],
                    ),

                    Divider(height: 2,color: Colors.grey,),

                    TextField(
                      controller: _gambarController,
                      decoration: const InputDecoration(labelText: 'Gambar Berupa Link (Opsional)'),
                    ),

                    TextFormField(
                      autofocus: true,
                      // focusNode: writingTextFocus,
                      controller: _deskripsiController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tuliskan Sesuatu...',
                        hintMaxLines: 4,
                      ),
                      // controller: writingTextController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    // _postImageFile != null ? Image.file(_postImageFile,fit: BoxFit.fill,) :
                  ],
                ),
              )
          ),
        ],
      ),

      floatingActionButton: new Visibility(

        visible: widget.isVisible,
        child: new FloatingActionButton(
          onPressed: () {
            final newPostingan = PostinganMdl(
              id: widget.postingan?.id ?? '',
              deskripsi: deskripsi,
              gambar: gambar,
            );
            if (widget.action.isCreate) {
              provider?.addData(postingan: newPostingan);
            } else {
              provider?.updateData(postingan: newPostingan);
            }

            Navigator.of(context).pop();
          },
          child: const Icon(Icons.send),
        )
      ),
    );
  }
}