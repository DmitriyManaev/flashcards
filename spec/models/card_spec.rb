require 'rails_helper'

describe Card do
  it "original and translated texts cannot be equal" do
    expect { Card.create!(original_text: "test", translated_text: "test") }.to raise_error
  end

  let(:card) { Card.create!(original_text: "test", translated_text: "тест") }

  it "correct created" do
    expect(card.original_text).to eq("test")
    expect(card.translated_text).to eq("тест")
    expect(card.review_date).to_not be_nil
    expect(card.review_date).to be < Time.now
  end

  it "checked answer and changed review date" do
    expect(card.correct_answer("тест")).to be true
    expect(card.correct_answer(" Тест")).to be true
    expect(card.correct_answer("тЕСТ ")).to be true
    expect(card.correct_answer("тес")).to be false
    expect(card.review_date > Time.now + 2.days).to be true
  end
end
