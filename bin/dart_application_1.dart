class OldPhonePadConverter {
  // Initialize the mapping from letters to numbers
  final removeLetter = '*';
  final Map<String, String> _numberToLetter = {
    '1': '&',
    '11': '\'',
    '111': '(',
    '2': 'A',
    '22': 'B',
    '222': 'C',
    '3': 'D',
    '33': 'E',
    '333': 'F',
    '4': 'G',
    '44': 'H',
    '444': 'I',
    '5': 'J',
    '55': 'K',
    '555': 'L',
    '6': 'M',
    '66': 'N',
    '666': 'O',
    '7': 'P',
    '77': 'Q',
    '777': 'R',
    '7777': 'S',
    '8': 'T',
    '88': 'U',
    '888': 'V',
    '9': 'W',
    '99': 'X',
    '999': 'Y',
    '9999': 'Z'
  };

  // Converts the given input string to the corresponding number string
  String convert(String inputString) {
    // Initialize the result string
    String result = '';

    // check if contain '*' and then remove character infront of it. Eg 55* -> result 5
    if (inputString.contains(removeLetter)) {
      var indexOf = inputString.indexOf(removeLetter);
      var replaceLetter = '';
      if (indexOf > 1) {
        replaceLetter = inputString[indexOf - 1];
      }
      inputString = inputString.replaceAll('$replaceLetter$removeLetter', ' ');
    }

    // check space contain from input string
    if (inputString.contains(' ')) {
      var inputStrings = inputString.split(" ");
      for (var char in inputStrings) {
        // Convert each character to the corresponding number
        result += getLetters(char);
      }
    } else {
      result += getLetters(inputString);
    }

    return result;
  }

  String getLetters(String inputString) {
    var result = '';
    if (inputString.length > 1) {
      var temp = '';
      for (int i = 0; i < inputString.length; i++) {
        if (temp.isEmpty) {
          temp = inputString[i];
        } else {
          if (temp.contains(inputString[i])) {
            temp += inputString[i];
            if (i == inputString.length - 1) {
              try {
                result += _numberToLetter[temp]!;
              } catch (e) {
                print('Invalid input');
              }
            }
          } else {
            result += _numberToLetter[temp]!;
            temp = inputString[i];
            if (i == inputString.length - 1) {
              try {
                result += _numberToLetter[temp]!;
              } catch (e) {
                print('Invalid input');
              }
            }
          }
        }
      }
    } else {
      try {
        result += _numberToLetter[inputString]!;
      } catch (e) {
        print('Invalid input');
      }
    }
    return result;
  }
}

void main() {
  OldPhonePadConverter converter = OldPhonePadConverter();
  String inputString = "4433555 555666#00";
  // Regex pattern for replace 0 or # with empty from input string
  RegExp regex = RegExp(r'0|#', caseSensitive: false);
  String outputString = converter.convert(inputString.replaceAll(regex, ''));
  print("Input: $inputString\nOutput: $outputString");
}
