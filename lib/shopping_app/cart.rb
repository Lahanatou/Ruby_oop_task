require_relative "item_manager"
require_relative "ownable"

class Cart
  include Ownable
  include ItemManager
  #attr_accessor :owner la

  def initialize(owner)
    self.owner = owner
    @items = []
  end

  def items
    # Cartにとってのitemsは自身の@itemsとしたいため、ItemManagerのitemsメソッドをオーバーライドします。
    # CartインスタンスがItemインスタンスを持つときは、オーナー権限の移譲をさせることなく、自身の@itemsに格納(Cart#add)するだけだからです。
    @items
  end

  def add(item)
    @items << item
  end

  def total_amount
    @items.sum(&:price)
  end

  def check_out
    puts total_amount
    puts owner.wallet.balance
    return if owner.wallet.balance < total_amount
    owner.wallet.balance = owner.wallet.balance.withdraw(total_amount)
    #self.owner.wallet = self.owner.wallet.withdraw(total_amount)
    #item.owner.wallet.deposit(total_amount)
    #item.owner = self.owner
    @items = []
  # ## 要件
  #   - カートの中身（Cart#items）のすべてのアイテムの購入金額が、カートのオーナーのウォレットからアイテムのオーナーのウォレットに移されること。
  #   - カートの中身（Cart#items）のすべてのアイテムのオーナー権限が、カートのオーナーに移されること。
  #   - カートの中身（Cart#items）が空になること。

  # ## ヒント
  #   - カートのオーナーのウォレット ==> self.owner.wallet
  #   - アイテムのオーナーのウォレット ==> item.owner.wallet
  #   - お金が移されるということ ==> (？)のウォレットからその分を引き出して、(？)のウォレットにその分を入金するということ
  #   - アイテムのオーナー権限がカートのオーナーに移されること ==> オーナーの書き換え(item.owner = ?)
  end

end
=begin
Exigence 
  # - Le montant de l'achat de tous les 
  articles du contenu du panier (Cart#items) 
  doit être transféré du portefeuille du propriétaire
  du panier au portefeuille du propriétaire de l'article.
  # - La propriété de tous les articles du panier 
  (Cart#items) est transférée au propriétaire du panier. 
  # - Le contenu du panier (Cart#items) est vide.



  Le montant de l'achat de tous les articles du panier (Cart#items)
   est transféré du portefeuille du propriétaire du panier au portefeuille .
 ❌La propriété de tous les articles du panier (Cart#items) est transférée au propriétaire du panier.
 ❌Contenu du panier vide (Cart#items)



  Des astuces 
  # - portefeuille du propriétaire du panier ==> self.owner.wallet 
  # - Portefeuille du propriétaire de l'objet ==> item.owner.wallet 
  # - L'argent est transféré ==> Retirez ce montant du portefeuille (?) et déposez ce montant dans le portefeuille (?) 
  # - la propriété de l'article est transférée au propriétaire du panier ==> réécrire le propriétaire (item.owner = ?)

=end    
