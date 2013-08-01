require 'reek/source/source_locator'
require 'reek/examiner'
require 'rexml/document'
require 'pathname'

class Reek::CheckstyleFormatter
  REXML_PRETTY_PRINT_INDENT = 0

  attr_accessor :glob_pattern, :output, :smell_doc_url, :smell_severities

  # @param [Hash] opts
  # @option opts [String] :glob_pattern Glob pattern (absolute path) for files to analyse
  # @option opts [String] :output File path for checkstyle xml output
  # @option opts [String] :smell_doc_url URL to code smell documentation (reek wiki)
  # @option opts [Hash] :smell_severities Mapping of smell subclasses to checkstyle severity
  def initialize(opts = {})
    @glob_pattern = opts[:glob_pattern]
    @output = opts[:output]
    @smell_doc_url = opts[:smell_doc_url]
    @smell_severities = opts[:smell_severities] || {}
  end

  def run
    puts "Generating Reek Checkstyle XML #{self.inspect}"
    files = Dir.glob(@glob_pattern)
    sources = Reek::Source::SourceLocator.new(files).all_sources
    examined_files = sources.map {|src| Reek::Examiner.new(src, []) }
    document = to_checkstyle(examined_files)
    Pathname.new(@output).dirname.mkpath
    File.open(@output, 'w+') do |file|
      document.write(file, REXML_PRETTY_PRINT_INDENT)
    end
    puts "Reek Checkstyle XML written to #{self.output}"
  end

  def to_checkstyle(examined_files)
    REXML::Document.new.tap do |document_node|
      document_node << REXML::XMLDecl.new
      REXML::Element.new('checkstyle', document_node).tap do |checkstyle_node|
        examined_files.each do |examined_file|
          add_file(checkstyle_node, examined_file)
        end
      end
    end
  end

  def add_file(checkstyle_node, examined_file)
    if examined_file.smells.length > 0
      REXML::Element.new('file', checkstyle_node).tap do |file_node|
        file_node.attributes['name'] = File.join(examined_file.description)
        examined_file.smells.each do |smell|
          if smell.status['is_active']
            [*smell.location['lines']].each do |line|
              add_smell(file_node, smell, line)
            end
          end
        end
      end
    end
  end

  def add_smell(file_node, smell, line)
    REXML::Element.new('error', file_node).tap do |error|
      error.attributes['line'] = line
      error.attributes['column'] = 0
      error.attributes['severity'] = smell_severity(smell)
      error.attributes['message'] = smell_message(smell)
      #error.attributes['source'] = File.join(@project_dir, smell.source)
    end
  end

  def smell_message(smell)
    "<em>#{smell_anchor(smell)}</em> - #{smell.message}"
  end

  def smell_anchor(smell)
    url = smell_url(smell)
    "<a href='#{url}'>#{smell.smell['subclass']}</a>"
  end

  def smell_url(smell)
    smell_page_name = (smell.smell['subclass']).scan(/[A-Z][^A-Z]*/).join('-')
    [@smell_doc_url, smell_page_name].join("/")
  end

  def smell_severity(smell)
    @smell_severities[smell.smell['subclass']] || 'warning'
  end
end
