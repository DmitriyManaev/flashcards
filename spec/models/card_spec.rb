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
    it "uppercase text with before and after spaces" do
      expect(card.correct_answer(" ТеСТ ")).to be true
    end

    it "wrong text" do
      expect(card.correct_answer("тес")).to be false
    end

    it "right text" do
      expect(card.correct_answer("тест")).to be true
    end

    context "with right text" do
      before do
        card.correct_answer("тест")
      end

      it "check_number equal 1" do
        expect(card.check_number).to eq(1)
      end

      it "failed_attempts equal 0" do
        expect(card.failed_attempts).to eq(0)
      end

      it "change added 12 hours to review date" do
        expect(card.review_date > Time.now + 11.hours).to be true
      end
    end

    context "with wrong text" do
      before do
        card.correct_answer("тес")
      end

      it "failed_attempts equal 1" do
        expect(card.failed_attempts).to eq(1)
      end

      it "check_number equal 0" do
        expect(card.check_number).to eq(0)
      end
    end

    context "wrong answer more than 3 times in a row" do
      let(:card) { FactoryGirl.create(:card,
                                      translated_text: "тест",
                                      review_date: Time.now + 7.days,
                                      check_number: 3,
                                      failed_attempts: 3)
      }

      before do
        card.correct_answer("тес")
      end

      it "failed_attempts equal 0" do
        expect(card.failed_attempts).to eq(0)
      end

      it "check_number equal 0" do
        expect(card.check_number).to eq(0)
      end

      it "review_date less than 13 hours" do
        expect(card.review_date < Time.now + 13.hours).to be true
      end

      it "review_date more than 11 hours" do
        expect(card.review_date > Time.now + 11.hours).to be true
      end
    end

    context "sixth or more checking" do
      let(:card) { FactoryGirl.create(:card,
                                      translated_text: "тест",
                                      review_date: Time.now + 28.days,
                                      check_number: 5)
      }

      before do
        card.correct_answer("тест")
      end

      it "review_date more than 27 days" do
        expect(card.review_date > Time.now + 27.days).to be true
      end

      it "review_date less than 29 days" do
        expect(card.review_date < Time.now + 29.days).to be true
      end
    end
  end
end
