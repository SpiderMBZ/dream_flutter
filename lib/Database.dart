
import 'dart:io';
import 'package:dream/core.dart' as core;
import 'package:pointycastle/export.dart';
import 'package:sqflite/sqflite.dart';


import 'package:convert/convert.dart';
import 'dart:convert';
import 'dart:typed_data';

class DBProvider {
  bool created=false;
  Future<void> checkdb() async {
    String path="";
    path=(await getDatabasesPath());
    File db=await File(path + '/admin.db');

    
    core.admin =!(await db.exists())? await openDatabase(
      (await getDatabasesPath().toString() + '/admin.db'), version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE admin_table (nb INTIGER ,point TEXT,hale TEXT,omer TEXT,jens TEXT,max TEXT,vippoint TEXT,max_message TEXT,name TEXT)');
        created = true;
      },):await openDatabase(db.path);

    db=await File(path + '/feed.db');

    core.feeddb =!(await db.exists())? await openDatabase(
      (await getDatabasesPath().toString() + '/feed.db'), version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE feed_table (nb INTEGER ,feedmessage TEXT,rad TEXT,status TEXT,time TEXT)');
      },):await openDatabase(db.path);


    db=await File(path + '/ahlam.db');


    core. ahlam =!(await db.exists())? await openDatabase(
      (await getDatabasesPath().toString() + '/ahlam.db'), version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE ahlam_table (nb INTEGER ,holm TEXT,tfser TEXT,mode INTEGER,status TEXT,time TEXT)');
      },):await openDatabase(db.path);
    print(created);
    if (created) {
      created = false;
      insertadmindb(
          1,
          '5',
          '',
          '',
          '',
          '',
          '',
          '',
          '');
    }

//for(int i=0;i<50;i++){insertahlamdb(i,"holm", "tsfer", 0,"status", "2200002");}
    // insertahlamdb(0,"holm", "tsfer", 0,"status", "2200002");
    //  insertahlamdb(1,"holm11", "tsfer111", 0,"111status", "1111112200002");
    // await updateahlamdb(1, null,"asdsdsdsdsdsd", null,null, null);
    await getdb(0);
    await getdb(1);
    await getdb(2);


  }




  Future<void> insertahlamdb(int nb ,String holm,String tfser,int mode,String status,String time) async {
    await core.ahlam?.transaction((txn)async {
      await txn.rawInsert('INSERT INTO ahlam_table(nb,holm,tfser,mode,status,time) VALUES($nb, "$holm","$tfser",$mode,"$status","$time")');
    });
  }
  Future<void> insertfeeddb(int nb ,String holm,String tfser,String status,String time) async {
    await core.feeddb?.transaction((txn)async {
      await txn.rawInsert('INSERT INTO feed_table(nb,feedmessage,rad,status,time) VALUES($nb, "$holm","$tfser","$status","$time")');
    });
  }
  Future<void> insertadmindb(int nb ,String point,String hale,String omer,String jns,String max,String vippoint,String maxmessage,String name) async {
    await core.admin?.transaction((txn)async {
      await txn.rawInsert('INSERT INTO admin_table(nb,point,hale,omer,jens,max,vippoint,max_message,name) VALUES($nb, "$point","$hale","$omer","$jns", "$max","$vippoint","$maxmessage","$name")');
    });
  }





  Future<void> updateahlamdb(int? nb ,String? holm,String? tfser,int? mode,String? status,String? time) async {
    await core.ahlam?.rawUpdate('UPDATE ahlam_table SET  holm = ? , tfser = ?, mode = ? , status = ? , time = ? WHERE nb = ?',
        [ "$holm","$tfser","$mode","$status","$time","$nb"]);


  }
  Future<void> updatefeeddb(int? nb ,String? holm,String? tfser,String? status,String? time) async {
    await core.feeddb?.rawUpdate('UPDATE feed_table SET  feedmessage = ? , rad = ? , status = ? , time = ? WHERE nb = ?',
        [ "$holm","$tfser","$status","$time","$nb"]);

  }
  Future<void> updateadmindb(int? nb ,String? point,String? hale,String? omer,String? jns,String? max,String? vippoint,String? maxmessage,String? name) async {
    await core.admin?.rawUpdate('UPDATE  admin_table SET  point = ? , hale = ?, omer = ? , jens = ? , max = ? , vippoint = ? , max_message = ? , name = ? WHERE nb = ?',
        [ "$point","$hale","$omer","$jns", "$max","$vippoint","$maxmessage","$name","$nb"]);


  }






  Future<void> deleteahlamdb(int nb) async {
    await  core.ahlam!.rawDelete('DELETE FROM ahlam_table WHERE nb = ?', ['$nb']);
  }
  Future<void> deletefeeddb(int nb) async {
    await  core.feeddb!.rawDelete('DELETE FROM feed_table WHERE nb = ?', ['$nb']);
  }



  Uint8List decrypt(Uint8List ciphertext, Uint8List key, Uint8List iv) {
    CBCBlockCipher cipher = new CBCBlockCipher(new AESFastEngine());
    ParametersWithIV<KeyParameter> params = new ParametersWithIV<KeyParameter>(new KeyParameter(key), iv);
    PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null> paddingParams = new PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(params, null);
    PaddedBlockCipherImpl paddingCipher = new PaddedBlockCipherImpl(new PKCS7Padding(), cipher);
    paddingCipher.init(false, paddingParams);
    return paddingCipher.process(ciphertext);
  }



  final List<String> alaka = [
    "لاتوجد علاقة", "متزوج/ة", "مطلق/ة", "ارمل/ة", "توجد علاقة"
  ],
      nw3 = ['ذكر', 'انثى'];

  Future<void> getdb(int dbnb) async {
    switch(dbnb){
      case 0:
        final ad=  await core.admin!.rawQuery('SELECT * FROM  admin_table');
        core.name=ad[0]["name"].toString();
        try{
        core.omer=int.parse(ad[0]["omer"].toString()).toString();
        }catch(E){}
        if(alaka.contains(ad[0]["hale"].toString()))
        core.hale=ad[0]["hale"].toString();
        if(nw3.contains(ad[0]["jens"].toString()))
        core.jns=ad[0]["jens"].toString();
        try {
          core.point = int.parse(ad[0]["point"].toString());
        }
        catch(E){
          try{

            String ivHex = 'qlkjmnbjhyulkjhg';
            String passphraseUtf8 = 'asdkhakjsdhjkagkjashdkjahksadasd';
            String ciphertextBase64 = ad[0]["point"].toString();
            Uint8List key = Uint8List.fromList(utf8.encode(passphraseUtf8));
            Uint8List ciphertext = base64.decode(ciphertextBase64);
            Uint8List iv =Uint8List.fromList(utf8.encode(ivHex));
            Uint8List decrypted = decrypt(ciphertext, key, iv);

            core.point = int.parse(utf8.decode(decrypted));

          }catch(E){

          }

        }
        break;
      case 1:
        core.holm=( await core.ahlam!.rawQuery('SELECT * FROM ahlam_table'));
        List<Map> abbc=List.from(core.holm!) ;
        abbc.sort((a, b) =>(b["nb"]).compareTo(a["nb"]));
        core.holm=abbc;
        core.abc.value+=1;
        break;
      default:
        core.abc.value+=1;
        core.feed= await core.feeddb!.rawQuery('SELECT * FROM feed_table');
        List<Map> abbc=List.from(core.feed!) ;
        abbc.sort((a, b) =>(b["nb"]).compareTo(a["nb"]));
        core.feed=abbc;
    }
  }

}