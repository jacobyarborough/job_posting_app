class WelcomeController < ApplicationController 
  include ExceptionHandler

  def index 
    jobs_array = []
    start_val = 1
    url = "https://www.linkedin.com/jobs/search/?currentJobId=3554746024&f_TPR=r604800&geoId=103644278&keywords=ruby&location=United%20States&start=#{start_val}"

    doc = Nokogiri::HTML(URI.open(url))

    count_str = doc.css('span.results-context-header__job-count').text
    init_count = ""

    count_str.chars.each do |char|
      if char[/[0-9]+/] != nil 
        init_count += char
      end 
    end 

    init_pages = init_count.to_f / 25
    final_pages = 0 

    if init_pages < 1 
      final_pages = 1
    else 
      final_pages = init_pages.round()
    end 

    limit_page = [final_pages,25].min

    page = 1

    while page <= limit_page do 
      doc = Nokogiri::HTML(URI.open(url))
      
      job_count = 1

      doc.css('section.two-pane-serp-page__results-list').css('ul.jobs-search__results-list').first.children.each do |job_post|
        if job_count % 2 == 0
          if job_post.children[1].attributes["data-entity-urn"]
            posting_id = job_post.children[1].attributes["data-entity-urn"].value.split(":")[3]

            if job_post.css('div a') && job_post.css('div a').attribute('href') && job_post.css('div a').attribute('href').value
              page_link = job_post.css('div a').attribute('href').value.split("?")[0]
              draft_job_title = job_post.css('div a').attribute('href').value.split("/")[5].split("?")[0].split("-")
              draft_job_title.pop
              job_title = draft_job_title.join(" ")

              if job_exists(jobs_array, job_title) == false
                jobs_array << Post.new(posting_id: posting_id, post_link: page_link, post_date: nil, name: job_title, description: nil)
              end 
            end 
          end 
        end 
  
        job_count += 1
      end 

      start_val += 25
      page += 1

      sleep(10.seconds)
    end 

    @jobs = jobs_array
#     @display_posts = []

#     jobs_array.each do |posting|
#       url = posting.post_link
#       doc = Nokogiri::HTML(URI.open(url))

#       if doc.css('script').text
#         description = doc.css('script').text

#         if description.downcase.include?("ruby")
#           if doc.css('title')
#             posting.name = doc.css('title').text
#             @display_posts.push(posting)
#           end 
#         end 
#       end 

#       sleep(10.seconds)
#     end 

#     @display_posts
   end 

   def job_exists(array, title)
    titles = array.collect { |job| job.name }
    val = titles.include?(title)
    val
   end 
end 


