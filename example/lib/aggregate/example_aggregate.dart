import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_aggregate.freezed.dart';

class BookingAggregate
    extends AggregateWithStateAndId<BookingState, BookingId, BookingEvent> {
  BookingAggregate() : super(initialState: BookingState.initial());

  @override
  void registerEventHandlers(
    EventHandlerRegistry<BookingState, BookingEvent> registry,
  ) {
    registry.on<Booked>(
      (previousState, event) => previousState.onBooked(event),
    );
    registry.on<Imported>(
      (previousState, event) => previousState.onImported(event),
    );
  }

  book(int price) {
    ensureDoesntExist();
    apply(Booked(bookingId: 'anId', price: 20));
  }

  import(String id) {
    ensureDoesntExist();
    apply(Imported(bookingId: id));
  }
}

abstract class BookingEvent {}

class Booked extends BookingEvent {
  final String bookingId;
  final int price;

  Booked({required this.bookingId, required this.price});
}

class Imported extends BookingEvent {
  final String bookingId;

  Imported({required this.bookingId});
}

class BookingId {
  final String id;

  BookingId(this.id);

  @override
  String toString() => id;
}

@freezed
class BookingState with _$BookingState, StateWithId<BookingId> {
  BookingState._();
  factory BookingState({required BookingId? id, required int price}) =
      _BookingState;
  factory BookingState.initial() => BookingState(id: null, price: 0);

  BookingState onBooked(Booked event) =>
      copyWith(id: BookingId(event.bookingId), price: event.price);

  BookingState onImported(Imported event) =>
      copyWith(id: BookingId(event.bookingId));
}
