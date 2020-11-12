class Message < ApplicationRecord
    validates :content, presence: true, length: { maximum: 255 } #validationをしている。誤りデータは model.errors変数 に格納される。model.params の変種か。つまりここでは message.errors に格納されている。
                                                                  #model.errors と複数形で書かれている通り、複数のエラーに対応可能。
end
