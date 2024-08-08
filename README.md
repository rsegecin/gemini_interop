# gemini_interop

This Flutter Windows application leverages Gemini to streamline the development process by automating the conversion of C# DTOs and Controllers into Flutter-compatible formats. The generated DTOs are utilized directly in the Flutter app, while the Controllers are transformed into Riverpod data repositories. The app offers two primary functionalities:

- Single File Conversion: Users can select a specific file for conversion and immediately view the generated output within the app.
- Batch Conversion: The app enables users to choose an entire directory of files for batch conversion, automating the generation of corresponding Flutter code.

You can extend the app's capabilities to convert files from different languages by modifying the instructions.txt document. Provide Gemini with specific instructions and examples for the desired language conversion within this file.

## Getting Started

To build this project add a new configuration to your `launch.json` file:

    {
        "name": "gemini_interop",
        "request": "launch",
        "type": "dart",
        "args": [
            "--dart-define=GEMINI_KEY=[YOUR GEMINI API KEY]", 
        ]
    }

if `launch.json` on vscode click in `Run and Debug` and click "create a launch.json file".

To run this project set an environment variable called "GEMINI_KEY" with its value the API key.