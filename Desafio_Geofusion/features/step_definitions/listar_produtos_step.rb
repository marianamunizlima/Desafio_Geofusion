Dado("que estou na tela inicial") do
  @page.(ProdutosScreen).pagina_incial
end

Quando("eu preencho os dados do formulário") do 
  @page.(ProdutosScreen).preencher_dados
end

Então("eu posso visualizar a tela de Consulta de Produtos") do
  expect(@page.(ProdutosScreen).pagina_consulta_produtos?).to be true
end