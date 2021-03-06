require_relative 'check'
require_relative '../report/check_report'

module FlutterRb
  # Check plugin directories structure.
  # Example: if a Flutter plugin has only Android specific code
  # but not contains iOS folder with description, then iOS build fails
  class PluginDirectoriesCheck < Check
    def name
      'PluginDirectoriesCheck'
    end

    def summary
      'Validate Flutter plugin structure'
    end

    def description
      'Check plugin directories structure in pubspec file'
    end

    def check(project)
      android_exists = !project.android_folder.nil?
      ios_exists = !project.ios_folder.nil?
      check_result = android_exists && ios_exists || !android_exists && !ios_exists
      CheckReport.new(
        name,
        check_result ? CheckReportStatus::NORMAL : CheckReportStatus::ERROR,
        description,
        project.path
      )
    end
  end
end
