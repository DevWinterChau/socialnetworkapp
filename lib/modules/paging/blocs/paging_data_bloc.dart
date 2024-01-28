import 'dart:core';
import 'package:rxdart/rxdart.dart';
import 'package:socialnetworkapp/modules/paging/repos/paging_repo.dart';
import 'package:socialnetworkapp/providers/bloc_provider.dart';

abstract class PagingDataBehaviorBloc<T> extends BlocBase{
  final _dataSubject = BehaviorSubject<List<T>?>();
  Stream<List<T>?> get pagingdataStream => _dataSubject.stream;
  List<T>? get pagingdataValue => _dataSubject.stream.value;

  final BehaviorSubject<bool> isLoadSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isLoadingStream => isLoadSubject.stream;
  bool get isLoadingValue => isLoadSubject.stream.value;
  PagingRepo get dataPagingRepo;


  Future<void> getData({Map<String, dynamic>? queryObject}) async {
    if(isLoadSubject.stream.value){
      return;
    }
    if(isLoadSubject.isClosed){
      isLoadSubject.sink.add(true);
    }
    try{
      if(dataPagingRepo.cursor > dataPagingRepo.total){
        print('... KHÔNG TẢI ĐƯỢC NỮA ....');
        return;
      }
      final result = await dataPagingRepo.getData(queryObject: queryObject);
      if (dataPagingRepo.isFirstPage) {
        _dataSubject.sink.add(result as List<T>);
      } else {
        if (_dataSubject.hasValue) {
          _dataSubject.sink.add([..._dataSubject.stream.value!, ...result as Iterable<T>]);
        } else {
          _dataSubject.sink.add([...result as Iterable<T>]);
        }
      }

      print(result);
    }catch(e){
      _dataSubject.sink.addError(e);
    }finally{
      Future.delayed(const Duration(microseconds: 300), (){
        if(!isLoadSubject.isClosed){
          isLoadSubject.sink.add(false);
        }
      });
    }
  }

  Future<void> reloadData({Map<String, dynamic>? queryObject}) async {
    dataPagingRepo.paging = null;
    try {
      final result = await dataPagingRepo.getData(queryObject: {'cursor': 0});
      _dataSubject.sink.add(List<T>.from(result));
    } catch (e) {
      print(e);
      _dataSubject.sink.addError(e);
    } finally {
      await Future.delayed(const Duration(milliseconds: 300));

      if (!isLoadSubject.isClosed) {
        isLoadSubject.sink.add(false);
      }
    }
  }

}