require 'rubygems'
require 'rest_client'

class Check

class << self; attr_accessor :contents, :cookie end

@@contents = '0L:0L0L0#0L0L:0L'

def self.check(contents = @@contents)
  begin
   RestClient.post(
          'http://icfpcontest.org/icfp10/static/j_spring_security_check',
          {:j_username => 'Waterloo Napoleons',
           :j_password => '924298343502307517055797432742370190926754651789668616888587'
          },
          {:accept => 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5',
           :accept_language => 'en-US,en;q=0.8',
           :content_type => 'application/x-www-form-urlencoded',
           :origin => 'http://icfpcontest.org',
           :referrer => 'http://icfpcontest.org/icfp10/login',
           :user_agent => 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.70 Safari/533.4'
          }
          )
  rescue => e
   @@cookie = e.response.cookies['JSESSIONID']
  end
  
  res = RestClient.post(
          'http://icfpcontest.org/icfp10/instance/219/solve',
          {:contents => contents},
          {:cookies => {:JSESSIONID => @@cookie},
           :accept => 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5',
           :accept_language => 'en-US,en;q=0.8',
           :content_type => 'application/x-www-form-urlencoded',
           :origin => 'http://icfpcontest.org',
           :referrer => 'http://icfpcontest.org/icfp10/instance/219/solve',
           :user_agent => 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.70 Safari/533.4'
          }
  )
  
  count=0
  
  res.body.each_line do |line|
      puts line.gsub(/(<[^>]+>)+/, '. ')[452..-1] if count == 13
      puts line.gsub(/(<[^>]+>)+/, ' ').gsub(/Spring.*/,'').strip if count > 13
      count += 1
  end
end
end