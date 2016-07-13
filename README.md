# Airports & Enums

![Airplane Landing](https://s3.amazonaws.com/learn-verified/airplane-landing.jpg)

## Objectives

 * Declare and define an enum to manage airport statuses

## Introduction
You can instantly get the status of just about anything and airports are no different. This lab takes you on the wild ride of beautifully displaying airport status information. So have a seat because there will probably be delays.

Open your `.xcworkspace` file and take a look at the project navigator. The `ViewController.swift` file is where you will be doing all your work. Outlet properties are already hooked up, along with some enum properties.

There is an optional property on the class called `airportDictionary` of type `NSDictionary`. When `viewDidLoad()` is called `airportDictionary` gets its value by calling a class method defined in the `AirportStatus` class. This method returns a dictionary containing statuses for five major US airports. Each status includes the airport's current delay information and weather. Click on the `AirportStatus.swift` file to take a peek and see all the properties. Even though it's not hooked up in this lab, the class is set up to work with information received from the [FAA's REST API](http://services.faa.gov/).

Head back to the `ViewController.swift` file. The file uses extensions to organize the different parts of the class. Scroll down to the `// MARK: Enums` line to view the extension of enums that are already defined for you including one that is not, `// Airport Code Enum`. This is the enum you will make. Let's get started.
<br />

### 1. Define the Airport Code enum
---
<ol>
  <li>
    Declare an enum called <code>AirportCode</code> of type <code>String</code>.
  </li>
  <li>
    Define cases for the following airport codes: ATL, DFW, JFK, LAX, ORD (keep them in alphabetical order).
    <br />
    <em>* Hint: Is there a way to define the cases in one line?</em>
  </li>
</ol>

### 2. Declare an `AirportCode` property on the class
---
Scroll up to the top of the `ViewController.swift` file to view all the class properties. As mentioned before you will see some enum properties already declared.
<ol>
  <li>
    Declare an optional enum property below the existing enum properties called <code>airportCode</code> of type <code>AirportCode</code> and assign a value of <code>.ATL</code> (That's one of your enum cases).
  </li>
  <li>
    Scroll down to <code>viewDidLoad()</code> and add a print statement inside the function to print your <code>airportCode</code> property.
  </li>
    <li>
    Build and run <code>⌘ + R</code> the application. You should see the optional ending in ".ATL" printed out in the console.
    </li>
</ol>

### 3. Assign a raw value to `airportCode` from a key inside `airportDictionary`
---
Scroll to the <code>airportDictionary</code> class property. You'll notice that the <code>didSet</code> property observer is defined for you. The code inside the observer unwraps the dictionary, sorts the keys, and grabs the first key value. The keys inside the dictionary are the same names as the <code>AirportCode</code> cases you defined in your enum. You're going to use the let constant <code>code</code> to initialize your <code>airportCode</code> property.
<ol>
  <li>
    Scroll up to your <code>airportCode</code> property and remove <code>.ATL</code> as the initial value. We will no longer assign an initial value here.
  </li>
  <li>
    Back inside the <code>didSet</code> observer of <code>airportDictionary</code>, assign the initial value to <code>airportCode</code> using the raw value initializer. The initializer takes a string argument.
    <br />
    <em>* Hint:</em> Check out <a href="https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145">Apple's documentation</a> and scroll down to the "Initializing from a Raw Value" section.
  </li>
</ol>
```swift
 if let code = sortedKeys.first {

     // declare and assign the property

}
```

<ol start = "3">
  <li>Build and run <code>⌘ + R</code> the application. You should still see the optional ending in ".ATL" printed out in the console.</li>
</ol>

### 4. Add a `didSet` property observer to the `airportCode` property and assign a value to `airportStatus`
---
So far you have created an enum but it's not really doing much. `airportDictionary` contains all the airport statuses of type `AirportStatus`. Each `AirportStatus` object has all the information you need to assign values to your view properties but we need to get it out of the dictionary first. Now that `airportCode` has an initial value we can use its raw value to access a status in `airportDictionary`. Remember that the keys inside the dictionary match the case names of your enum `["ATL": <AirportStatus>]`.
<ol>
 <li>
   Expand the declaration of the <code>airportCode</code> property to include a <code>didSet</code> property observer. Use the other properties in the class as a reference.
 </li><li>
   Inside the <code>didSet</code> property observer, assign a value to the <code>airportStatus</code> property. You can get the value by accessing   <code>airportDictionary</code>. Use the raw value of <code>airportCode</code> as the key.
   <br />
   <em>* Hint:</em> Enums come with a <code>.rawValue</code> property.
   <br />
   <em>* Hint:</em> You will need to downcast to <code>AirportStatus</code> when accessing the status from the dictionary.
 </li>
 <li>
  Build and run <code>⌘ + R</code> the application. You should see a big control tower, a pretty moon, and a Delta airplane.
 </li>
</ol>

### 5. Add a mutating function to the `AirportCode` enum
---
The view has a gesture set up so the user can swipe left to load the next airport status. Build and run `⌘ + R` the application. Swipe left a few times. While the transition might be fun, the information remains the same. You are going to change that! Scroll to your `AirportCode` enum to add a new function.
<ol>
  <li>
    Add a mutating function called <code>next()</code> below your cases.
    <br />
     <em>* Hint:</em> Check out <a href="https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html">Apple's documentation</a> and scroll to the section "Modifying Value Types from Within Instance Methods".
  </li><li>
    Inside the mutating function add a switch statement that switches <code>self</code>. The goal is to mutate the current value of <code>self</code> and change it to the next value (e.g., change <code>ATL</code> to <code>DFW</code>, <code>DFW</code> to <code>JFK</code>). The switch should be successive and exhaustive meaning the last case should switch <code>self</code> back to <code>ATL</code>.
  </li><li>
    Scroll to the section label <code>// MARK: Gesture</code>. Find the <code>changeStatusWithAnimation()</code> function. Use your <code>airportCode</code> property to call the <code>next()</code> function you just defined.
    <br /><br />
    When <code>next()</code> is called, the next airport status is retrieved from the <code>airportDictionary</code> and the view elements are updated with new information.
  </li>
</ol>
```swift
if statusReceived {

   // call next function here

   UIView.transitionWithView(view, duration: 0.5, options: .TransitionFlipFromRight, animations: nil, completion: nil)

}
```
<ol start = "4">
  <li>
    Build and run <code>⌘ + R</code> the application. Start swiping left to see the status for each airport.
  </li><li>
    Test <code>⌘ + U</code> the application.
  </li>
</ol>
