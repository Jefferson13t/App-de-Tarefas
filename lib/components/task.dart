import 'package:flutter/material.dart';
import 'package:teste_drive/data/task_dao.dart';
import 'difficulty.dart';

class Task extends StatefulWidget {
  final String name;
  final String photo;
  final int difficulty;

  Task(this.name, this.photo, this.difficulty, {Key? key}) : super(key: key);

  int level = 0;

  @override
  State<Task> createState() => _TaskState();

}

class _TaskState extends State<Task> {

  bool assetOrNetwork(){
    return !widget.photo.contains('http');
  }

  @override
  Widget build(BuildContext context){
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                  ),
                  height: 140,
                ),
                Column(
                  children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.zero, bottomRight: Radius.zero),
                      color: Colors.white
                    ),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100, 
                          height: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.zero, bottomRight: Radius.zero),
                    ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4) ),
                            child: assetOrNetwork() ? Image.asset(
                              widget.photo,
                              fit: BoxFit.cover,
                          ) :  Image.network(
                            widget.photo,
                            fit : BoxFit.cover,
                          ),
                          ),                          
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                            width: 200,
                            child: Text(widget.name, style: const TextStyle(
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis,
                              ), 
                            ), 
                          ),
                           Difficulty(difficultyLevel: widget.difficulty,)
                          ]
                        ),
                        SizedBox( 
                          width: 70,
                          height: 70,
                          child: ElevatedButton(
                            onLongPress: (){
                              TaskDao().delete(widget.name);
                            },
                            onPressed: (){
                          setState(() {
                            widget.level++;
                          });
                        }, child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.arrow_drop_up
                              ),
                              Text("UP", style: TextStyle(
                                fontSize: 14, 
                              ))
                            ]

                          )
                        ),
                      )],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                            width: 200,
                            child: LinearProgressIndicator(
                              color: Colors.white,
                              value: widget.difficulty > 0 ? widget.level / widget.difficulty / 10 : 1,
                            ),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text("Nível ${widget.level}", style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            )
                          )
                      ),
                    ]
                  )
                  
                  ],
                ),
                
              ],
            )
          );
  }
}
