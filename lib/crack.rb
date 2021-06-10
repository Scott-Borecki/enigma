require './lib/enigma'

encrypted         = File.open(ARGV[0], "r")
encrypted_message = encrypted.read
encrypted.close

enigma            = Enigma.new
date              = ARGV[2] || Time.now.strftime("%d%m%y")
key               = enigma.crack(encrypted_message, date)[:key]
decrypted_message = enigma.crack(encrypted_message, date)[:decryption]

decrypted = File.open(ARGV[1], "w")
decrypted.write(decrypted_message)
decrypted.close

puts "Created #{File.basename(ARGV[1])} with the key #{key} and date #{date}"
