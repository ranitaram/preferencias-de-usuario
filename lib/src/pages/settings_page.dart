import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:preferenciasusuario/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasusuario/src/widgets/menu_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({Key? key}) : super(key: key);

  static const String routeName = 'settings';

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  late bool _colorSecundario;
  int? _genero;
  String _nombre = 'Ramses';

  TextEditingController? _textEditingController;
  final prefs = PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = Settingspage.routeName;
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;

    _textEditingController =
        new TextEditingController(text: prefs.nombreUsuario);
  }

  _setSelectRadio(int? valor) {
    //prefs.setInt('genero', valor as int);

    prefs.genero = valor as int;

    _genero = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ajustes'),
          backgroundColor: (prefs.colorSecundario) ? Colors.pink : Colors.blue,
        ),
        drawer: const MenuWidget(),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: const Text(
                'Settings',
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            SwitchListTile(
                value: _colorSecundario,
                title: const Text('Color secundario'),
                onChanged: (value) {
                  setState(() {
                    _colorSecundario = value;
                    prefs.colorSecundario = value;
                  });
                }),
            RadioListTile(
              value: 1,
              title: Text('Masculino'),
              groupValue: _genero,
              onChanged: _setSelectRadio,
            ),
            RadioListTile(
                value: 2,
                title: Text('Femenino'),
                groupValue: _genero,
                onChanged: _setSelectRadio),
            const Divider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  helperText: 'Nombre de la persona usando el telefono',
                ),
                onChanged: (value) {
                  prefs.nombreUsuario = value;
                },
              ),
            )
          ],
        ));
  }
}
