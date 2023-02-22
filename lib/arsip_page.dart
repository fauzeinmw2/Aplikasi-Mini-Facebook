import 'package:aplikasi_mini_facebook/form_page.dart';
import 'package:aplikasi_mini_facebook/providers/postingan_provider.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'models/postingan_mdl.dart';

class ArsipPage extends StatefulWidget {
  ArsipPage({Key? key, this.provider}) : super(key: key);

  final PostinganProvider? provider;

  @override
  _ArsipPageState createState() => _ArsipPageState();
}

class _ArsipPageState extends State<ArsipPage> {
  var savedData = [];

  getSavedData() async {
    var data = await Data.getData();
    setState(() {
      savedData = data;
    });
  }

  @override
  initState() {
    super.initState();
    getSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffD3D3D3),
        appBar: AppBar(
          title: Text('Arsip Postingan'),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
            itemCount: savedData.length,
            itemBuilder: (context, index){
              return Container(
                margin: EdgeInsets.only(bottom: 10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Color(0xFFFFFFFF),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiGLrYWwdFQRl8A_-51kRrcDCZxSHuQVy-8GUSkbYxCsI3h8SA1rg1bGCfNJx9YZ_bn9R51ySSNbqtfkKWevmzpG-qR9jYp1mvVssgZjbVzlFOnbm45tf0rd8BX7pAwXGNoo6L8RSkKGk00my9rawO8gu00WZSAgi8iSMCWXfsYPauizntQ1UG869K0Zg/s673/foto-profil-medsos.JPG"),
                            radius: 25.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Fauzein Mulya Warman",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "02 Desember 2023",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<int>(
                            icon: Icon(Icons.more_horiz, size: 30, color: Colors.blue,),
                            onSelected: (value) async {
                              if(value == 2){
                                Future.delayed(const Duration(seconds: 2), () async{
                                  var savedData = await Data.getData();
                                  savedData.removeAt(index);
                                  await Data.saveData(savedData);
                                  Navigator.of(context).pop();
                                });

                              }else if(value == 1){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FormPage(isVisible: false ,action: ActionType.update,index: index, value: savedData[index], judul: "Edit Postingan",))
                                ).then((value){
                                  getSavedData();
                                });
                              }else if(value == 3){
                                final newPostingan = PostinganMdl(
                                  id: savedData[index]['id'] ?? '',
                                  deskripsi: savedData[index]['deskripsi'],
                                  gambar: savedData[index]['gambar'],
                                );

                                widget.provider?.addData(postingan: newPostingan);

                                var deleteData = await Data.getData();
                                deleteData.removeAt(index);
                                await Data.saveData(deleteData);

                                Navigator.of(context).pop();
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<int>>[
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Text('Edit Postingan'),
                                ),
                                PopupMenuItem<int>(
                                  value: 2,
                                  child: Text('Hapus Postingan'),
                                ),
                                PopupMenuItem<int>(
                                  value: 3,
                                  child: Text('Posting'),
                                ),
                              ];
                            },
                          )
                        ],
                      ),

                      SizedBox(
                        height: 10.0,
                      ),

                      if (savedData[index]['deskripsi'] != "")
                        Text(
                          savedData[index]['deskripsi'],
                          style: TextStyle(color: Color(0xff282828), fontSize: 16.0),
                        ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (savedData[index]['gambar'] != "") Image.network(savedData[index]['gambar']),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        thickness: 1.5,
                        color: Color(0xFF505050),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.thumb_up, color: Colors.blue, size: 18,),
                                  SizedBox(width: 5,),
                                  Text("Like", style: TextStyle(color: Colors.blue),)
                                ],
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.chat, color: Colors.blue, size: 18),
                                  SizedBox(width: 5,),
                                  Text("Comment", style: TextStyle(color: Colors.blue),)
                                ],
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.share, color: Colors.blue, size: 18),
                                  SizedBox(width: 5,),
                                  Text("Share", style: TextStyle(color: Colors.blue),)
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
        ),
    );
  }
}