import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget { // Tela de cadastro de usuário
  @override
  _RegisterScreenState createState() => _RegisterScreenState(); // Cria o estado da tela de cadastro
}

class _RegisterScreenState extends State<RegisterScreen> { // Estado da tela de cadastro
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) { // Constrói a tela de cadastro
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'), // Título da tela de cadastro
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) { // Verifica se é possível voltar para a tela anterior
              Navigator.pop(context); 
            }
          },
        ),
      ),
      body: Padding( // Adiciona um preenchimento interno ao conteúdo da tela
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome'), 
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField( // Campo de texto para digitar o e-mail
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) { // Verifica se o campo está vazio
                      return 'Campo obrigatório'; // Mensagem de erro caso o campo esteja vazio
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) { // Verifica se o e-mail é válido
                      return 'Digite um e-mail válido'; // Mensagem de erro caso o e-mail seja inválido
                    }
                    return null;
                  },
                ),
                TextFormField(  // Campo de texto para digitar o telefone
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Telefone'), 
                  keyboardType: TextInputType.phone, // Define o teclado para digitar números de telefone
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField( // Campo de texto para digitar a senha
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) => value != null && value.length < 6
                      ? 'Mínimo 6 caracteres'
                      : null,
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: (value) =>
                      value != passwordController.text ? 'Senhas não coincidem' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cadastro realizado com sucesso!')),
                      );
                      if (Navigator.canPop(context)) { 
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text('Cadastrar'), // Botão para cadastrar o usuário
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
