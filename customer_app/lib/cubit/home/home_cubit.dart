import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(DestinationSelectState());

  void destinationSeletion() {
    emit(DestinationSelectState());
  }

  void pickupSelection() {
    emit(PickupSeletionState());
  }

  void paymentSelection() {
    emit(PaymentSeletionState());
  }
}
