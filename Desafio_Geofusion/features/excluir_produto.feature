# language: pt

@exclusao_produtos

Funcionalidade: Exclusão de Produtos

@produto_excluido
Cenário: Validar exclusão de produtos
Dado que tenha um produto cadastrado
Quando eu excluo este produto
Então ele não deve aparecer mais na lista de produtos

