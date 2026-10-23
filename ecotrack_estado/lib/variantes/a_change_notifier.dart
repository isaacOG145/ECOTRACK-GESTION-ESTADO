// ALTERNATIVA A — ChangeNotifier (viene con Flutter).
//
// Cableado: el ViewModel se crea una vez y se pasa por constructor a cada
// pantalla. Cada pantalla lo escucha con ListenableBuilder.
// Costo: si hay muchas pantallas anidadas, hay que pasarlo de mano en mano.

import 'package:ecotrack_estado/datos/consumo_repository.dart';
import 'package:ecotrack_estado/presentacion/consumos_view_model.dart';
import 'package:ecotrack_estado/presentacion/vistas.dart';
import 'package:flutter/material.dart';

class AppChangeNotifier extends StatefulWidget{

  const AppChangeNotifier({super.key, required this.repositorio});

  final ConsumoRepository  repositorio;

  @override
  State<AppChangeNotifier> createState() => _AppChangeNotifierState();
}

class  _AppChangeNotifierState extends State<AppChangeNotifier>{

  late final _vm = ConsumosViewModel(widget.repositorio);

  @override
  void dispose(){
    _vm.dispose();

    super.dispose();
  }


  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: DosPantallas(
        titulo: 'A ChangeNotifier',
        registro: RegistroCN(vm: _vm),
        historial: HistorialCN(vm: _vm),
      ),
    );
  }
}

class RegistroCN extends StatelessWidget{

  const RegistroCN({super.key, required this.vm});

  final ConsumosViewModel vm;

  @override
  Widget build(BuildContext context){
    return ListenableBuilder(
        listenable: vm,
        builder: (context, _) => FormularioRegistro(
          alGuardar: vm.guardar,
          error: vm.error,
          guardando: vm.guardando,
        )
    );
  }
}

class HistorialCN extends StatelessWidget{

  const HistorialCN({super.key, required this.vm});

  final ConsumosViewModel vm;

  @override
  Widget build(BuildContext context){

    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => ListaHistorial(consumos: vm.consumos)
    );
  }

}