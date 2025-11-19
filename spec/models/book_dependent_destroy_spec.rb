require "rails_helper"

RSpec.describe Book, type: :model do
  it "destroyで関連のsectionsとimpressionsも削除される" do
    user = create(:user)
    book = create(:book, user: user)
    section = create(:section, book: book, user: user, content: "章1")
    imp = create(:impression, section: section, user: user, body: "感想A")

    expect { book.destroy }.to change(Section, :count).by(-1)
                          .and change(Impression, :count).by(-1)

    expect(Section.exists?(section.id)).to be_falsey
    expect(Impression.exists?(imp.id)).to be_falsey
  end
end