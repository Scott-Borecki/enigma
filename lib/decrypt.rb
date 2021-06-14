require_relative 'alphabetable'
require_relative 'cipher'
require_relative 'dateable'
require_relative 'enigma'
require_relative 'key'
require_relative 'offset'
require_relative 'positionable'
require_relative 'shiftable'

encrypted         = File.open(ARGV[0], 'r')
encrypted_message = encrypted.read
encrypted.close

enigma            = Enigma.new
key               = ARGV[2]
date              = ARGV[3]
decrypted_message = enigma.decrypt(encrypted_message, key, date)[:decryption]

decrypted = File.open(ARGV[1], 'w')
decrypted.write(decrypted_message)
decrypted.close

puts "Created '#{File.basename(ARGV[1])}' with the key #{key} and date #{date}"
