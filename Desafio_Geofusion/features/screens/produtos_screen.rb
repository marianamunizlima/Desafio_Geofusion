class ProdutosScreen
    def initialize(browser)
        @browser = browser
        @nome = @browser.text_field(id: "owner")
        @btn_ok = @browser.button(type: "submit")
        @lista_produtos = @browser.div(id: "list")
        @btn_novo_produto = @browser.a(text: "Novo Produto")
        @busca = @browser.text_field(id: "search")
        @btn_buscar = @browser.button(css: "button[ng-click = 'searchByName()' ]")

                
        #cadastro
        @nome_produto = @browser.text_field(css: "input[ng-model = 'product.name']")
        @preco_produto = @browser.text_field(css: "input[ng-model = 'product.price']")
        @data_validade = @browser.text_field(css: "input[ng-model = 'product.expiration_date']")
        
        @calendario = @browser.div(class: 'datepicker')
        
        @move_dia = @browser.div(class: 'datepicker').div(class: 'datepicker-days').th(class: "datepicker-switch")
        @move_mes = @browser.div(class: 'datepicker').div(class: 'datepicker-months').th(class: "datepicker-switch")
        @move_ano = @browser.div(class: 'datepicker').div(class: 'datepicker-years').th(class: "datepicker-switch")        
        
        @ano = @browser.div(class: 'datepicker-years').spans(css: "span[class = 'year']")
        @mes = @browser.div(class: 'datepicker-months')
        @dia = @browser.div(class: 'datepicker-days')
        @lista_dias = @browser.div(class: 'datepicker-days').table.tbody.trs

        @btn_salvar = @browser.button(css: "button[ng-click = 'addProduct()']")
        @alert = @browser.alert

        @tabela_produtos_cadastrados = @browser.table.tbody.trs
        @btn_confirmar_exclusao = @browser.button(css: "button[ng-click = 'deleteProductByList()']")
        
   end

    def pagina_incial
        @browser.goto "desafio.geofusion.tech"        
    end          

    def preencher_dados
        texto = [*('A'..'Z')].sample(10).join
        #texto = texto + [*('A'..'Z')].sample(25).join
        @nome.wait_until_present.set(texto)
        #@nome.wait_until_present.set("Nome Sobrenome")
        @btn_ok.wait_until_present.click
    end

    def pagina_consulta_produtos?
        @lista_produtos.wait_until_present.exists?      
    end

    def buscar_produto(nome_produto)
        @busca.wait_until_present.set(nome_produto)
        @btn_buscar.wait_until_present.click
        id_produto_cadastrado = @browser.table.tbody.wait_until_present.trs.last.wait_until_present.tds.first.text        
        id_produto_cadastrado
    end
   
    def pagina_cadastro_produtos
        @btn_novo_produto.wait_until_present.click
    end

    def cadastrar_produto
        preco_rand = Random.new
        preco_rand.rand(10...30) 

         @nome_produto.wait_until_present.set("Teclado Multimídia")
         produto = @nome_produto.wait_until_present.value
                  
         @preco_produto.wait_until_present.set(preco_rand.to_s)
         
         @data_validade.wait_until_present.click       
         escolher_data_atual         
         @btn_salvar.wait_until_present.click
         @alert.ok
         produto

                  
    end

    def existe_cadastro(id)
        @lista_produtos.wait_until_present        
        vezes = 0

        if( @browser.table.tbody.trs.count > 0)
            @browser.table.tbody.tr.wait_until_present
            count = @tabela_produtos_cadastrados.count - 1
        
            (0..count).each do |i|
                if (@tabela_produtos_cadastrados[i].tds[0].wait_until_present.text == id)
                vezes = vezes + 1
                end

            end
        
        end        
        
         if(vezes > 1 )
            return true
            puts "Existe mais outro produto cadastrado com este ID: #{id}"
         else
            return false
        end

        id
                 
    end


    def escolher_data_atual
        
        day = DateTime.now
        day.strftime("%Y/%m/%d")
        
        today = Date.today
        today = today.day.to_s

        @browser.div(class: 'datepicker-days').table.tbody.tr.wait_until_present
        count = @lista_dias.count - 1
        achou = false
        
        (0..count).each do |i|

            @lista_dias[i].td.wait_until_present
            count_tds =  @lista_dias[i].wait_until_present.tds.count - 1
            (0..count_tds).each do |i_tds|
                @browser.td(css: "td[class = 'day']").wait_until_present
                #puts " Dia: #{@lista_dias[i].tds(css: "td[class = 'day']")[i_tds].text}"
                if ( @lista_dias[i].tds[i_tds].wait_until_present.text  == today )
                   #  puts" Dias + #{ @lista_dias[i].tds(css: "td[class = 'day']")[i_tds].text}
                    @lista_dias[i].tds[i_tds].wait_until_present.click
                    achou = true
                    break
                end
                if(achou == true)
                        break
                end
            end         

        end

        day
      
    end

#exclusao

    def excluir_produto(id)
        @lista_produtos.wait_until_present
        
        @browser.table.tbody.tr.wait_until_present

        count = @tabela_produtos_cadastrados.count - 1

        (0..count).each do |i|         
            if (@tabela_produtos_cadastrados[i].tds[0].wait_until_present.text == id)
                
                btn_excluir = @tabela_produtos_cadastrados[i].tds[4].wait_until_present.links[2]
                btn_excluir.click
                @btn_confirmar_exclusao.wait_until_present.click
                @alert.ok
                break

            end
        end
    
        id

    end
    
end