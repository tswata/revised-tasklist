class Task < ApplicationRecord
  validates :content, presence: true, length:{maximum:255}
  validates :status, presence: true, inclusion:{in: %w(未着手 対応中 完了)}
  validates :limit, presence: true


#updateのときには期限が過去のままでもいいようにしたいのですが、うまくいきません
 #validate :date_cannnot_be_in_the_past on: :new

  #def date_cannnot_be_in_the_past
    #if date/present? && date < Date.today
      #errors.add(:date, "：過去は入力できません")
   # end
  #end
end
