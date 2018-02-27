Dado("que estou na tela de Cadastro de Produtos") do
  steps %{
        Dado que estou na tela inicial
        Quando eu preencho os dados do formulário
        Então eu posso visualizar a tela de Consulta de Produtos
    }
    @page.(ProdutosScreen).pagina_cadastro_produtos
end

Quando("eu cadastro os dados do produto") do
    @produto_cadastrado =  @page.(ProdutosScreen).cadastrar_produto
end

Então("eu posso visualizar o produto cadastrado") do
    @id_produto =  @page.(ProdutosScreen).buscar_produto(@produto_cadastrado)       
    expect(@page.(ProdutosScreen).existe_cadastro(@id_produto)).to be false         
    
end