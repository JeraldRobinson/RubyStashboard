def full_title(page_title)
  base_title = "Stashboard"  
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end


def get_past_days(num=4)
  today=DateTime.now
  dates=Array.new
  (0..num).each do |n|
    dates.push(today-n)
  end
  return dates
end

def random_status
  return Status.all.sort_by{rand}.slice(1)
end