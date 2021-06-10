require './lib/enigma'

handle  = File.open(ARGV[0], "r")
message = handle.read
handle.close

enigma            = Enigma.new
key               = enigma.generate_key # perhaps this will be abstracted from a different class?
date              = ARGV[2] || Time.now.strftime("%d%m%y")
encrypted_message = enigma.encrypt(message, key, date)[:encryption]

encrypted = File.open(ARGV[1], "w")
encrypted.write(encrypted_message)
encrypted.close

puts "Created #{File.basename(ARGV[1])} with the key #{key} and date #{date}"
