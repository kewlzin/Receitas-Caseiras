import 'package:hive/hive.dart';
import 'package:projeto_flutter_mobile/models/receitas.dart';

class ReceitaHiveAdapter extends TypeAdapter<Receita> {
  final typeId = 0;

  @override
  Receita read(BinaryReader reader) {
    return Receita(
        nome: reader.readString(),
        tempo: reader.readString(),
        curtidas: reader.readString(),
        imagem: reader.readString(),
        preparo: reader.readString());
  }

  @override
  void write(BinaryWriter writer, Receita obj) {
    writer.writeString(obj.nome);
    writer.writeString(obj.tempo);
    writer.writeString(obj.curtidas);
    writer.writeString(obj.imagem);
    writer.writeString(obj.preparo);
  }
}
