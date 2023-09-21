require 'rails_helper'

RSpec.feature "Paginations", type: :feature do
  Webdrivers::Chromedriver.required_version = '106.0.5249.21'
  
  xscenario "shows default number of articles" do
    FactoryBot.create_list(:article, 11)

    visit articles_path

    expect(page).to have_css "h3.title-post", count: 10
  end

  xcontext "'First' pagination control" do
    
    scenario "displays first subset of articles" do
      FactoryBot.create_list(:article, 11)

      visit articles_path(page: 2)

      expect(page).to have_link("First", href: articles_path(page: 1))
      
      click_link("First")

      expect(page).to have_content(Article.last.title)
    end

    scenario "has attribute 'pointer-event: none' on first page" do
      FactoryBot.create(:article)

      visit articles_path

      expect(page.has_css?("a", text: "First", class: "pointer-events-none")).to be(true)
    end
  end

  xcontext "'< Previous' pagination control" do 
    scenario "displays previous subset of articles when clicked" do
      FactoryBot.create_list(:article, 11)

      visit articles_path(page: 2)

      expect(page).to have_link("< Previous", href: articles_path(page: 1))
      
      click_link("< Previous")

      expect(page).to have_content(Article.last.title)
    end

    scenario "is rendered as plain text on first page, not as a link" do
      visit articles_path

      expect(page.has_css?("a", text: "< Previous", class: "pointer-events-none")).to be(true)
    end
  end

  xcontext "'Next >' pagination control" do
    scenario "switches to next subset of articles when clicked" do
      FactoryBot.create_list(:article, 11)

      visit articles_path

      expect(page).to have_link("Next >", href: articles_path(page: 2))

      click_link "Next >"

      expect(page).to have_content(Article.first.title)
    end

    scenario "is rendered as plain text on last page, not as a link" do
      FactoryBot.create_list(:article, 11)

      visit articles_path(page: 2)
      
      expect(page.has_css?("a", text: "Next >", class: "pointer-events-none")).to be(true)
    end
  end

  xcontext "'Last' pagination control" do
    scenario "displays last subset of articles" do
      FactoryBot.create_list(:article, 11)

      visit articles_path

      expect(page).to have_link("Last", href: articles_path(page: 2))

      click_link("Last")

      expect(page).to have_content(Article.first.title)
    end

    scenario "is rendered as plain text on last page, not as a link" do
      visit articles_path

      expect(page.has_css?("a", text: "Last", class: "pointer-events-none")).to be(true)
    end
  end

  xcontext "when selecting" do
    scenario "10 per page, 10 articles are displayed", js: true do
      FactoryBot.create_list(:article, 11)

      visit articles_path(per_page: "all")

      expect(page).to have_css("h3.title-post", count: 11)

      select('10', from: 'per-page-selector')

      expect(page).to have_css("h3.title-post", count: 10)
    end

    scenario "25 per page, 25 articles are displayed", js: true do
      FactoryBot.create_list(:article, 25)

      visit articles_path

      select('25', from: 'per-page-selector')

      expect(page).to have_css("h3.title-post", count: 25)
    end

    scenario "50 per page, 50 articles are displayed", js: true do
      FactoryBot.create_list(:article, 50)

      visit articles_path

      select('50', from: 'per-page-selector')

      expect(page).to have_css("h3.title-post", count: 50)
    end

    scenario "100 per page, 100 articles are displayed", js: true do
      FactoryBot.create_list(:article, 100)

      visit articles_path

      select('100', from: 'per-page-selector')

      expect(page).to have_css("h3.title-post", count: 100)
    end

    scenario "all, all articles are displayed", js: true do
      FactoryBot.create_list(:article, 15)

      visit articles_path

      select('all', from: 'per-page-selector')

      expect(page).to have_css("h3.title-post", count: 15)
    end
  end

  xscenario "if an invalid page param is input in the url the first page should be shown" do
    FactoryBot.create_list(:article, 15)

    visit articles_path(:page => "foobar")

    expect(page).to have_css("h3.title-post", count: 10)
    expect(page.status_code).to eq(200)
  end
end