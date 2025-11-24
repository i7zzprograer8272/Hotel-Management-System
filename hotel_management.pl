/*
 Hotel Management System - Prolog Implementation
 Author: [Your Name]
 Date: [Current Date]
 Course: Artificial Intelligence/Logic Programming
*/

% ==================== DATABASE FACTS ====================

% Room facts: room(Number, Type, Price, Status)
room(101, single, 100, available).
room(102, single, 100, available).
room(103, double, 150, available).
room(104, double, 150, occupied).
room(105, suite, 300, maintenance).
room(201, single, 100, available).
room(202, double, 150, available).
room(203, suite, 300, occupied).

% Guest facts: guest(ID, Name, Phone, Email)
guest(1, 'John Smith', '123-4567', 'john@email.com').
guest(2, 'Maria Garcia', '234-5678', 'maria@email.com').
guest(3, 'David Chen', '345-6789', 'david@email.com').

% Booking facts: booking(BookingID, GuestID, RoomNumber, CheckIn, CheckOut, Status)
booking(1001, 1, 104, '2024-01-15', '2024-01-18', confirmed).
booking(1002, 2, 203, '2024-01-16', '2024-01-20', confirmed).
booking(1003, 3, 103, '2024-01-17', '2024-01-19', pending).

% Staff facts: staff(ID, Name, Position, Shift)
staff(1, 'Alice Brown', 'receptionist', morning).
staff(2, 'Bob Wilson', 'manager', day).
staff(3, 'Carol Davis', 'housekeeping', evening).

% ==================== PREDICATES ====================

% Room Management Predicates

% List all rooms
list_rooms :-
    write('=== ALL ROOMS ==='), nl,
    room(RoomNum, Type, Price, Status),
    write('Room '), write(RoomNum), 
    write(' | Type: '), write(Type),
    write(' | Price: $'), write(Price),
    write(' | Status: '), write(Status), nl,
    fail.
list_rooms.

% Find available rooms of specific type
find_available_rooms(Type) :-
    write('=== AVAILABLE '), write(Type), write(' ROOMS ==='), nl,
    room(RoomNum, Type, Price, available),
    write('Room '), write(RoomNum), 
    write(' | Price: $'), write(Price), nl,
    fail.
find_available_rooms(_).

% Check room availability
is_room_available(RoomNum) :-
    room(RoomNum, _, _, available),
    write('Room '), write(RoomNum), write(' is available.'), nl.
is_room_available(RoomNum) :-
    room(RoomNum, _, _, Status),
    write('Room '), write(RoomNum), write(' is '), write(Status), write('.'), nl.

% Guest Management Predicates

% List all guests
list_guests :-
    write('=== ALL GUESTS ==='), nl,
    guest(ID, Name, Phone, Email),
    write('ID: '), write(ID),
    write(' | Name: '), write(Name),
    write(' | Phone: '), write(Phone),
    write(' | Email: '), write(Email), nl,
    fail.
list_guests.

% Find guest by name
find_guest(Name) :-
    guest(ID, Name, Phone, Email),
    write('=== GUEST FOUND ==='), nl,
    write('ID: '), write(ID), nl,
    write('Name: '), write(Name), nl,
    write('Phone: '), write(Phone), nl,
    write('Email: '), write(Email), nl.
find_guest(Name) :-
    \+ guest(_, Name, _, _),
    write('Guest not found.'), nl.

% Booking Management Predicates

% List all bookings
list_bookings :-
    write('=== ALL BOOKINGS ==='), nl,
    booking(BookID, GuestID, RoomNum, CheckIn, CheckOut, Status),
    guest(GuestID, Name, _, _),
    write('Booking ID: '), write(BookID),
    write(' | Guest: '), write(Name),
    write(' | Room: '), write(RoomNum),
    write(' | Dates: '), write(CheckIn), write(' to '), write(CheckOut),
    write(' | Status: '), write(Status), nl,
    fail.
list_bookings.

% Make a new booking
make_booking(GuestID, RoomNum, CheckIn, CheckOut) :-
    room(RoomNum, _, _, available),
    get_next_booking_id(NextID),
    assertz(booking(NextID, GuestID, RoomNum, CheckIn, CheckOut, pending)),
    retract(room(RoomNum, Type, Price, available)),
    assertz(room(RoomNum, Type, Price, reserved)),
    write('Booking created successfully! Booking ID: '), write(NextID), nl.
make_booking(_, RoomNum, _, _) :-
    \+ room(RoomNum, _, _, available),
    write('Room '), write(RoomNum), write(' is not available.'), nl.

% Get next booking ID
get_next_booking_id(NextID) :-
    findall(ID, booking(ID, _, _, _, _, _), IDs),
    (   IDs = [] -> NextID = 1001;
        max_list(IDs, MaxID), NextID is MaxID + 1
    ).

% Check-in guest
check_in(BookingID) :-
    booking(BookingID, GuestID, RoomNum, _, _, confirmed),
    retract(booking(BookingID, GuestID, RoomNum, CheckIn, CheckOut, confirmed)),
    assertz(booking(BookingID, GuestID, RoomNum, CheckIn, CheckOut, checked_in)),
    retract(room(RoomNum, Type, Price, reserved)),
    assertz(room(RoomNum, Type, Price, occupied)),
    write('Check-in successful for Booking ID: '), write(BookingID), nl.
check_in(BookingID) :-
    write('Cannot check-in. Booking '), write(BookingID), write(' not found or not confirmed.'), nl.

% Check-out guest
check_out(BookingID) :-
    booking(BookingID, GuestID, RoomNum, _, _, checked_in),
    retract(booking(BookingID, GuestID, RoomNum, CheckIn, CheckOut, checked_in)),
    assertz(booking(BookingID, GuestID, RoomNum, CheckIn, CheckOut, completed)),
    retract(room(RoomNum, Type, Price, occupied)),
    assertz(room(RoomNum, Type, Price, available)),
    write('Check-out successful for Booking ID: '), write(BookingID), nl.
check_out(BookingID) :-
    write('Cannot check-out. Booking '), write(BookingID), write(' not found or not checked-in.'), nl.

% Staff Management Predicates

% List all staff
list_staff :-
    write('=== HOTEL STAFF ==='), nl,
    staff(ID, Name, Position, Shift),
    write('ID: '), write(ID),
    write(' | Name: '), write(Name),
    write(' | Position: '), write(Position),
    write(' | Shift: '), write(Shift), nl,
    fail.
list_staff.

% Find staff by position
find_staff_by_position(Position) :-
    write('=== STAFF - '), write(Position), write(' ==='), nl,
    staff(ID, Name, Position, Shift),
    write('ID: '), write(ID),
    write(' | Name: '), write(Name),
    write(' | Shift: '), write(Shift), nl,
    fail.
find_staff_by_position(_).

% Reporting Predicates

% Show room occupancy report
occupancy_report :-
    findall(R, room(R, _, _, occupied), OccupiedRooms),
    findall(R, room(R, _, _, _), AllRooms),
    length(OccupiedRooms, OccupiedCount),
    length(AllRooms, TotalRooms),
    OccupancyRate is (OccupiedCount / TotalRooms) * 100,
    write('=== OCCUPANCY REPORT ==='), nl,
    write('Total Rooms: '), write(TotalRooms), nl,
    write('Occupied Rooms: '), write(OccupiedCount), nl,
    write('Occupancy Rate: '), write(OccupancyRate), write('%'), nl.

% Show revenue report
revenue_report :-
    findall(Price, (booking(_, _, RoomNum, _, _, checked_in), room(RoomNum, _, Price, _)), Prices),
    sum_list(Prices, TotalRevenue),
    write('=== REVENUE REPORT ==='), nl,
    write('Current Daily Revenue: $'), write(TotalRevenue), nl.

% Show maintenance report
maintenance_report :-
    write('=== MAINTENANCE REPORT ==='), nl,
    room(RoomNum, Type, _, maintenance),
    write('Room '), write(RoomNum), write(' ('), write(Type), write(') needs maintenance.'), nl,
    fail.
maintenance_report.

% ==================== MAIN MENU SYSTEM ====================

% Main menu predicate
main_menu :-
    nl, nl,
    write('================================='), nl,
    write('    HOTEL MANAGEMENT SYSTEM'), nl,
    write('================================='), nl,
    write('1. Room Management'), nl,
    write('2. Guest Management'), nl,
    write('3. Booking Management'), nl,
    write('4. Staff Management'), nl,
    write('5. Reports'), nl,
    write('6. Exit'), nl,
    write('================================='), nl,
    write('Enter your choice (1-6): '),
    read(Choice),
    process_choice(Choice).

% Process menu choice
process_choice(1) :- room_management_menu.
process_choice(2) :- guest_management_menu.
process_choice(3) :- booking_management_menu.
process_choice(4) :- staff_management_menu.
process_choice(5) :- reports_menu.
process_choice(6) :- write('Thank you for using Hotel Management System!'), nl, halt.
process_choice(_) :- write('Invalid choice. Please try again.'), main_menu.

% Room Management Menu
room_management_menu :-
    nl, write('=== ROOM MANAGEMENT ==='), nl,
    write('1. List All Rooms'), nl,
    write('2. Find Available Rooms'), nl,
    write('3. Check Room Availability'), nl,
    write('4. Back to Main Menu'), nl,
    write('Enter choice: '),
    read(Choice),
    process_room_choice(Choice).

process_room_choice(1) :- list_rooms, room_management_menu.
process_room_choice(2) :- 
    write('Enter room type (single/double/suite): '),
    read(Type), find_available_rooms(Type), room_management_menu.
process_room_choice(3) :-
    write('Enter room number: '),
    read(RoomNum), is_room_available(RoomNum), room_management_menu.
process_room_choice(4) :- main_menu.
process_room_choice(_) :- write('Invalid choice.'), room_management_menu.

% Guest Management Menu
guest_management_menu :-
    nl, write('=== GUEST MANAGEMENT ==='), nl,
    write('1. List All Guests'), nl,
    write('2. Find Guest by Name'), nl,
    write('3. Back to Main Menu'), nl,
    write('Enter choice: '),
    read(Choice),
    process_guest_choice(Choice).

process_guest_choice(1) :- list_guests, guest_management_menu.
process_guest_choice(2) :-
    write('Enter guest name: '),
    read(Name), find_guest(Name), guest_management_menu.
process_guest_choice(3) :- main_menu.
process_guest_choice(_) :- write('Invalid choice.'), guest_management_menu.

% Booking Management Menu
booking_management_menu :-
    nl, write('=== BOOKING MANAGEMENT ==='), nl,
    write('1. List All Bookings'), nl,
    write('2. Make New Booking'), nl,
    write('3. Check-in Guest'), nl,
    write('4. Check-out Guest'), nl,
    write('5. Back to Main Menu'), nl,
    write('Enter choice: '),
    read(Choice),
    process_booking_choice(Choice).

process_booking_choice(1) :- list_bookings, booking_management_menu.
process_booking_choice(2) :-
    write('Enter Guest ID: '), read(GuestID),
    write('Enter Room Number: '), read(RoomNum),
    write('Enter Check-in Date (YYYY-MM-DD): '), read(CheckIn),
    write('Enter Check-out Date (YYYY-MM-DD): '), read(CheckOut),
    make_booking(GuestID, RoomNum, CheckIn, CheckOut), booking_management_menu.
process_booking_choice(3) :-
    write('Enter Booking ID: '), read(BookingID),
    check_in(BookingID), booking_management_menu.
process_booking_choice(4) :-
    write('Enter Booking ID: '), read(BookingID),
    check_out(BookingID), booking_management_menu.
process_booking_choice(5) :- main_menu.
process_booking_choice(_) :- write('Invalid choice.'), booking_management_menu.

% Staff Management Menu
staff_management_menu :-
    nl, write('=== STAFF MANAGEMENT ==='), nl,
    write('1. List All Staff'), nl,
    write('2. Find Staff by Position'), nl,
    write('3. Back to Main Menu'), nl,
    write('Enter choice: '),
    read(Choice),
    process_staff_choice(Choice).

process_staff_choice(1) :- list_staff, staff_management_menu.
process_staff_choice(2) :-
    write('Enter position: '), read(Position),
    find_staff_by_position(Position), staff_management_menu.
process_staff_choice(3) :- main_menu.
process_staff_choice(_) :- write('Invalid choice.'), staff_management_menu.

% Reports Menu
reports_menu :-
    nl, write('=== REPORTS ==='), nl,
    write('1. Occupancy Report'), nl,
    write('2. Revenue Report'), nl,
    write('3. Maintenance Report'), nl,
    write('4. Back to Main Menu'), nl,
    write('Enter choice: '),
    read(Choice),
    process_report_choice(Choice).

process_report_choice(1) :- occupancy_report, reports_menu.
process_report_choice(2) :- revenue_report, reports_menu.
process_report_choice(3) :- maintenance_report, reports_menu.
process_report_choice(4) :- main_menu.
process_report_choice(_) :- write('Invalid choice.'), reports_menu.

% Start the application
start :-
    write('Loading Hotel Management System...'), nl,
    write('Type "main_menu." to start.'), nl.
