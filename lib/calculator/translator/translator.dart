class Translator {

// translates display values of a calculator expressions into proper format for processing
  String translate(String input) {
    String translated;
    if (input == null) return input;
    translated = _addImpliedMultiply(input);
    translated = _fixSpacing(translated);
    translated = _addClosingParentheses(translated);
    return translated.trim();
  }

  // corrects the expression's spacing regardless of previous whitespace
  String _fixSpacing(String input) {
    String result;
    result = input. replaceAll(new RegExp( r"\s*\+\s*"    ), " + "    );
    result = result.replaceAll(new RegExp( r"\s*-\s+"     ), " - "    );
    result = result.replaceAll(new RegExp( r"\s*\*\s*"    ), " * "    );
    result = result.replaceAll(new RegExp( r"\s*/\s*"     ), " / "    );
    result = result.replaceAll(new RegExp( r"\s*\^\s*"    ), " ^ "    );
    result = result.replaceAll(new RegExp( r"\s*\(\s*"    ), " ( "    );
    result = result.replaceAll(new RegExp( r"\s*\)\s*"    ), " ) "    );
    result = result.replaceAll(new RegExp( r"\s*²\s*"           ), " ^ 2 "  );
    result = result.replaceAll(new RegExp( r"\s*ln\(\s*"  ), "ln ( "  );
    result = result.replaceAll(new RegExp( r"\s*sin\(\s*" ), "sin ( " );
    result = result.replaceAll(new RegExp( r"\s*cos\(\s*" ), "cos ( " );
    result = result.replaceAll(new RegExp( r"\s*tan\(\s*" ), "tan ( " );
    result = result.replaceAll(new RegExp( r"\s*log\(\s*" ), "log ( " );
    return result;
  }

  // append missing closing parentheses
  String _addClosingParentheses(String input) {
    String result = input.replaceAll(new RegExp(r"\s*$"), " ");  // add ending space
    var openingMatches = new RegExp(r"\(").allMatches(input);
    var closingMatches = new RegExp(r"\)").allMatches(input);
    for (var i = 0; i < openingMatches.length - closingMatches.length; i++) {
      result += ") ";
    }
    return result;
  }

  // change all tokens such as '3sin' into '3 * sin' and '3(' to '3 * ('
  String _addImpliedMultiply(String input) {
    String result;
    result = input.replaceAllMapped(new RegExp(r'([0-9]+)([a-z]+)'), (Match m) {
      return "${m.group(1)} * ${m.group(2)}";
    });
    result = result.replaceAllMapped(new RegExp(r'([0-9]+)(\()'), (Match m) {
      return "${m.group(1)} * ${m.group(2)}";
    });
    return result;
  }

}