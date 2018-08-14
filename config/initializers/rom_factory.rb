GccgFactory = ROM::Factory.configure do |config|
  config.rom = ROM.container(:sql, ENV.fetch('DATABASE_URL'), extensions: [:pg_enum])
end

factories_dir_path = File.expand_path('../../../spec/factories', __FILE__)
Pathname.glob("#{factories_dir_path}/*.rb").each { |factory| require factory }
