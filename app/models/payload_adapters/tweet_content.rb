require 'unshorten'

module PayloadAdapters

  class TweetContent

    def initialize(content, high_value_keywords = [])
      @content = content
      @high_value_keywords = high_value_keywords
    end

    def to_s
      content
    end

    def high_value?
      in_keyword_list?
    end

    def shortened_link_matcher
      /\w+.\w+\/[\S]+/
    end

    private

    attr_reader :content

    def in_keyword_list?
      @high_value_keywords.any? { |keyword| unshortened_content.include?(keyword) }
    end

    def unshortened_content
      @unshortened_content ||= begin
        unshortened = content
        shortened_links.each do |shortened_link|
          unshortened.gsub!(shortened_link, Unshorten[shortened_link])
        end
        unshortened
      end
    end

    def shortened_links
      content.scan(shortened_link_matcher).flatten
    end

  end

end
