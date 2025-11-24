# Project Statement: Hotel Management System

## Problem Statement

Traditional hotel management systems often rely on complex relational databases and procedural programming, which can be inefficient for handling the logical relationships and constraints inherent in hotel operations. Manual management of room allocations, guest bookings, and staff scheduling leads to:

- **Inefficient Room Utilization**: Poor visibility into room availability and status
- **Booking Conflicts**: Double bookings and scheduling errors
- **Limited Reporting**: Difficulty generating real-time occupancy and revenue reports
- **Staff Management Challenges**: Inefficient assignment and tracking of staff duties
- **Data Integrity Issues**: Difficulty maintaining consistency across guest, room, and booking data

## Scope of the Project

### In-Scope
- Development of a logic-based hotel management system using Prolog
- Room inventory management with status tracking
- Guest profile management and booking system
- Staff information and shift management
- Automated reporting for occupancy and revenue
- Interactive menu-driven user interface
- Dynamic database updates for bookings and room status

### Out-of-Scope
- Graphical user interface (GUI)
- Payment processing integration
- Online booking portal
- Inventory management for hotel amenities
- Multi-hotel chain management
- Advanced analytics and forecasting

### Technical Boundaries
- **Platform**: Command-line Prolog application
- **Data Storage**: In-memory Prolog database (facts)
- **Persistence**: Session-based (no permanent storage between runs)
- **Scale**: Single hotel property management

## Target Users

### Primary Users
1. **Hotel Receptionists**
   - Front desk staff handling guest check-ins/check-outs
   - Personnel managing room assignments and availability
   - Staff processing booking reservations and modifications

2. **Hotel Managers**
   - Supervisors monitoring occupancy and revenue
   - Administrators overseeing staff assignments
   - Decision-makers requiring operational reports

### Secondary Users
3. **Hotel Owners**
   - Stakeholders reviewing performance metrics
   - Individuals monitoring business operations

4. **Audit Personnel**
   - Staff verifying booking records and financial reports
   - Quality assurance teams checking operational efficiency

### User Characteristics
- **Technical Level**: Basic computer literacy
- **Domain Knowledge**: Understanding of hotel operations
- **Access Level**: Varying permissions based on role
- **Frequency**: Daily operational use

## High-Level Features

1. **Room Inventory Tracking**
   - Complete room database with numbers, types, and pricing
   - Real-time availability status (available, occupied, reserved, maintenance)
   - Room type categorization (single, double, suite)
   - Automated status updates based on bookings

2. **Availability Management**
   - Quick room availability checks
   - Filtering by room type and status
   - Capacity planning and allocation
   - Maintenance scheduling coordination

3. **Guest Profile System**
   - Comprehensive guest database with contact information
   - Guest history and preference tracking
   - Search and retrieval functionality
   - Profile management and updates

4. **Booking Management**
   - Reservation creation with automatic ID generation
   - Check-in/check-out processing
   - Booking status tracking (pending, confirmed, checked-in, completed)
   - Conflict detection and prevention

5. **Employee Database**
   - Staff profiles with positions and contact details
   - Shift assignment and tracking
   - Role-based access management
   - Department-wise staff listing

6. **Operational Reports**
   - Real-time occupancy rate calculations
   - Revenue reporting from occupied rooms
   - Maintenance requirement alerts
   - Performance metrics and statistics
