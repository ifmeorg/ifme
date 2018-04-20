import cfscrape
import sys

scraper = cfscrape.create_scraper() # returns a requests.Session object
print scraper.get(sys.argv[1]).content
