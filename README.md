![image](https://github.com/user-attachments/assets/837be51e-e89a-4d8f-8457-470d8b45ce27)

[Walkthrough Video](https://www.linkedin.com/feed/update/urn:li:activity:7193672623833145345/)

Job Scraper for positions requiring Ruby on Rails and positions in companies with RoR base projects like FullStack Labs, Netguru, OmbuLabs, RailsCarma, RailsFactory, RubyGarage, reinteractive, thoughtbot.

Currently the app is scraping more than 10 sites and recovering, on average, 10 new positions per day making manual search unnecessary.

For this project I mounted a Selenium standalone Docker image to extract the data from the sites and develop a RoR API to manipulate it. Both services are running separately in Render.

The frontend is a React app mounted in Netlify mostly written using ChatGPT.

Every day the scraper is run to update the app with the latest positions on the sites using ElephantSQL for storage.

Taking into account that all the infrastructure is running on free tier services the cost to deploy and maintain the app is 0$.

In the future I will be adding more job sites and companies to the search.

Here is the link (it may take 50 seconds to show the results the first time you get in, it is what the Render server takes to spin-up): https://jobscrapperrubyonrails.netlify.app/
