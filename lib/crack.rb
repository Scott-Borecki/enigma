require_relative 'alphabetable'
require_relative 'cipher'
require_relative 'cracker'
require_relative 'dateable'
require_relative 'enigma'
require_relative 'key'
require_relative 'key_cracker'
require_relative 'offset'
require_relative 'positionable'
require_relative 'shiftable'

encrypted         = File.open(ARGV[0], 'r')
encrypted_message = encrypted.read
encrypted.close

enigma            = Enigma.new
date              = ARGV[2] || enigma.today
key               = enigma.crack(encrypted_message, date)[:key]
decrypted_message = enigma.crack(encrypted_message, date)[:decryption]

decrypted = File.open(ARGV[1], 'w')
decrypted.write(decrypted_message)
decrypted.close

puts "Created '#{File.basename(ARGV[1])}' with the cracked key #{key} and date"\
     " #{date}"
