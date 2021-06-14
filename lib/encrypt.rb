require_relative 'modules/alphabetable'
require_relative 'modules/dateable'
require_relative 'modules/positionable'
require_relative 'modules/shiftable'
require_relative 'cipher'
require_relative 'enigma'
require_relative 'key'
require_relative 'offset'

handle  = File.open(ARGV[0], 'r')
message = handle.read.downcase
handle.close

enigma            = Enigma.new
date              = ARGV[2] || enigma.today
key               = rand(99999).to_s.rjust(5, '0')
encrypted_hash    = enigma.encrypt(message, key, date)
encrypted_message = encrypted_hash[:encryption]
key               = encrypted_hash[:key]
date              = encrypted_hash[:date]

encrypted = File.open(ARGV[1], 'w')
encrypted.write(encrypted_message)
encrypted.close

puts "Created '#{File.basename(ARGV[1])}' with the key #{key} and date #{date}"
