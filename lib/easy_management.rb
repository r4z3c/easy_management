require "easy_management/version"

module EasyManagement

  class << self

    def management_templates_path
      File.join lib_path, 'templates'
    end

    def lib_path
      File.join root_path, 'lib', 'easy_management'
    end

    def root_path
      Gem::Specification.find_by_name('easy_management').gem_dir
    end

  end

end
