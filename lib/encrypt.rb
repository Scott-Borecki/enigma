require_relative 'enigma'
require_relative 'dateable'

handle  = File.open(ARGV[0], 'r')
message = handle.read.downcase
handle.close

enigma            = Enigma.new
key               = enigma.keys # perhaps abstract from other class?
date              = ARGV[2] || enigma.today
encrypted_message = enigma.encrypt(message, key, date)[:encryption]

encrypted = File.open(ARGV[1], 'w')
encrypted.write(encrypted_message)
encrypted.close

puts "Created #{File.basename(ARGV[1])} with the key #{key} and date #{date}"
