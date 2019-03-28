module ShortenedLinksGenerator
  module_function

  def shorten(url)
    nil

  def resource_from_file(path)
    res = []
    File.open(path) do |f|
      f.each_line do |line|
        res.push(line.strip)
      end
    end
    res
  end

  def self.adjectives
    file = File.join(File.dirname(__FILE__), 'adjectives.txt')
    @ADJECTIVES ||= resource_from_file(file)
  end

  def self.animals
    file = File.join(File.dirname(__FILE__), 'animals.txt')
    @ANIMALS ||= resource_from_file(file)
  end
end