## Basic Credit Card Processing System

### Description

This basic Credit Card Processing System was designed with an Object Oriented approach in mind. The design favors transparency, flexibility, and extensibility, so that it could easily be built on top of in the future.

Ruby was chosen as the default language because of its Object Oriented design, pragmatism, and extensive community(while not many Gems are used for this project, there are many that may come in handy in the future). Another big reason for choosing Ruby is the programmer's familiarity with the language.

While there are many improvements that come to mind, such as a Transaction Logger, the developer has taken an Agile approach of designing and developing only for the immediate requirements. At the same time the developer made most design decisions anticipating future change. For example, the main object classes have been abstracted to allow for future extensions of the system(allowing for different payment instruments, for example). Nevertheless, there are undoubtedly further abstractions and improvements that could made to improve the maintainability and robustness of the codebase.

### Notes:

- A Transaction Logger would be essential for a more robust Credit Card Processing System as it would allow us to keep track of failed transactions for auditing purposes.
- The Luhn 10 Validation Algorithm was highly inspired from a StackOverflow answer with minor modifications.

### Getting Started

To run type the following while inside the project folder run:

  'bundle install'

then:

  'ruby ./payments.rb input.txt'

To run tests:

  'rake test'
