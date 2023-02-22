
import 'package:aplikasi_mini_facebook/arsip_page.dart';
import 'package:aplikasi_mini_facebook/data.dart';
import 'package:aplikasi_mini_facebook/form_page.dart';
import 'package:aplikasi_mini_facebook/models/postingan_mdl.dart';
import 'package:aplikasi_mini_facebook/providers/postingan_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final provider = PostinganProvider();

  @override
  void initState() {
    super.initState();
    provider.onBuild();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        backgroundColor: Color(0xffD3D3D3),
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Mini Facebook",
          ),
          //Now let's add the action button
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArsipPage(provider: provider,)
                  ),
                );
              },
              icon: Icon(Icons.archive_outlined),
            ),

          ],
        ),

        body: Consumer<PostinganProvider>(
          builder: (context, provider, child) {
            final dpostingan = provider.dpostingan;
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: dpostingan.length,
              itemBuilder: (context, index) {
                final postingan = dpostingan[index];

                return PostCard(postingan: postingan);
              },
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormPage(provider: provider, action: ActionType.create, judul: "Postingan Baru", index: null, value: null)
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.postingan,
  }) : super(key: key);

  final PostinganMdl postingan;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostinganProvider>(context, listen: false);

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
                // IconButton(
                //   icon: Icon(Icons.more_horiz, size: 30, color: Colors.blue,),
                //   onPressed: () {},
                // )
                PopupMenuButton<int>(
                  icon: Icon(Icons.more_horiz, size: 30, color: Colors.blue,),
                  onSelected: (value) async {
                    if(value == 2){
                      provider.deleteData(id: postingan.id);
                    }else if(value == 1){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormPage(isVisibleArsip: false, provider: provider, action: ActionType.update, postingan: postingan, judul: "Edit Postingan",)
                        ),
                      );
                    }else if(value == 3){
                      var dpostingan = {
                        'deskripsi': postingan.deskripsi,
                        'gambar': postingan.gambar,
                      };

                      var savedData = await Data.getData();
                      savedData.insert(0, dpostingan);
                      await Data.saveData(savedData);

                      provider.deleteData(id: postingan.id);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArsipPage()
                        ),
                      );
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
                        child: Text('Arsipkan'),
                      ),
                    ];
                  },
                )
              ],
            ),

            SizedBox(
              height: 10.0,
            ),

            if (postingan.deskripsi != "")
              Text(
                postingan.deskripsi,
                style: TextStyle(color: Color(0xff282828), fontSize: 16.0),
              ),
            SizedBox(
              height: 10.0,
            ),
            if (postingan.gambar != "") Image.network(postingan.gambar),
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
}