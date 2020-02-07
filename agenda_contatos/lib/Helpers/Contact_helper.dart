
  import 'package:sqflite/sqflite.dart';
  import 'package:path/path.dart';

  final String contactTABLE = "contactTABLE";
  final String idColumn = "idColumn";
  final String nameColumn = "nameColumn";
  final String emailColumn = "emailColumn";
  final String phoneColumn = "phoneColumn";
  final String imgColumn = "imgColumn";
  final String genColumn = "genColumn";

class ContactHelper{

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb()async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");

  return await openDatabase(path,version: 1,onCreate: (Database db,int newerVersion)async{
      await db.execute(
        "CREATE TABLE $contactTABLE(" +
        "$idColumn INTEGER PRIMARY KEY,"+
        "$nameColumn TEXT,"+
        "$emailColumn TEXT,"+
        "$phoneColumn TEXT,"+
        "$genColumn TEXT,"+
        "$imgColumn TEXT)"        
      );
    });
  }

  Future<Contact> saveContact(Contact contact)async{
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTABLE, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id)async{
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTABLE,
    columns: [idColumn,nameColumn,emailColumn,phoneColumn,genColumn,imgColumn],
    where: "$idColumn =?",
    whereArgs: [id]);

    if(maps.length > 0){
      return Contact.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> deleteContact(Contact contact)async{
    Database dbContact = await db;
    return await dbContact.delete(contactTABLE,
    where: "$idColumn =?",
    whereArgs: [contact.id]);
  }

  Future<int> updateContact(Contact contact)async{
    Database dbContact = await db;
    return await dbContact.update(contactTABLE,contact.toMap(),
    where: "$idColumn =?",
    whereArgs: [contact.id]
    );
  }

  Future<List> getAllContacts()async{
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTABLE");
    List<Contact> listContact = List();

    for(Map m in listMap){
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber()async{
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery(
      "SELECT COUNT(*) FROM $contactTABLE"));
  }

  Future close()async{
    Database dbContact = await db;
    dbContact.close();
  }
}



class Contact{

  int id;
  String name;
  String email;
  String phone;
  String img;
  String gen;

  Contact();

  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
    gen = map[genColumn];
  }

  Map toMap(){
    Map<String,dynamic> map ={
      nameColumn :name,
      emailColumn : email,
      phoneColumn : phone,
      genColumn : gen,
      imgColumn : img
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  String toString(){
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, gen: $gen, img: $img)";
  }
}