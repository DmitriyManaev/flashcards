require "rails_helper"

describe Card do
  it "original and translated texts cannot be equal" do
    expect { Card.create!(original_text: "test",
                          translated_text: "test")
    }.to raise_error
  end

  let(:card) { FactoryGirl.create(:card,
                                  original_text: "test",
                                  translated_text: "тест")
  }

  context "created with" do
    it "correct original text" do
      expect(card.original_text).to eq("test")
    end

    it "correct translated text" do
      expect(card.translated_text).to eq("тест")
    end

    it "review date not be nil" do
      expect(card.review_date).to_not be_nil
    end

    it "review date less than currently" do
      expect(card.review_date).to be < Time.now
    end
  end

  context "check answer" do
    it "with right text" do
      expect(card.correct_answer("тест")).to be true
    end

    it "uppercase text with before and after spaces" do
      expect(card.correct_answer(" ТеСТ ")).to be true
    end

    it "with wrong text" do
      expect(card.correct_answer("тес")).to be false
    end

    it "change review date" do
      card.correct_answer("тест")
      expect(card.review_date > Time.now + 2.days).to be true
    end
  end
end
