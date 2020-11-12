class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]  
  
  def index
    @messages = Message.all
  end
  
  def show
    #@message = Message.find(params[:id])
    #set_message
  end
  
  def new
    @message = Message.new    #インスタンスを作成している。@messageはnew.html.erbに引き渡される。
#newの後に引数としてcontentカラムに文字列を指定しておくと、予めフォームに入力済みにしておける。 ex:) Message.new(content: 'abc')
  end

  
  def create
    @message = Message.new(message_params) #newからcreateに渡されるデータはparams[:message]に入っている（らしい、とりあえずそういうものとして進める）
                                           #これについてprivate以下のmessage_paramsメソッドで、newで指定したカラムである:content以外のデータを受け付けない旨規定する。
                                           #ここのカッコ内のmessage_paramsは上記メソッドだと思われる。こういう形でメソッド実行できるの？ <- message_paramsはnewの引数として用いられている。message_paramsの内容を適当な変数に入れてもいいが、直接でも使用可能。
                                           #ともかくnewのデータは初めcreateに来て、message_paramsの依存関係で一度そっちのメソッド定義に飛ばされ、最終的にcreateに戻ってきて@messageに入るもののよう。
    
    if @message.save  # ifによる分岐とメソッド実行を同時に行っている。成功すればtrueが返る。ここで失敗するとすればcontentカラムがvarchar(255)だったので、それを超えた場合。
      flash[:success] = 'Message が正常に投稿されました。' #flashはハッシュなので、flash{success: 'Messageが正常に投稿されました'}という形で保存される。layoutsのflashファイルへ渡される。
      redirect_to @message #ここでmessages/:idにリダイレクトされる。
    else
      flash.now[:danger] = 'Message が投稿されませんでした。'
      render :new
    end
  end #createはgetではないのでrenderの自動補完が働かないものと思われる。そのため必要に応じてrender, redirectを記述している？ <-ではない。目的に沿わないページがrenderされるため指定しているにすぎない。
  
  def edit
    #@message = Message.find(params[:id]) #new, createのペアとedit, updateのペアの違いは .new か .find か
    #set_message
  end
  
  def update
    #@message = Message.find(params[:id])
    #set_message
    
    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました。'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした。'
      render :edit
    end
  end
  
  def destroy
    #@message = Message.find(params[:id])
    #set_message
    @message.destroy
    
    flash[:success] = 'Message は正常に削除されました。'
    redirect_to messages_url #redirectのときは _path ではなく _url を使用する。削除なのでshowするものもないのでindexへ飛ぶ。
  end
  
  private #privateは、それが書かれたクラスないでのみ、private以下のメソッドを適用することを意味する。
          #Controllerに書かれているということは、以下のメソッドはルーティングから繋がるアクションではないということ。
  
  def set_message
    @message = Message.find(params[:id])
  end
  
  # Strong Parameter
  def message_params
    params.require(:message).permit(:content, :title)
  end
  


end
