import 'package:flutter_alfabank/database/dao/cadastro_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfabank/componentes/item_menu.dart';
import 'package:flutter_alfabank/tela/lista_transferencia.dart';
import 'package:flutter_alfabank/tela/perfil.dart';
import 'package:flutter_alfabank/modulos/cadastro.dart';
import 'package:flutter_alfabank/componentes/progress_circular.dart';



class Home extends StatelessWidget {

  final CadastroDAO _dao = CadastroDAO();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder <Cadastro> (
        future: Future.delayed(Duration(seconds: 2)).then((value) => this._dao.findCadastro()),
        builder: (context, snapshot) {
          Cadastro cadastro = snapshot.data;

          switch(snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return ProgressCircular();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 8.0, 24.0),
                    child: Text(
                      "Olá, ${cadastro.nome}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      ItemMenu(
                        action: ListaTransferencia(),
                        icone: Icons.cached,
                        nomeMenu: "Transferências",
                      ),
                      ItemMenu(
                        action: ListaTransferencia(),
                        icone: Icons.cached,
                        nomeMenu: "Cartões",
                      ),
                      ItemMenu(
                        action: Perfil(cadastro),
                        icone: Icons.person,
                        nomeMenu: "Perfil",
                      )
                    ],
                  ),
                ],
              );
              break;
          }
          return Text("Error unkonw!");
        },
      ),
    );
  }
}