module Inflector
  extend self
  
  module CoreExtensions
    autoload :String, 'inflector/core_ext/string'
  end
  
  class Words
    attr_reader :singulars, :plurals
    
    def initialize
      @singulars, @singular_rules = {}, []
      @plurals, @plural_rules = {}, []
    end
    
    def add(singular, plural = nil)
      plural = singular unless plural
      
      @plurals[singular] = plural
      @singulars[plural] = singular
    end
    
    def inflect(singular, plural)
      add_singular_rule(singular, plural)
      add_plural_rule(singular, plural)
    end
    
    def add_singular_rule(singular, plural)
      @singular_rules << [plural, singular]
    end
    
    def add_plural_rule(singular, plural)
      @plural_rules << [singular, plural]
    end
    
    def write_singular_rules
      return @singular_inflections if @singular_inflections
      
      rex = /(#{@singular_rules.map { |pl, si| pl }.join('|')})$/i
      hash = Hash[*@singular_rules.flatten]
      
      @singular_inflections = [rex, hash]
    end
    
    def write_plural_rules
      return @plural_inflections if @plural_inflections
      
      rex = /(#{@plural_rules.map { |si, pl| si }.join('|')})$/i
      hash = Hash[*@plural_rules.flatten]
      
      @plural_inflections = [rex, hash]
    end
    
    def self.instance
      @__instance__ ||= new
    end
  end
  
  def words
    if block_given?
      yield Words.instance
    else
      Words.instance
    end
  end
  
  def camelize(s)
    uncapitalize pascalize(s)
  end
  
  def pascalize(s)
    return s if s !~ /_/ && s =~ /[A-Z]+.*/
    s.split('_').map { |e| e.capitalize }.join
  end
  
  def constantize(s)
    const = Object
    s.split('::').each do |name|
      const = const.const_get(name)
    end
    
    const
  end
  
  def underscore(s)
    return s.downcase if s =~ /^[A-Z]+$/
    s.gsub(/([A-Z]+)(?=[A-Z][a-z]?)|\B[A-Z]/, '_\&') =~ /_*(.*)/
    return $+.downcase
  end
  
  def pluralize(s)
    inflect_word(s, words.plurals, words.write_plural_rules)
  end
  
  def singularize(s)
    inflect_word(s, words.singulars, words.write_singular_rules)
  end
  
  def uncapitalize(s)
    s[0, 1].downcase + s[1..-1]
  end
  
  private
  
  def inflect_word(word, collection, rules)
    return "" if word.empty?
    
    if r = collection[word]
      return r.dup
    end
    
    inflected_word = word.dup
    rex, hash = rules
    
    inflected_word.sub!(rex) { |m| hash[m] }
    collection[word] = inflected_word
    inflected_word
  end
  
  words do |word|
    word.add 'fish'
    word.add 'wife', 'wives'
    
    word.inflect 'ox', 'oxes'
    word.inflect 'us', 'uses'
    word.inflect '', 's'
    word.inflect 'ero', 'eroes'
    word.inflect 'rf', 'rves'
    word.inflect 'af', 'aves'
    word.inflect 'ero', 'eroes'
    word.inflect 'man', 'men'
    word.inflect 'ch', 'ches'
    word.inflect 'sh', 'shes'
    word.inflect 'ss', 'sses'
    word.inflect 'ta', 'tum'
    word.inflect 'ia', 'ium'
    word.inflect 'ra', 'rum'
    word.inflect 'ay', 'ays'
    word.inflect 'ey', 'eys'
    word.inflect 'oy', 'oys'
    word.inflect 'uy', 'uys'
    word.inflect 'y', 'ies'
    word.inflect 'x', 'xes'
    word.inflect 'lf', 'lves'
    word.inflect 'ffe', 'ffes'
    word.inflect 'afe', 'aves'
    word.inflect 'ouse', 'ouses'
  end
end
