require 'active_record'

module EasyManagement
  module Testing
    module Support
      module DatabaseConnection

        class << self

          def establish_sqlite_connection(db_file_path)
            ::ActiveRecord::Base.establish_connection adapter: 'sqlite3',
                                                      database: db_file_path
          end

        end

      end
    end
  end
end