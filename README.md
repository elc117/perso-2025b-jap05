# Webservice em Haskell
 ## Identificação:
  - José Arthur Paim Perius (Sistemas de Informação)
  
 ## Tema do trabalho:
  A proposta do trabalho é um webservice de leitura, com a chamada aleatória de informações de uma lista de dados preexistente.
  Nesse caso, o código acessa uma lista de veículos blindados(tanques de guerra) e suas informações, sendo elas:
  #### Nome do veículo;
  #### Nacionalidade do veículo;
  #### Calibre do armamento;

  A ideia por trás desse projeto vem do meu interesse por veículos históricos usados nos campos de batalha, portanto, decidi me inspirar no exemplo de sorteio aleatório e adaptá-lo a essa temática, modificando também a estrutura da informação a ser exibida, deixando de ser uma única string para uma sequência de informações.

  ## Desenvolvimento:
  A etapa de desenvolvimento teve seu primeiro obstáculo na hora de instalar o framework Scotty localmente, depois de algumas tentativas e erros, a solução encontrada foi declarar de forma global a localização dos arquivos do Cabal, já que o sistema não estava conseguindo localizá-los automaticamente. 
  Posteriormente, durante o desenvolvimento do código, o principal erro foi a forma na qual os dados estavam sendo exibidos ao usuário, minha ideia inicial era exibir o nome, nação e calibre, nessa ordem, porém devido a forma na qual a conversão ToJSON é realizada, isso não estava sendo possível, pois a ordem de exibição automática era alfabética.
  ```Bash
  instance ToJSON Tanque
  ```
  A converção automática para JSON não era capaz de definir uma ordem específica para a exibição dos dados, então a solução foi utilizar uma converção manual:
  ```Bash
  instance ToJSON Tanque where
  toJSON (Tanque nome' nacao' calibre') =
    object [ "nome"    .= nome'
           , "nação"   .= nacao'
           , "calibre" .= calibre'
           , "versao"  .= ("2.0" :: String) 
           ]
  
  toEncoding (Tanque nome' nacao' calibre') =
    pairs ( "nome"    .= nome'
         <> "nação"   .= nacao'
         <> "calibre" .= calibre'
         <> "versao"  .= ("2.0" :: String)
          )
  ```

 O uso do toEncoding com pairs se mostrou necessário para garantir a ordem de exibição dado que o object utiliza um HashMap para percorrer os dados, tornando-o incapaz de ordenar as informações de forma específica.
 
 ## Resultado:
 ![Video exibição](https://github.com/user-attachments/assets/af78ae7d-1b00-44f7-bca0-894f46907a10)

 ## Referências:
 - https://stackoverflow.com/questions/37865388/haskell-generating-json-with-aeson-gives-incorrect-order-of-fields
 - https://www.reddit.com/r/haskell/comments/10qv38v/help_with_json_parsing_in_haskell/
 - https://www.youtube.com/watch?v=psTTKGj9G6Y
 - https://www.reddit.com/r/haskell/comments/1fzs9jl/cabal_can_not_build_scotty/


 
