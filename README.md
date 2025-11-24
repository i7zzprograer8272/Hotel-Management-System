# Hotel-Management-System
# Hotel Management System - Prolog Implementation

## Overview
A comprehensive hotel management system implemented in Prolog that handles room bookings, guest information, staff management, and reporting. This system demonstrates practical application of logic programming for business operations.

## Features

###  Core Functionality
- **Room Management**: Track room availability, types, and pricing
- **Guest Management**: Maintain guest profiles and contact information
- **Booking System**: Handle reservations, check-ins, and check-outs
- **Staff Management**: Manage employee information and shifts
- **Reporting**: Generate occupancy, revenue, and maintenance reports

###  Technical Features
- Interactive menu-driven interface
- Dynamic database updates
- Input validation and error handling
- Comprehensive query system
- Real-time status tracking

## Technologies Used
- **Prolog** - Logic programming language
- **SWI-Prolog** - Recommended implementation
- **Dynamic Database** - Facts and rules for data management

## Installation & Setup

### Prerequisites
- SWI-Prolog installed on your system

### Running the Application

1. **Start Prolog**:
   ```bash
   swipl
   ```

2. **Load the program**:
   ```prolog
   consult('hotel_management.pl').
   ```

3. **Start the application**:
   ```prolog
   main_menu.
   ```

### Quick Test Queries
```prolog
% List all available rooms
find_available_rooms(single).

% Check specific room availability
is_room_available(101).

% View all bookings
list_bookings.

% Generate occupancy report
occupancy_report.
```

## Menu System

### Main Menu Options
```
1. Room Management
2. Guest Management  
3. Booking Management
4. Staff Management
5. Reports
6. Exit
```

### Room Management
- List all rooms with status
- Find available rooms by type
- Check specific room availability

### Guest Management
- View all guest profiles
- Search guests by name
- Manage guest information

### Booking Management
- View all bookings
- Create new reservations
- Process check-ins/check-outs
- Update booking status

### Staff Management
- View all staff members
- Search staff by position
- Manage shifts and roles

### Reports
- Occupancy rates and statistics
- Revenue calculations
- Maintenance requirements

## Database Structure

### Room Facts
```prolog
room(Number, Type, Price, Status)
% Types: single, double, suite
% Status: available, occupied, reserved, maintenance
```

### Guest Facts
```prolog
guest(ID, Name, Phone, Email)
```

### Booking Facts
```prolog
booking(BookingID, GuestID, RoomNumber, CheckIn, CheckOut, Status)
% Status: pending, confirmed, checked_in, completed
```

### Staff Facts
```prolog
staff(ID, Name, Position, Shift)
% Positions: receptionist, manager, housekeeping
% Shifts: morning, day, evening
```

## Example Usage

### Making a Booking
1. Go to Booking Management → Make New Booking
2. Enter Guest ID, Room Number, and dates
3. System automatically assigns Booking ID

### Check-in Process
1. Find confirmed booking
2. Process check-in to change room status to occupied
3. Update booking status to checked_in

### Generating Reports
- Occupancy Report: Shows current hotel capacity
- Revenue Report: Calculates daily revenue from occupied rooms
- Maintenance Report: Lists rooms needing maintenance

## Testing

### Sample Test Cases
```prolog
% Test room availability
?- is_room_available(101).
% Expected: Room 101 is available.

% Test booking creation
?- make_booking(1, 102, '2024-01-20', '2024-01-22').
% Expected: Booking created with new ID

% Test reporting
?- occupancy_report.
% Expected: Occupancy statistics
```

### Expected Output Examples
```
=== ALL ROOMS ===
Room 101 | Type: single | Price: $100 | Status: available

=== OCCUPANCY REPORT ===
Total Rooms: 8
Occupied Rooms: 2
Occupancy Rate: 25%
```

## Troubleshooting

### Common Issues
1. **File not found**: Ensure hotel_management.pl is in current directory
2. **Syntax errors**: Check for missing periods or parentheses
3. **Undefined predicates**: Verify all predicates are properly defined

### Debugging Tips
- Use `listing.` to view all predicates
- Check fact consistency with `room(X,Y,Z,W).`
- Verify dynamic updates with `booking(A,B,C,D,E,F).`

## Project Structure
```
hotel_management.pl
├── Database Facts (rooms, guests, bookings, staff)
├── Room Management Predicates
├── Guest Management Predicates  
├── Booking Management Predicates
├── Staff Management Predicates
├── Reporting Predicates
└── Menu System
```

## Academic Purpose
This project demonstrates:
- Logic programming principles
- Database management in Prolog
- Rule-based systems
- Interactive application development
- Business logic implementation

---
