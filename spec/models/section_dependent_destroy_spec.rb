require "rails_helper"

RSpec.describe Section, type: :model do
  it "destroyで関連のimpressionsも削除される、bookは削除されないこと" do
    user = create(:user)
    book = create(:book, user: user)
    section = create(:section, book: book, user: user, content: "章1")
    imp = create(:impression, section: section, user: user, body: "感想A")

    expect { Section.destroy(section.id)}.to change(Impression, :count).by(-1)
                          .and change(Book, :count).by(0)

    expect(Impression.exists?(imp.id)).to be_falsey
  end
end