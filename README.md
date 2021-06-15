# Enigma

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

![The Enigma Machine and Alan Turing](https://i.dailymail.co.uk/i/pix/2018/01/07/10/47D85C4400000578-0-image-a-9_1515321060322.jpg)
(Image Source: [Daily Mail](https://www.dailymail.co.uk/news/article-5243337/Alan-Turings-code-breaking-machines-hidden-away-war.html))

**Enigma Machine** (Source: [Wikipedia](https://en.wikipedia.org/wiki/Enigma_machine) 🤷‍♂️):

> The Enigma machine is a cipher device developed and used in the early- to mid-20th century to protect commercial, diplomatic, and military communication. It was employed extensively by Nazi Germany during World War II, in all branches of the German military. The Germans believed, erroneously, that use of the Enigma machine enabled them to communicate securely and thus enjoy a huge advantage in World War II. The Enigma machine was considered to be so secure that even the most top-secret messages were enciphered on its electrical circuits.

# README

## Table of Contents

- [Overview](#overview)
- [Learning Goals](#learning-goals)
- [Tools Used](#tools-used)
- [Getting Started](#getting-started)
  - [Encrypting](#encrypting)
  - [Decrypting](#decrypting)
  - [Cracking](#cracking)
- [Self Assessment](#self-assessment)
- [Contributors](#contributors)

## Overview

[Enigma](https://github.com/Scott-Borecki/enigma) is a 5-day, solo project during Mod 1 of 4 for Turing School's Back End Engineering Program.

The challenge was to build a tool for encrypting, decrypting, and cracking an encryption algorithm based on the [Caesar Cipher](http://practicalcryptography.com/ciphers/caesar-cipher/).  

## Learning Goals

Learning goals and areas of focus consisted of:

- Practice breaking a program into logical components
- Build classes that demonstrate single responsibilities
- Test drive a well-designed Object Oriented solution
- Work with file i/o

The project home page and requirements can be found [here](https://backend.turing.edu/module1/projects/enigma/index).

## Tools Used

- Ruby 2.7.2
- RSpec
- Pry
- SimpleCov
- HoundCI
- Atom
- GitHub

## <ins>Getting Started</ins>

**Fork this repository:** [Enigma](https://github.com/Scott-Borecki/enigma)

**Clone your forked repository:** Run `git clone` with the copied URL.

### Encrypting:

Navigate to the `enigma` directory and update the `message.txt` file with the message you would like to encrypt.  

In your terminal, navigate to the `enigma` directory and run the following command to encrypt your message:

```ruby
$ ruby ./lib/encrypt.rb message.txt encrypted.txt
```

Your terminal will return a similar message to the following that reveals the randomly generated 5-digit key and date (DDMMYY) that can be shared for decrypting the message later: `Created 'encrypted.txt' with the key 82648 and date 240818`

You can view the encrypted text in the `encrypted.txt` file in the `enigma` directory.

### Decrypting:

In your terminal, navigate to the `enigma` directory and run the following command with the 5-digit key and date (DDMMYY) to decrypt your message:

```ruby
$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818
```

Your terminal will return a message similar to the following that indicates your message has been decrypted: `Created 'decrypted.txt' with the key 82648 and date 240818`

You can view the decrypted text in the `decrypted.txt` file in the `enigma` directory.

### Cracking:

You are able to crack a message without a given key, provided the message ends with the characters " end" and you know the date that the message was encrypted (or when the message was encrypted the same day you are trying to crack it).

In your terminal, navigate to the `enigma` directory and run the following command with the last element being the date (DDMMYY) of the decrypted message:

```ruby
$ ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
```

If the message was encrypted the same day you are trying to crack it, the date input is not required and the command will look like the following:

```ruby
$ ruby ./lib/crack.rb encrypted.txt cracked.txt
```

In both cases, your terminal will return a similar message to the following that indicates your message has been cracked and reveals the key used to crack it: `Created 'cracked.txt' with the cracked key 82648 and date 240818`

You can view the cracked text in the `cracked.txt` file in the `enigma` directory.

## Self Assessment

### Functionality
**Above Expectations:**
> Enigma Class with #encrypt, #decrypt, and #crack methods and command line interface successfully implemented.

### Object Oriented Programming
**Above Expecations:**
> Project is broken into logical components that are appropraitely encapsulated.  Modules are implemented to share behavior across classes.

### Ruby Conventions and Mechanics
**Meets Expectations** to **Above Expectations:** 
> Most classes, methods, and variables are well named so that they clearly communicate their purpose.  Code is all properly indented and syntax is consistent. No* methods are longer than 10 lines long.  Most enumerables/data structures chosen are the most efficient tool for a given job
> 
> *one method in the KeyCracker class is more than 10 lines long.

### Test Driven Development
**Above Expecations:**
> Every method is tested at both the unit and integration level.  Obvious edge cases are addressed.  Test coverage metrics show coverage at 99% or greater.  Mocks and/or stubs are used appropriately.

## Contributors

👤  **Scott Borecki**
- Github: [Scott-Borecki](https://github.com/Scott-Borecki)
- LinkedIn: [Scott Borecki](https://www.linkedin.com/in/scott-borecki/)

<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/scott-borecki/enigma.svg?style=flat-square
[contributors-url]: https://github.com/Scott-Borecki/enigma/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/scott-borecki/enigma.svg?style=flat-square
[forks-url]: https://github.com/scott-borecki/enigma/network/members
[stars-shield]: https://img.shields.io/github/stars/scott-borecki/enigma.svg?style=flat-square
[stars-url]: https://github.com/scott-borecki/enigma/stargazers
[issues-shield]: https://img.shields.io/github/issues/scott-borecki/enigma.svg?style=flat-square
[issues-url]: https://github.com/scott-borecki/enigma/issues
