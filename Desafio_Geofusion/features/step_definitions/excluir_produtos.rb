Dado("que tenha um produto cadastrado") do
  steps %{
        Dado que estou na tela de Cadastro de Produtos
        Quando eu cadastro os dados do produto
        Então eu posso visualizar o produto cadastrado
    }
end

Quando("eu excluo este produto") do
   @id_produto_excluido =  @page.(ProdutosScreen).excluir_produto(@id_produto)       
end

Então("ele não deve aparecer mais na lista de produtos") do
  expect(@page.(ProdutosScreen).existe_cadastro(@id_produto_excluido)).to be false
end