# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # p movie
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(title:movie[:title], rating:movie[:rating], release_date:movie[:release_date])
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  # fail "Unimplemented"
  l= '/' +e1 +'/'
  r= '/'+e2+'/'
  p l
  p page.body
  lindex=page.body=~/#{e1}/

  rindex=page.body=~/#{e2}/
  if lindex<rl
  p lindex
  p rindex
  
  
  
end

Then /I should (not )?see movies with titles: (.*)/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  # fail "Unimplemented"
  # p "hit"
  e2.split(",").each do |x|
    # p x
    # p e1
    steps %{
      Then I should #{e1}see #{x}
    }
  end
    
  
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # fail "Unimplemented"
  rating_list.split(",").each do |x|
    steps %{
      When I #{uncheck}check "ratings_#{x}" 
    }
  end
  
  
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  # fail "Unimplemented"
  movies=Movie.all
  movies.each do |x|
    title=x[:title]
    steps %{
      Then I should see "#{title}"
    }  
  end
end
