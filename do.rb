require 'rubygems'
require 'rest_client'


# FILL COOKIE from you browser once you login at icfp

#        |             here               |
COOKIE = '1EBAB90FAB4B136411C56C883F53674E'

CONTENTS = '0L:0L0L0#0L0L:0L'

#RestClient.proxy = 'http://127.0.0.1:8888/' #proxy through Fiddler2

res = RestClient::Request.new(
        :method => :post,
        :url => 'http://icfpcontest.org/icfp10/instance/219/solve',
        :payload => {:contents => CONTENTS},
        :headers =>
            {:cookies => {:JSESSIONID => COOKIE},
             :accept => 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5',
             :accept_language => 'en-US,en;q=0.8',
             :content_type => 'application/x-www-form-urlencoded',
             :origin => 'http://icfpcontest.org',
             :referrer => 'http://icfpcontest.org/icfp10/instance/219/solve',
             :user_agent => 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.70 Safari/533.4'
            }
)

res = res.execute

count=0

res.body.each_line do |line|
    puts line.gsub(/(<[^>]+>)+/, '')[426..-1] if count == 13
    puts line.gsub(/(<[^>]+>)+/, '').gsub(/Spring.*/,'').strip if count > 13
    count += 1
end