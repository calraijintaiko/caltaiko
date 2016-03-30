require 'rails_helper'

describe Article do
  it 'has a valid factory' do
    expect(create(:article)).to be_valid
  end
  it 'is invalid without a title' do
    expect(build(:article, title: nil)).to_not be_valid
  end
  it 'is invalid without a date' do
    expect(build(:article, date: nil)).to_not be_valid
  end
  it 'is invalid without text' do
    expect(build(:article, text: nil)).to_not be_valid
  end

  it 'can retrieve the properly formatted date' do
    article = build(:article, date: Date.new(2016, 06, 19))
    expect(article.safe_date).to eq 'June 19, 2016'
  end

  describe 'getting all current articles' do
    it 'returns all articles marked current' do
      created_current = create_list(:article, 14, current: true)
      expect(Article.current).to match_array created_current
    end
  end

  describe 'generating a slug' do
    before :each do
      @go_us = create(:article, title: 'cal taiko the best')
      @go_us_again = create(:article, title: 'Cal Taiko the Best',
                                      date: Time.zone.local(2014))
      @keep_going_us = create(:article, title: 'Cal taIKO THE best',
                                        date: Time.zone.local(2014, 3, 25))
    end

    context 'no other article by same name exists' do
      it 'uses title as slug' do
        expect(@go_us.slug).to eq('cal-taiko-the-best')
      end
    end

    context 'article by same name already exists' do
      it 'uses title-year as slug' do
        expect(@go_us_again.slug).to eq('cal-taiko-the-best-2014')
      end
    end

    context 'article by same name and same year already exists' do
      it 'uses title-year-month-day as slug' do
        expect(@keep_going_us.slug).to eq('cal-taiko-the-best-2014-03-25')
      end
    end
  end

  describe 'getting a snippet of the article text' do
    context 'when the first paragraph is shorter than 500 characters' do
      it 'returns the first paragraph of the article' do
        text = "First paragraph\r\n\r\nSecond paragraph\r\n\r\nThird"
        article = create(:article, text: text)
        expect(article.snippet).to eq 'First paragraph'
      end
    end

    context 'the first paragraph is longer than 500 characters' do
      it 'returns the first 500 characters of the paragraph' do
        par1 = 'The first paragraph of this article is quite long; indeed, ' \
          'one might even say it is too long. Unfortunately, that cannot be ' \
          'helped, as the point of this test is to ensure that even when ' \
          'the first paragraph is very, very long, the correct snippet is ' \
          'still generated. How sad! If only there were some way to properly' \
          'test this code without such an ugly block of text polluting this ' \
          'beautiful spec. If you happen to find a way, definitely let me ' \
          'know, so this monstrosity of a test can be made more beautiful ' \
          'and I can sleep easier at night. Oh how it hurts to look upon ' \
          'such ugliness, and know that it is I who gave it life!'
        article = create(:article, text: par1 + "\r\n\r\npar2")
        expect(article.snippet).to include par1[0, 500]
        expect(article.snippet).to_not include par1[500..-1]
      end
    end
  end
end
