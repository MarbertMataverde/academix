/// The `Regex` class provides a regular expression pattern for email validation.
///
/// The `email` constant string represents the regular expression pattern for validating email addresses. It follows the standard email format rules, allowing alphanumeric characters, special characters (.!#$%&'*+/=?^_{|}~-), and domain names with multiple levels (e.g., example.com, subdomain.example.com). The pattern ensures that the email address is well-formed and follows the correct syntax.
///
/// The `Regex` class is useful for validating email addresses against the provided regular expression pattern. It can be used in conjunction with other validation logic to ensure that user input for email addresses meets the required format.
class Regex {
  static const email =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
}
