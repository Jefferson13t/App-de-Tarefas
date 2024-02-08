import 'package:flutter/material.dart';
import 'package:teste_drive/components/task.dart';
import 'package:teste_drive/data/task_dao.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key?  key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen>{

  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  bool valueValidator(String? value){
    return value != null && value.isEmpty;
  }

  bool difficultyValidator(String? value){
    if(value != null && value.isEmpty){
      if(int.parse(value) > 5 || int.parse(value) < 1){

      }
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Nova tarefa"),
        ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: 650,
                width: 375,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if(valueValidator(value)){
                            return 'Insira o nome da tarefa';
                          }
                          return null;
                        },
                        controller: nameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nome',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if(difficultyValidator(value)){
                            return 'Insira a dificuldade entre 1 e 5';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: difficultyController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Dificuldade',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if(valueValidator(value)){
                            return 'Insira um URL de imagem';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        onChanged: (text){
                          setState(() {
                            
                          });
                        },
                        controller: imageController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Imagem',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.blue),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            imageController.text,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Image.asset("assets/images/nophoto.png");
                            },
                            fit: BoxFit.cover,
                          ),
                      ),
                    ),
                      ElevatedButton(
                        onPressed: (){
                            if(_formKey.currentState!.validate()){
                              TaskDao().save(Task(nameController.text, imageController.text, int.parse(difficultyController.text)));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Nova tarefa adicionada."),
                                ),
                              );
                                Navigator.pop(context);
                            }
                          }, 
                        child: const Text("Adicionar"),
                      ),
                  ],
                )
              ),
            ),
          ),
      ),
    );
  }
}