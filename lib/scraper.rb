require 'nokogiri'
require 'open-uri'
require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
  def get_page
    html = open('http://learn-co-curriculum.github.io/site-for-scraping/courses')
    doc = Nokogiri::HTML(html)
  end

  def get_courses
    get_page.css('.posts-holder')
  end

  def make_courses
    get_courses.css('h2').map do |title|
      course = Course.new
      course.title = title.text
      course.schedule = get_courses.css('.date').text
      course.description = get_courses.css('p').text
      course
    end
  end
end



