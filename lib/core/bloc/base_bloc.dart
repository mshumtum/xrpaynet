import 'dart:async';

abstract class BaseBloc{

  dispose();

  addInSink(StreamController streamController, var response){
    if(response.statusCode == 200){
      streamController.add(response);
    }else{
      streamController.addError(response);
    }
  }

}