class ApplicationRecord < ActiveRecord::Base
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      tweet.where(['name LIKE ?', "%#{search}%"])
    else
      tweet.all #全て表示。
    end
  end
end