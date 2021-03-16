

# Mobile Graphing Calculator Application 

- [Overview](#overview)
- [Local setup](#local-setup)
- [Architecture Overview](#architecture-overview)
- [Repository Overviews](#repository-overviews)
  - [calc_flutter](#calc-flutter)
  - [advanced_calculation](#advanced-calculation)
  - [cartesian_graph](#cartesian-graph)
  - [esoteric_nonsense](#esoteric-nonsense)
- [TODOs & Future Goals](#tod-os-and-future-goals)
- [Limitations and Future Issues](#limitations-and-future-issues)


## Overview

The Mobile Graphing Calculator brings functionality from classic graphing calculators to the modern era.  The application looks to retain the general look and feel of classic graphing calculators and bring both graphing and calculation functionality to a cross-platform mobile application. 

## Local setup 

This project is a [Flutter](https://flutter.dev/) application. For local development, this requires setting up an Android or iPhone emulator. Details for doing so can be found at the following for [Windows](https://flutter.dev/docs/get-started/install/windows),  [MacOS](https://flutter.dev/docs/get-started/install/macos), or [Linux](https://flutter.dev/docs/get-started/install/linux).

To run the project, 3 repositories must be checked out into the same folder as sibling.  As can be seen in the basic architecture several of the projects have dependencies on one another and to reference one another a relative path is utilized.  The folder structure should be as follows: 

```
/
└── advanced_calculation/
└── calc_flutter/
└── cartesian_graph/

```

After Flutter has [been installed and set up locally](https://flutter.dev/docs/get-started/install), the Flutter application can be run through main.dart in calc_flutter. 

## Architecture Overview

This project consists of 4 repositories which are responsible for different portions of the application. The repos are:

- [calc-flutter](https://github.com/SE-691-Graphing-Calculator/calc-flutter) (here)
- [advanced-calculation](https://github.com/SE-691-Graphing-Calculator/advanced_calculation)
- [cartesian-graph](https://github.com/SE-691-Graphing-Calculator/cartesian_graph)
- [esoteric-nonsense](https://github.com/SE-691-Graphing-Calculator/esoteric_nonsense)

![](https://i.ibb.co/1ZvVVRw/architecture.png)

### Backend Interface 

When performing calculations, esoteric nonsense is responsible for the lowest level execution.  While the rest of the stack is written in Dart, esoteric nonsense is written in Rust, which requires an [FFI bridge](https://flutter.dev/docs/development/platform-integration/c-interop) to broker communication.  To call into a rust library, a `.so` file must be created for the specific architecture desired.  For local development, an x86 architecture was primarily used, so generation of the x86 so was automated.  To deploy the application to additional architectures the automation must be expanded to include the additional desired architectures.  To load an `.so` file the file must be located in a folder specific to the desired architecture. The x86 android `.so` file is located within advanced_calculation at: 

```
android/src/main/jniLibs/x86/libcalc.so
```
If additional architectures are desired additional folders must be created and populated with the corresponding `.so` file; everything else should remain constant. For aarch64 and and armv7 architectures, the directories would be:
```
android/app/src/main
└── jniLibs
    ├── arm64-v8a
    │   └── libcalc.so
    ├── armeabi-v7a
        └── libcalc.so
```
When advanced_calculation is built within github actions, esoteric_nonsense is also built and the newly generated `.so` file is committed to the appropriate path.  Esoteric_nonsense may also be built locally by running the same commands that are seen in the github actions file within the project. 

## Repository Overviews 

### calc_flutter 
The calc_flutter repository represents the front-end user interface. As mentioned in the name of the repository, the front-end for the application is created in Flutter. There are two main components of the calc-flutter repo: The Calculator tab and Graph tab.  

The Calculator tab displays a digital calculator with numpad and pixel display, imitating the look of a graphing calculator. The numpad will have all the basic buttons to perform multiple levels of mathematical calculation from simple ones like addition, subtraction, multiplication, division…, to more advanced functions like logarithm, trigonometry, matrices, conversions.

The Graph tab  displays the graphing function. The Graph tab has two main screens: the Function Screen is where user enters the functions that they wish to plot on the x and y axis using the provided input pad, and the Graph Screen is where all the entered functions will be plotted and displayed on a pixelated graph display. The Graph Screen will handle multiple user interactions with the graph display and the plotline.  

The last and more minor part is the Settings component, which is responsible for storing app settings such as radian more versus degree mode, persistent storing and loading of data, and adjusting the app's color theme.

The app by default starts on the Calculator Tab. To switch to the graph screen, the user can press the button located on the top right of the app screen, on the AppBar.  

#### a. Calculator Tab 
The Calculator Tab's main function is to let users perform mathematical calculations. A pixelated display screen is located on the top part of the screen, where all the numbers or mathematic symbols will be displayed when pressed using the provided numpad. Besides the number button, the Calculator Tab features a custom number pad with all the basic algebra symbols, trigonometric (like sine, cosine, and tangent), logarithmic, etc. all of which are be processed in the backend.   

The calculator tab is primarily composed of two sections: the calculator display and the input pad.  The calculator display is an entirely custom display and input that allows inputted equations to be displayed, alongside calculation history.  By tapping, the cursor can be moved, and by swiping up or down prior entries can be recalled.  Further, when a syntax errors occurs the cursor is moved to the location of the cause of the error. 

The input pad has a fixed number of rows and columns, but each button scales to fill the space offered by the device running the application.  Using a variety of handlers, input pad buttons either input text, issue a command, or pop a modal.  Several classes have been created for the easy addition of new buttons using an existing template.  Custom buttons should rarely be needed as existing buttons offer a variety of options. 

When the user has completed entering desired inputs, the command_handler is resopnsible before doing any last minute substitutions before sending the input to the advanced_calculation library.  Primarily, the input_evaluator is responsible for input modifications ,such as variable substitutions, while the command handler helps with history management. A local storage system allows for the assignment of lettered variables, that are maintained within calc_flutter and substituted before passing to advanced_calculation for calcuation. 

#### b. Graph Tab 

##### Function Screen
As mentioned above, the Function Screen, from the user perspective, is the place where functions are entered with the help of a number pad (a shared version of the number pad from the calculator). On the Function screen, user will be able to input functions into input pads, add new function input pads, or remove already existing ones. Since the number pad is customized, all of the buttons pressed will be parsed through an Input Handler. Each button is given a specific value, and when it is pressed, the specified value will display on the function text box which is currently selected. By pressing the graph button on the number pad, all of the input functions will be validated to make sure that the syntax is valid and there is no empty text box. Finally, the Graph Screen is loaded with the input functions.  

##### Graph Screen
In the Graph Screen, on the top half is the graph display. This is where all the input functions are plotted on the X and Y axes with a given default scale, range, and domain. Below the display is the graph screen’s navigator, where a user can switch between three tabs: equations, table, and scale. On the right of the screen, next to the three-tab options is the cursor controller and magnification options. 

**Graph Display**: The graphing library, Cartesian Graph, is responsible for rendering all the plots, axes, cursor, and pixelated screen. The graph’s default state displays all functions’ plots, with the center of the display at the origin coordinate (x = 0, y = 0). Located at the 4 sides of the display are the arrow buttons that allow user to navigate up, down, left, and right around the screen. On top right of the display is the “Fullscreen” button, which allows user to expand the graph display to Fullscreen mode. On the graph display, there is also a cursor marked as a blue cross. The bottom left displays the current coordinate of the cursor, and this cursor can be moved around within the graph display screen by the cursor controller. The graph display is also interactable. User can tap on any point on the screen to move the cursor to that location and have the bottom left display the corresponding coordinates. 

The Cursor controller will allow the user to move the cursor around the graph screen. The travel distance or the distance of each step can be adjusted in the scale tab. Therefore, by adjusting the step distance, user can traverse the whole display screen by small increments or large increments. Right next to the Cursor Controller are the Magnification buttons that allow user to zoom in and out the graph screen. These button functions like the scale tab: automatically adjusting the X and Y min/max bounds to zoom in and out.  

**Equations Tab**: This tab displays all the user’s input functions, which are currently displayed on the graph display. When a function is chosen, the cursor will move to the plotline and allow user to trace along the line and examine the coordinates of the function.  

All the input functions from the front end will be parsed to Cartesian Graph’s library to be processed, calculated, and converted into pixelated plots.  

**Table Tab**: this tab displays a table that has all the corresponding y-coordinates for each of the plotted functions with a given range of x-coordinates. The default state when user first choose this tab is to start with x = -10 to x = 10. This default range can be changed in the scale tab. 

**Scale Tab**: This is where user can adjust various settings related to the graph display as well as the table’s x-range. The x min/max and y min/max in this tab define the bounds of the graph display, which also affect how the plot lines appear on the screen. The Step option changes how far the cursor moves when the cursor’s controller is triggered. 


### advanced_calculation 
The advanced calculation repository is a library that acts as a middle layer between the front-end and the back-end and is mainly responsible for validating the user input and translating the input based on the back-end requirements. Once the user input is checked for validation and translated, a function call is made to the back-end using library_loader. The repository consists of three major sub-components: _input_validation_, _translator_, and _transformer_. 

#### Input Validation
Input validation checks any input for syntax errors and determines the exact index location of any error. The validation flow is based on a state pattern. Given a user input, the validator checks for any existing syntax errors or invalid mathematical expressions. If the user input is valid, it gets the input ready for translator. Otherwise, if the user input is invalid, it returns an index value indicating the error. It supports validation for simple mathematical and matrix operations. Note: Matrix operations are supported up to 2 matrices and elements within a matrix does support mathematical expressions. 

- Mathematical operands including positive and negative digits, decimals, 𝜋, 𝑒, 𝑥 
- Mathematical operators including *, /, -, +, (, ), ^, ², ⁻¹ 
- Single parameter mathematical functions including:
  - "ln", "log", "abs", "sqrt", "ceil", "floor", "round", "trunc", "fract", "√", "sin", "cos", "tan", "sec", "csc", "cot", "sinh", "cosh", "tanh", "sech", "csch", "coth", "asin", "acos", "atan", "asec", "acsc", "acot","acoth","asinh", "acosh", "atanh", "acsch", "asech" 
- Two parameter mathematical functions including: 
  - "max", "min", "gcd", "lcm" 
- Matrix functions including "transpose", "reduced row echelon form", "inverse", determinant", "permanent” 

#### Translator
Once the validator has recognized a valid mathematical expression, the translator is responsible for updating the user input to a particular format based on the requirements of the back-end evaluator. Some of the main rules include: 

- Negative operands are sanitized to a special character: ` (backtick). This indicates a negative operand for the backend.
- Auto-add the missing closing parentheses and adjust the representation of expressions containing implied multiplication.
- Simplify the representation of some special operators, mathematical functions, and operand including: ²,⁻¹, √, 𝑥 
- Simplify the element(s) of the matrix containing mathematical expressions by calling the backend for those expressions and reconstructing the matrix with the results of those expressions.
- Break the expression containing matrices into different parameters to support different cases for a maximum of 2 matrix operations:
  - operator, Matrix Function for 1st matrix, 1st matrix, Matrix Function for 2nd matrix, 2nd matrix, scalar multiplier for 1st matrix, scalar multiplier for 2nd matrix, indicator if 2nd matrix is empty 

#### Transformer
The transformer is responsible for adjusting the result that came from the back-end based on the requirements that are set by the user at the time they made the request. This includes reporting the result to a certain number of decimal digits, displaying the result in radians or degrees, and displaying the result in scientific notation or engineering notation. 


### cartesian_graph 
The cartesian graph repository is responsible for creating a graphic display from given equations or coordinates.  The library was intended to be agnostic to the particular use case, and simply offers an API to specify equations, colors, bounds, sizes, etc. that will produce a graph.  Most of the library is straight-forward but grasping the graphing functionality may require a bit more effort. 

At the lowest level, the graph is a list of pixels.  Using the dart.ui paint library a list of pixels in combination with a specified width and height are transformed into an image.  Pixels added to the list are drawn from left to right until the specified width is reached, and then the next row is drawn.   PixelMap provides an interface to the list and allows pixels to be updated using a coordinate system, with (0,0) being the bottom left corner of the image.  Pixel clusters are groupings of pixels that are to be updated simultaneously.  When drawing a line, if the pixel were to be 1 pixel in size, the line would be nearly impossible for a user to see clearly.  By specifying a pixel density for the graph, the pixel cluster size is defined.  A pixel density of 2 would result in pixel clusters being 2x2 squares that consist of 4 pixels.  Pixel clusters are managed by the graph display and are updated using a coordinate system with 0,0 being the bottom left-most cluster.  When graph display is instructed to update a specific pixel cluster, the pixel map is instructed to update the corresponding pixels and does so by updating items in the pixel list.   

The coordinate system of the pixel map and pixel clusters differ from the coordinates specified by a user. While (0,0) is absolute for pixels and clusters (0,0) is relative for the user as (0,0) may map to a different pixel location depending on the original bounds provided.  When creating the graph the user specifies a min and max x and y.  With the desired bounds in mind, each pixel cluster can be mapped to the corresponding coordinates. 

![](https://i.ibb.co/mqZJw6N/coordinates.png)

The figure above shows a 6 pixel by 6 pixel graph, with a density of 2, an X min of –1, a X max of 1, a Y min of –1, and a Y max of 1.  The black plus is the legend of the graph which runs along the x and y axes.  The cells show the index of the pixel in the list at the lowest level, and along the sides are the graph coordinates of the pixel, cluster, and graph.  When debugging or enhancing the drawing logic keeping this graph handy is advised. 

### esoteric_nonsense 
The backend is responsible for all logic related to parsing mathematical expression strings and evaluating mathematical results. 

The backend is modularized according to safety of functions in concert with subject. An intentionally naïve approach is taken with respect to error handling and input verification as these aspects are handled on the middle layer, Advanced Calculation.

#### mod main
The module main.rs contains all unsafe code and deals with raw pointers in "C" format as lingua franca between the Rust backend and any language which calls its functions, in this case Flutter/Dart.

The module main.rs is intentionally absent of extensive control structures relating these inputs to their associated features as a matter of proper modularization. All functions in this module return primitives or direct derivatives of primitives (e.g.: `Vec<T>` for primitive T). It's intended scope is, purely, communication with external systems.

Currently, there are structs in main.rs for graphing with the specific implementation, found in Advanced Calculation, that may be further modularized, but it was not deemed neccessary at this time for ease of use. Upon the introduction of additional, large features, this may be reexamined.

#### mod s_y:
The module `s_y.rs` parses infix notated equations into a tree structure using Djikstra's Shunting Yard algorithm. The module also contains methods to evaluate these trees mathematically.

#### mod conversions:
The module conversions.rs contains the control stuctures and mathematics related to conversions between different varieties of units (e.g.:length, temperature, etc.).  The inputs for this module are intentionally limited to avoid the spread of unexpected behaviour with the use of exhaustive pattern matching.

#### mod matrix:
The module matrix.rs contains the control structures and mathematics related to the calculation of various operations on matrices. The inputs for this module are limited as a matter of UI simplification and scheduling. Future iterations of this module may consider writing a separate Shunting Yard algorithm that supports matrices in addition to primitives. If this is implemented, it should reside in this module, with the associated module functions being moved into submodules.

#### mod higher_math:
The module higher_math.rs is a currently depreciated attempt to use the Sympy Computer Algebra System within Rust. Although these functions work locally and on desktop-style OSes, the requirement for all code to run natively on a mobile device was not met. If the issue of compiling a Python interpreter for an arbitrary architecture can be solved, this will vastly widen the abilities of this repository with little further effort.
 

## TODOs & Future Goals
Many of the future goals at this point revolve around implementing more of the advanced math capabilities of a traditional graphing calculator. However, doing so would require a large-scale expansion of the backend to support high-end computer algebra. This is discussed further in the next section, but this would involve either creating from scratch a more complex Computer Algebra System, or adapting an existing CAS (we attempted this with SymPy in python) to work within this architecture. 

### Potential Future Features:
- Backend
  - Implement a more comprehensive computer algebra system in Rust (High Cost, High Risk)
  - Implement additional conversions in conversions.rs (Low Cost, Low Risk)
  - Implement additional algorithms in matrix.rs (Low Cost, Low Risk)
  - Implement a Shunting Yard algorithm for matrices in matrix.rs (Medium Cost, Low Risk)
  - Compile a Python Interpreter for all target architectures to use higher_math.rs (High Cost, High Risk)
- Advanced Calculation
  - Validator should support operations for more than 2 matrices 
  - The translator should support operations for more than 2 matrices 
  - The matrix function “lower upper decompose” should be supported by validator 
- Cartesian Graph
  - Upgrade line drawing to optionally be smooth rather than current boxy strategy 
- Calc Flutter
  - Addition of draw functions to calculator (line, circle, etc.)
  - Further UI support of matrix functions and any potential future backend features
  - Probing of efficiency and performance

## Limitations and Future Issues

As mentioned before, much of the future with this app depends on the ability to perform more complex math algorithms. This would require the creation of a much more advanced computer algebra system, which is not a simple task. 

If a future group were to undertake the implementation of a CAS using Rust they should be warned of the following challenges:

- Creating a CAS in any language is a very high man-year activity.
- Creating a CAS in any language requires an advanced level of mathematic knowledge, specifically in Abstract Algebra and, potentially, Galois Theory. 
- There are languages more suited to the task of creating a CAS than Rust, namely various dialects of LISP. This being said, with skill in Rust the language barrier should be the least problematic component.
- Creating a CAS in general is an High Risk activity, as there are tales of systems that had 300+ man-years invested, with nearly nothing to show for it.
		
There are positives to CAS creation in Rust:
-   Rust is safe, fast, reliable, and easily proven formally.
-   Rust, as of the time of writing, has no crate that acts as a CAS, so you would be making a massive contribution to both the Mathematics and Rust community.
-   Rust is, as of the time of writing, the most loved language among programmers.
-   Experience in Rust will be valuable in your future endeavors, as there are many who argue it will replace safe subsets of C++ for critical-system applications in the upcoming years.
