require "rails_helper"

describe Card do
  let(:user) { FactoryGirl.create(:user) }

  it "original and translated texts cannot be equal" do
    expect { Card.create!(original_text: "test",
                          translated_text: "test")
    }.to raise_error
  end

  let(:pack) { FactoryGirl.create(:pack) }
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
    GOOD_ANSWER_TIME = 6
    BAD_ANSWER_TIME = 15

    it "uppercase text with before and after spaces" do
      expect(card.correct_answer(" ТеСТ ", GOOD_ANSWER_TIME)).to be true
    end

    it "wrong text" do
      expect(card.correct_answer("те", GOOD_ANSWER_TIME)).to be false
    end

    it "right text" do
      expect(card.correct_answer("тест", GOOD_ANSWER_TIME)).to be true
    end

    context "with right text and GOOD answer time" do
      before do
        card.correct_answer("тес", GOOD_ANSWER_TIME)
      end

      it "number_of_review equal 1" do
        expect(card.number_of_review).to eq(1)
      end

      it "added more then 23 hours to review date" do
        expect(card.review_date > Time.now + 23.hours).to be true
      end

      it "added less then 25 hours to review date" do
        expect(card.review_date < Time.now + 25.hours).to be true
      end

      it "interval_to_review equal 1" do
        expect(card.interval_to_review).to eq(1)
      end

      it "E-factor between 1.3 and 2.5" do
        expect(card.e_factor).to be_between(1.3, 2.5)
      end
    end

    context "with right text and BAD answer time" do
      before do
        card.correct_answer("тес", BAD_ANSWER_TIME)
      end

      it "interval_to_review equal 0" do
        expect(card.interval_to_review).to eq(0)
      end

      it "review_date equal current time" do
        expect(card.review_date < Time.now + 1.hours).to be true
      end

      it "E-factor between 1.3 and 2.5" do
        expect(card.e_factor).to be_between(1.3, 2.5)
      end
    end

    context "with wrong text and number_of_review equal 2" do
      let(:card) { FactoryGirl.create(:card,
                                      original_text: "test",
                                      translated_text: "тест",
                                      number_of_review: 2,
                                      interval_to_review: 6)
      }

      before do
        card.correct_answer("те", GOOD_ANSWER_TIME)
      end

      it "interval to review equal 0" do
        expect(card.interval_to_review).to eq(0)
      end

      it "number of review equal 0" do
        expect(card.number_of_review).to eq(0)
      end

      it "review_date equal current time" do
        expect(card.review_date < Time.now + 1.hours).to be true
      end

      it "E-factor between 1.3 and 2.5" do
        expect(card.e_factor).to be_between(1.3, 2.5)
      end
    end

    context "with right text and number_of_review equal 2" do
      let(:card) { FactoryGirl.create(:card,
                                      original_text: "test",
                                      translated_text: "тест",
                                      number_of_review: 2,
                                      interval_to_review: 6)
      }

      before do
        card.correct_answer("тест", GOOD_ANSWER_TIME)
      end

      it "number of review equal 0" do
        expect(card.number_of_review).to eq(3)
      end

      it "E-factor between 1.3 and 2.5" do
        expect(card.e_factor).to be_between(1.3, 2.5)
      end
    end
  end
end
