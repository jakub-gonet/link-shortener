class ShortenedLinksGenerator
  require 'digest/sha1'

  def self.shorten(url, adj_n = 2, animals_n = 1)
    hash = Digest::SHA1.hexdigest(url).to_i(16)
    rng = Random.new(hash)
    adjectives_s = adjectives.sample(adj_n, random: rng).join('-')
    animals_s = animals.sample(animals_n, random: rng).join('-')
    "#{adjectives_s}-#{animals_s}"
  end

  class << self
    private

    def resource_from_file(path)
      res = []
      File.open(path) do |f|
        f.each_line do |line|
          res.push(line.strip)
        end
      end
      res
    end

    def adjectives
      file = File.join(File.dirname(__FILE__), 'adjectives.txt')
      @adjectives ||= resource_from_file(file)
    end

    def animals
      file = File.join(File.dirname(__FILE__), 'animals.txt')
      @animals ||= resource_from_file(file)
    end
  end
end