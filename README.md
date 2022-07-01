# Ruby Aircraft Queue Problem
Implement an air-traffic take off system that manages the order of aircraft departing from a queue.

The system should respond to 3 requests:
1. System boot used to start the system
2. Enqueue an aircraft to add an aircraft to the system
3. Dequeue an aircraft to remove an aircraft from the system

An Aircraft should have the following properties:
Type: Passenger or Cargo
Size: Small or Large

The performance of the system should be considered. It should be able to handle any number of aircraft, and should be reasonably efficient managing tens of thousands of aircraft.

The rules for dequeuing an aircraft are as follows:
1. Passenger aircraft take precedence over Cargo aircraft
2. Large aircraft take precedence over Small aircraft of the same type
3. Earlier enqueued aircraft take precedence over later enqueued aircraft of the same type and size

Your Ruby on Rails application should contain the following:
1. The home page should return a page with a button to boot the system
2. A form to enqueue aircraft
3. A button to dequeue aircraft that also displays a message about which aircraft was dequeued
4. A list of currently enqueued aircraft
5. Preferably the solution does not use a database, but uses memory for queue management

Additional Notes:
Rails >= 5.0 should be used
UI does not need to be polished, just functional.
