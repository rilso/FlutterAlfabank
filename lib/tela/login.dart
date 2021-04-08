
import 'package:flutter_alfabank/componentes/editor.dart';
import 'package:flutter_alfabank/tela/formulario_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfabank/tela/home.dart';
import 'package:flutter_alfabank/database/dao/cadastro_dao.dart';

class Login extends StatelessWidget {

  final TextEditingController _controladorCampoEmail = TextEditingController();
  final TextEditingController _controladorCampoSenha = TextEditingController();

  final CadastroDAO _dao = CadastroDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controller: this._controladorCampoEmail,
                rotulo: "email",
                dica: "railson@gmail.com",
                tipoInput: TextInputType.text,
              ),
              Editor(
                controller: this._controladorCampoSenha,
                rotulo: "Senha",
                dica: "1234",
                tipoInput: TextInputType.text,
              ),
              RaisedButton(
                onPressed: () {
                  var email = this._controladorCampoEmail.text;
                  var senha = this._controladorCampoSenha.text;

                  this._dao.logar(email, senha)
                      .then((id) {
                    if(id == null){
                    }else{
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Home();
                        }),
                        ModalRoute.withName('lista_transferencia'),
                      );
                    }
                  }
                  );
                },
                child: Text("Logar"),
              ),

              RaisedButton(
                onPressed: () {
                  Future <int> future = Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return FormularioCadastro();
                      })
                  );
                },
                child: Text("Cadastrar"),
              ),

            ],
          ),
        ));
  }
}